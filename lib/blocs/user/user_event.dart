part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class SetAccessToken extends UserEvent{
  final String accessToken;

  SetAccessToken({
    @required this.accessToken
  });
}

class SetUserInformation extends UserEvent{
  final User user;

  SetUserInformation({
    @required this.user
  });
}

class ResetUserInformation extends UserEvent{

}

