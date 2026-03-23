sealed class LoginViewModelEvent {}

class LoginViewModelSignInEvent extends LoginViewModelEvent {}

class LoginViewModelSignInWithDummyEmailEvent extends LoginViewModelEvent {}

class LoginViewModelVisiblePasswordEvent extends LoginViewModelEvent {}
