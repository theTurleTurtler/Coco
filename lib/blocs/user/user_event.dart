part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class SetAccessToken extends UserEvent{
  final String accessToken;
  final Function onAccessTokenYielded;
  SetAccessToken({
    @required this.accessToken,
    @required this.onAccessTokenYielded
  });
}

class SetUserInformation extends UserEvent{
  final User user;
  final Function onUserInformationLoaded;
  SetUserInformation({
    @required this.user,
    @required this.onUserInformationLoaded
  });
}

class ResetUserInformation extends UserEvent{

}

