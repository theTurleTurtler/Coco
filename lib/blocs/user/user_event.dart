part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class AddAccessToken extends UserEvent{
  final String accessToken;

  AddAccessToken({
    @required this.accessToken
  });
}

class AddUserInformation extends UserEvent{
  final User user;

  AddUserInformation({
    @required this.user
  });
}

class ResetUserInformation extends UserEvent{

}

