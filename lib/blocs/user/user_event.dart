part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

abstract class UserEventWithOnlyAccessTokenBody extends UserEvent{
  final String accessToken;

  UserEventWithOnlyAccessTokenBody({
    @required this.accessToken
  });
}

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

class Register extends UserEvent{
  final String name;
  final String email;
  final String password;
  final String confirmedPassword;

  Register({
    @required this.name,
    @required this.email,
    @required this.password,
    @required this.confirmedPassword
  });
}

class Login extends UserEvent{
  final String email;
  final String password;

  Login({
    @required this.email,
    @required this.password
  });
}

class GetUserInformation extends UserEventWithOnlyAccessTokenBody{
  GetUserInformation({
    @required String accessToken
  }):
    super(accessToken: accessToken)
    ;
}

class RefreshAccessToken extends UserEventWithOnlyAccessTokenBody{
  RefreshAccessToken({
    @required String accessToken
  }):
    super(accessToken: accessToken)
    ;
}

class Logout extends UserEventWithOnlyAccessTokenBody{
  Logout({
    @required String accessToken
  }):
    super(accessToken: accessToken)
    ;
}

