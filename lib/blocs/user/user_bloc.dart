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
    switch(event.runtimeType){
      case AddAccessToken:
        _addAccessToken(event as AddAccessToken);
        yield _currentNewState;
      break;
      case AddUserInformation:
        _addUserInformation(event as AddUserInformation);
        yield _currentNewState;
      break;
      case ResetUserInformation:
        await _resetUserInformation();
        yield _currentNewState;
      break;
    }
  }

  void _addAccessToken(AddAccessToken event){
    _currentNewState = state.copyWith(
      accountStep: AccountStep.WITH_ACCESS_TOKEN,
      accessToken: event.accessToken
    );
  }

  void _addUserInformation(AddUserInformation event){
    _currentNewState = state.copyWith(
      accountStep: AccountStep.LOGGED,
      user: event.user
    );
  }

  Future<void> _resetUserInformation()async{
    _currentNewState = state.copyWith(
      accountStep: AccountStep.UNLOGGED,
      user: null
    );
  }

}
