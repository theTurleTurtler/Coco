import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:coco/enums/account_step.dart';
import 'package:coco/models/user.dart';
import 'package:coco/services/user_service.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService _userService = UserService();
  UserState _currentNewState;

  UserBloc() : super(UserState());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if(event is SetAccessToken){
      _addAccessToken(event);
      yield _currentNewState;
      event.onAccessTokenYielded();
      return;
    }else if(event is SetUserInformation){
      _addUserInformation(event);
      yield _currentNewState;
      event.onUserInformationLoaded();
      return;
    }else if(event is ResetUserInformation){
      _resetUserInformation();
      yield _currentNewState;
    }
  }

  void _addAccessToken(SetAccessToken event){
    _currentNewState = state.copyWith(
      accountStep: AccountStep.WITH_ACCESS_TOKEN,
      accessToken: event.accessToken
    );
  }

  void _addUserInformation(SetUserInformation event){
    _currentNewState = state.copyWith(
      accountStep: AccountStep.LOGGED,
      user: event.user
    );
  }

  Future<void> _resetUserInformation()async{
    _currentNewState = state.reset();
  }

}
