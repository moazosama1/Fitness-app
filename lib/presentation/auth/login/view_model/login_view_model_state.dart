part of 'login_view_model.dart';

class LoginViewModelState extends Equatable {
  const LoginViewModelState({this.loginState});
  final BaseState<UserEntity>? loginState;

  LoginViewModelState copyWith({BaseState<UserEntity>? loginState}) {
    return LoginViewModelState(loginState: loginState ?? this.loginState);
  }

  @override
  List<Object?> get props => [loginState];
}
