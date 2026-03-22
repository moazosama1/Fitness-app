import 'package:dio/dio.dart';
import 'package:elevate_super_fitness/api/mapper/login_mapper.dart';
import 'package:elevate_super_fitness/api/models/requests/login_request_dto.dart';
import 'package:elevate_super_fitness/api/models/responses/login_response_dto.dart';
import 'package:elevate_super_fitness/domain/entites/login_entity.dart';
import 'package:elevate_super_fitness/domain/entites/requests/login_request_entity.dart';
import 'package:elevate_super_fitness/domain/entites/user_entity.dart';

abstract class LoginDummyData {
  static const LoginRequestEntity dummyLoginRequestEntity = LoginRequestEntity(
    email: "ahmedmutti22@gmail.com",
    password: "Ahmed@123",
    rememberMe: true,
  );
  static final dummyDioException = DioException(
    requestOptions: RequestOptions(),
    error: DioExceptionType.connectionTimeout,
    message: "dio_error",
  );
  static final dummyException = Exception("Exception");
  static final LoginRequestDto dummyLoginRequestDto = dummyLoginRequestEntity
      .toDto();
  static const LoginResponseDto dummyLoginResponseDto = LoginResponseDto(
    message: "success",
    token: "fake_token",
    user: UserLoginDto(
      id: "68f9285e9762f45e2a989daa",
      firstName: "Elevate",
      lastName: "Tech",
      email: "ahmedmrutti22@gmail.com",
      gender: "male",
      age: 70,
      weight: 70,
      height: 170,
      activityLevel: "level1",
      goal: "Gain weight",
      photo: "https://fitness.elevateegy.com/uploads/default-profile.png",
      createdAt: "2025-10-22T18:54:22.308Z",
    ),
  );
  static final LoginResponseEntity dummyLoginResponseEntity =
      dummyLoginResponseDto.toEntity();

  static const UserEntity dummyUserEntity = UserEntity(
    id: "68f9285e9762f45e2a989daa",
    firstName: "Elevate",
    lastName: "Tech",
    email: "ahmedmrutti22@gmail.com",
    gender: "male",
    age: 70,
    weight: 70,
    height: 170,
    activityLevel: "level1",
    goal: "Gain weight",
    photo: "https://fitness.elevateegy.com/uploads/default-profile.png",
    createdAt: "2025-10-22T18:54:22.308Z",
  );
}
