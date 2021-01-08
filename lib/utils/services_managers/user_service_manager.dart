import 'package:coco/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coco/errors/services/service_status_err.dart';
import 'package:coco/blocs/user/user_bloc.dart';
import 'package:coco/utils/size_utils.dart';
import 'package:coco/pages/casos_home_page.dart';
import 'package:coco/services/user_service.dart';
import 'package:coco/models/user.dart';

final SizeUtils _sizeUtils = SizeUtils();

Future<void> manageLoginProccess(BuildContext context, String email, String password)async{
  try{
    final UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    final String accessToken = await _login(userBloc, email, password);
    await _addUserInformation(userBloc, accessToken);
    Navigator.of(context).pushReplacementNamed(CasosHomePage.route);
  }on ServiceStatusErr catch(err){
    _mostrarErrorDialog(context, err);
  }catch(err){
    _mostrarErrorDialog(context, ServiceStatusErr(message: err.toString()));
  }
}

Future<String> _login(UserBloc userBloc, String email, String password)async{
  final Map<String, dynamic> bodyData = {
    'email':email,
    'password':password
  };
  final Map<String, dynamic> response = await userService.login(bodyData);
  final String accessToken = _addAccessTokenFromResponse(userBloc, response);
  return accessToken;
}

Future<void> manageRegisterProcess(BuildContext context, Map<String, dynamic> registerInformation)async{
  try{
    final UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    final String accessToken = await _register(userBloc, registerInformation);
    await _addUserInformation(userBloc, accessToken);
    Navigator.of(context).pushReplacementNamed(CasosHomePage.route);
  }on ServiceStatusErr catch(err){
    _mostrarErrorDialog(context, err);
  }catch(err){
    _mostrarErrorDialog(context, ServiceStatusErr(message: err.toString()));
  }
}

Future<String> _register(UserBloc userBloc, Map<String, dynamic> registerInformation)async{
  final Map<String, dynamic> response = await userService.register(registerInformation);
  final String accessToken = _addAccessTokenFromResponse(userBloc, response);
  return accessToken;
}

String _addAccessTokenFromResponse(UserBloc userBloc, Map<String, dynamic> response){
  final String accessToken = response['data']['original']['access_token'];
  final UserEvent addAccessTokenEvent = SetAccessToken(accessToken: accessToken);
  userBloc.add(addAccessTokenEvent);
  return accessToken;
}

Future<void> _addUserInformation(UserBloc userBloc, String accessToken)async{
  final Map<String, dynamic> bodyData = {'token':accessToken};
  final Map<String, dynamic> response = await userService.getUserInformation(bodyData);
  final Map<String, dynamic> userInformation = response['data']['original'];
  final User user = User.fromJson(userInformation);
  final UserEvent addUserInformationEvent = SetUserInformation(user: user);
  userBloc.add(addUserInformationEvent);
}

void _mostrarErrorDialog(BuildContext context, ServiceStatusErr err){
  final dynamic extraInformation = err.extraInformation;
  String message;
  if(extraInformation.runtimeType == String)
    message = extraInformation;
  else
    message = err.message;
  showDialog(
    context: context,
    useSafeArea: false,
    child: Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: _sizeUtils.xasisSobreYasis * 0.005),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: _sizeUtils.xasisSobreYasis * 0.02),
        height: _sizeUtils.xasisSobreYasis * 0.35,
        child: Center(
          child: Text(
            message,
            style: TextStyle(
              color: Colors.black87,
              fontSize: _sizeUtils.titleSize
            ),
          ),
        ),
      ),
    )
  );
}

Future<void> manageLogoutProccess(BuildContext context, String navigationRoute)async{
  try{
    final UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    final String accessToken = userBloc.state.accessToken;
    print('access token en logout: ${accessToken}');
    await _logout(context, userBloc, accessToken);
    Navigator.of(context).pushReplacementNamed(navigationRoute);
  } catch(err){
    Navigator.of(context).pushReplacementNamed(navigationRoute);
  }
  
}

Future<void> _logout(BuildContext context, UserBloc userBloc, String accessToken)async{
  Map<String, dynamic> bodyData = {'token':accessToken};
  final Map<String, dynamic> response = await userService.logout(bodyData);
}