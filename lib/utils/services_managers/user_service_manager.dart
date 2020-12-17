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
    throw err;
  }
}

Future<String> _login(UserBloc userBloc, String email, String password)async{
  final Map<String, dynamic> bodyData = {
    'email':email,
    'password':password
  };
  final Map<String, dynamic> response = await userService.login(bodyData);
  final String accessToken = response['data']['original']['access_token'];
  final UserEvent addAccessTokenEvent = AddAccessToken(accessToken: accessToken);
  userBloc.add(addAccessTokenEvent);
  return accessToken;
}

Future<void> _addUserInformation(UserBloc userBloc, String accessToken)async{
  final Map<String, dynamic> bodyData = {'token':accessToken};
  final Map<String, dynamic> response = await userService.getUserInformation(bodyData);
  final Map<String, dynamic> userInformation = response['data']['original'];
  final User user = User.fromJson(userInformation);
  final UserEvent addUserInformationEvent = AddUserInformation(user: user);
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
    child: Dialog(
      child: Container(
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