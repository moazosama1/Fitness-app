import 'package:elevate_super_fitness/core/api_result/api_result.dart';
import 'package:elevate_super_fitness/domain/entites/requests/login_request_entity.dart';
import 'package:elevate_super_fitness/domain/entites/user_entity.dart';
import 'package:elevate_super_fitness/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {
  final AuthRepo _authRepo;

  LoginUseCase(this._authRepo);
  Future<ApiResult<UserEntity>> call(LoginRequestEntity request) async {
    return _authRepo.login(request: request);
  }
}
