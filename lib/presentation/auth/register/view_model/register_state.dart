part of 'register_view_model.dart';

final class RegisterState extends Equatable {
  final BaseState<UserEntity>? registerState;

  const RegisterState({this.registerState});

  RegisterState copyWith({BaseState<UserEntity>? registerState}) {
    return RegisterState(registerState: registerState ?? this.registerState);
  }

  @override
  List<Object?> get props => [registerState];
}
