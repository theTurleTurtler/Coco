part of 'user_bloc.dart';

@immutable
class UserState {
  final AccountStep accountStep;
  final String accessToken;
  final User user;

  UserState({
    AccountStep accountStep,
    String accessToken,
    User user
  }):
    this.accountStep = accountStep??AccountStep.UNLOGGED,
    this.accessToken = accessToken??null,
    this.user = user??null
    ;

  UserState copyWith({
    AccountStep accountStep,
    String accessToken,
    User user
    
  }) => UserState(
    accountStep: accountStep??this.accountStep,
    accessToken: accessToken??this.accessToken,
    user: user??this.user
  );

  UserState reset() => UserState();
}
