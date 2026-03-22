import 'package:dio/dio.dart';
import 'package:elevate_super_fitness/api/models/requests/change_password_request_dto.dart';
import 'package:elevate_super_fitness/api/models/responses/change_password_response_dto.dart';
import 'package:elevate_super_fitness/api/models/responses/exercise_difficulty_levels_response_dto.dart';
import 'package:elevate_super_fitness/api/models/responses/get_selected_exercises_response_dto.dart';
import 'package:elevate_super_fitness/api/models/responses/logout_response_dto.dart';
import 'package:elevate_super_fitness/api/models/responses/muscle_group_details_dto.dart';
import 'package:elevate_super_fitness/api/models/responses/muscles_group_response_dto.dart';
import 'package:elevate_super_fitness/api/models/responses/muscles_response_dto.dart';
import 'package:elevate_super_fitness/api/models/responses/user_info_dto.dart';
import 'package:elevate_super_fitness/core/constants/end_points.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../models/requests/edit_profile_request.dart';
import '../models/responses/common_response.dart';

part 'api_client.g.dart';

@injectable
@RestApi()
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;

  @GET(Endpoints.getAllDifficultyLevelsByPrimeMoverMuscle)
  Future<ExerciseDifficultyLevelsResponseDto>
  getAllDifficultyLevelsByPrimeMoverMuscle(
    @Query("primeMoverMuscleId") String primeMoverMuscleId,
  );

  @GET(Endpoints.getExercisesByPrimeMoverMuscleAndDifficultyLevel)
  Future<GetSelectedExercisesResponseDto>
  getExercisesByPrimeMoverMuscleAndDifficultyLevel(
    @Query("primeMoverMuscleId") String primeMoverMuscleId,
    @Query("difficultyLevelId") String difficultyLevelId,
  );

  @GET(Endpoints.randomPrimeMoverMuscles)
  Future<MusclesResponseDto> getRandomMuscles();

  @GET(Endpoints.allMusclesGroups)
  Future<MusclesGroupResponseDto> getAllMusclesGroups();

  @GET("${Endpoints.musclesByMuscleGroupId}/{id}")
  Future<MuscleGroupDetailsDto> getAllMusclesByMuscleGroupId(
    @Path("id") String id,
  );

  @GET(Endpoints.loggedUserData)
  Future<UserInfoDto> getGetLoggedUserData();

  @PATCH(Endpoints.changePassword)
  Future<ChangePasswordResponseDto> changePassword(
    @Body() ChangePasswordRequestDto request,
  );

  @PUT(Endpoints.editProfile)
  Future<UserInfoDto> editUserProfile(@Body() EditProfileRequest request);

  @PUT(Endpoints.uploadPhoto)
  @MultiPart()
  Future<CommonResponse> uploadUserPhoto(
    @Part(name: Endpoints.queryPhoto) MultipartFile photo,
  );
  @GET(Endpoints.logout)
  Future<LogoutResponseDto> logout();
}
