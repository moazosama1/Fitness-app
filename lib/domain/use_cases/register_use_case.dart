import 'package:injectable/injectable.dart';

import '../../core/api_result/api_result.dart';
import '../entites/requests/register_request_entity.dart';
import '../entites/user_entity.dart';
import '../repo/auth_repo.dart';

@injectable
class RegisterUseCase {
  final AuthRepo _authRepo;

  RegisterUseCase(this._authRepo);

  Future<ApiResult<UserEntity>> call(RegisterRequestEntity request) async {
    return await _authRepo.register(request);
  }
}
