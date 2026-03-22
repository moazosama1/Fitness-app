abstract class Endpoints {
  static const String changePassword = "api/v1/auth/change-password";
  static const String getAllDifficultyLevelsByPrimeMoverMuscle =
      "api/v1/levels/difficulty-levels/by-prime-mover";
  static const String getExercisesByPrimeMoverMuscleAndDifficultyLevel =
      "api/v1/exercises/by-muscle-difficulty";
  static const String randomPrimeMoverMuscles = "api/v1/muscles/random";
  static const String allMusclesGroups = "api/v1/muscles";
  static const String musclesByMuscleGroupId = "api/v1/musclesGroup";
  static const String mealsCategories = "api/json/v1/1/categories.php";
  static const String loggedUserData = "api/v1/auth/profile-data";
  static const String urlThemeAdb = "https://www.themealdb.com/";
  static const String mealsDio = 'MealsDio';
  static const String mealsByCategory = "api/json/v1/1/filter.php";
  static const String mealDetails = "api/json/v1/1/lookup.php";
  static const String mealCategoryQuery = "c";
  static const String mealIdQuery = "i";
  static const String workouts = "api/v1/muscles";
  static const String muscles = "api/v1/musclesGroup/{id}";
  static const String editProfile = "api/v1/auth/editProfile";
  static const String uploadPhoto = "api/v1/auth/upload-photo";
  static const String queryPhoto = "photo";
  static const String logout = "api/v1/auth/logout";
  static const String helpLocalData = "assets/data/help.json";
  static const String privacyAndSecurityLocalData =
      "assets/data/privacy_and_security.json";
  static const String securityRolesConfigLocalData =
      "assets/data/security_roles_config.json";
}
