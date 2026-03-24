import 'package:elevate_super_fitness/core/constants/constant_dummy_image.dart';
import 'package:elevate_super_fitness/domain/entites/meal_category_entity.dart';
import 'package:elevate_super_fitness/domain/entites/meal_details_entity.dart';
import 'package:elevate_super_fitness/domain/entites/meal_entity.dart';
import 'package:elevate_super_fitness/domain/entites/help_response_entity.dart';
import 'package:elevate_super_fitness/domain/entites/help_section_response_entity.dart';
import 'package:elevate_super_fitness/domain/entites/exercise_difficulty_level_entity.dart';
import 'package:elevate_super_fitness/domain/entites/get_selected_exercise_entity.dart';
import 'package:elevate_super_fitness/domain/entites/logout_response_entity.dart';
import 'package:elevate_super_fitness/domain/entites/muscle_entity.dart';
import 'package:elevate_super_fitness/domain/entites/muscle_group_entity.dart';
import 'package:elevate_super_fitness/domain/entites/privacy_policy_response_entity.dart';
import 'package:elevate_super_fitness/domain/entites/security_roles_config_entity.dart';
import 'package:elevate_super_fitness/domain/entites/user_info_entity.dart';

class AppFakeData {
  AppFakeData._();

  static const UserInfoEntity profileUser = UserInfoEntity(
    message: 'loaded from fake data',
    id: 'user-fake-1',
    firstName: 'john',
    lastName: 'Fitness',
    email: 'moaz.fitness@example.com',
    gender: 'male',
    age: 28,
    weight: 78,
    height: 178,
    activityLevel: 'active',
    goal: 'muscle_gain',
    photo: AppDummyImage.dummyImageFitness10,
    createdAt: '2026-03-23T12:00:00Z',
  );

  static const LogoutResponseEntity profileLogout = LogoutResponseEntity(
    message: 'Logged out successfully (fake data)',
  );

  static const HelpResponseEntity profileHelpData = HelpResponseEntity(
    helpScreenContent: [
      HelpSectionEntity(
        section: 'faq',
        title: {'en': 'FAQ', 'ar': 'الأسئلة الشائعة'},
        content: [
          {
            'q': {'en': 'How to track progress?', 'ar': 'كيف أتابع التقدم؟'},
            'a': {
              'en': 'Open profile and check your latest stats.',
              'ar': 'افتح الملف الشخصي وراجع آخر الإحصائيات.',
            },
          },
          {
            'q': {'en': 'How to update my goals?', 'ar': 'كيف أعدل أهدافي؟'},
            'a': {
              'en': 'Use Edit Profile to update goal and activity.',
              'ar': 'استخدم تعديل الملف لتحديث الهدف والنشاط.',
            },
          },
        ],
      ),
    ],
  );

  static const PrivacyPolicyResponseEntity profilePrivacyPolicy =
      PrivacyPolicyResponseEntity(
        privacyPolicy: [
          PrivacySectionEntity(
            section: 'privacy_intro',
            title: {'en': 'Privacy', 'ar': 'الخصوصية'},
            content: {
              'en': 'This is fake local privacy content for demo mode.',
              'ar': 'هذا محتوى خصوصية محلي تجريبي لوضع البيانات الوهمية.',
            },
          ),
        ],
      );

  static const SecurityRolesConfigResponseEntity profileSecurityConfig =
      SecurityRolesConfigResponseEntity(
        securityRolesConfig: [
          SecurityRoleSectionEntity(
            section: 'default_security',
            roleId: 'role-user',
            name: {'en': 'User', 'ar': 'مستخدم'},
            title: {'en': 'Security Settings', 'ar': 'إعدادات الأمان'},
            description: {
              'en': 'Fake security settings for offline demo.',
              'ar': 'إعدادات أمان وهمية للعرض بدون شبكة.',
            },
            permissions: [
              PermissionEntity(
                key: 'change_password',
                name: {'en': 'Change Password', 'ar': 'تغيير كلمة المرور'},
              ),
              PermissionEntity(
                key: 'manage_devices',
                name: {'en': 'Manage Devices', 'ar': 'إدارة الأجهزة'},
              ),
            ],
          ),
        ],
      );

  static const List<MuscleEntity> exploreRecommendationToDay = [
    MuscleEntity(
      id: 'muscle-1',
      name: 'Chest Blast',
      image: AppDummyImage.dummyImageFitness7,
    ),
    MuscleEntity(
      id: 'muscle-2',
      name: 'Shoulder Burn',
      image: AppDummyImage.dummyImageFitness7,
    ),
    MuscleEntity(
      id: 'muscle-3',
      name: 'Core Focus',
      image: AppDummyImage.dummyImageFitness7,
    ),
    MuscleEntity(
      id: 'muscle-4',
      name: 'Leg Power',
      image: AppDummyImage.dummyImageFitness7,
    ),
    MuscleEntity(
      id: 'muscle-5',
      name: 'Back Strength',
      image: AppDummyImage.dummyImageFitness7,
    ),
  ];

  static const List<MuscleGroupEntity> exploreUpcomingGroups = [
    MuscleGroupEntity(id: 'group-strength', name: 'Strength'),
    MuscleGroupEntity(id: 'group-cardio', name: 'Cardio'),
    MuscleGroupEntity(id: 'group-mobility', name: 'Mobility'),
  ];

  static const Map<String, List<MuscleEntity>> exploreUpcomingByGroup = {
    'group-strength': [
      MuscleEntity(
        id: 'up-1',
        name: 'Upper Push',
        image: AppDummyImage.dummyImageFitness7,
      ),
      MuscleEntity(
        id: 'up-2',
        name: 'Lower Drive',
        image: AppDummyImage.dummyImageFitness7,
      ),
      MuscleEntity(
        id: 'up-3',
        name: 'Pull Builder',
        image: AppDummyImage.dummyImageFitness7,
      ),
    ],
    'group-cardio': [
      MuscleEntity(
        id: 'up-4',
        name: 'HIIT Sprint',
        image: AppDummyImage.dummyImageFitness7,
      ),
      MuscleEntity(
        id: 'up-5',
        name: 'Tempo Run',
        image: AppDummyImage.dummyImageFitness7,
      ),
      MuscleEntity(
        id: 'up-6',
        name: 'Bike Rush',
        image: AppDummyImage.dummyImageFitness7,
      ),
    ],
    'group-mobility': [
      MuscleEntity(
        id: 'up-7',
        name: 'Full Stretch',
        image: AppDummyImage.dummyImageFitness7,
      ),
      MuscleEntity(
        id: 'up-8',
        name: 'Hip Openers',
        image: AppDummyImage.dummyImageFitness7,
      ),
      MuscleEntity(
        id: 'up-9',
        name: 'Recovery Flow',
        image: AppDummyImage.dummyImageFitness7,
      ),
    ],
  };

  static const List<MealCategoryEntity> exploreRecommendationForYou = [
    MealCategoryEntity(
      idCategory: 'food-1',
      strCategory: 'Protein Bowl',
      strCategoryThumb: AppDummyImage.dummyImageFood1,
    ),
    MealCategoryEntity(
      idCategory: 'food-2',
      strCategory: 'Lean Lunch',
      strCategoryThumb: AppDummyImage.dummyImageFood1,
    ),
    MealCategoryEntity(
      idCategory: 'food-3',
      strCategory: 'Healthy Snack',
      strCategoryThumb: AppDummyImage.dummyImageFood1,
    ),
    MealCategoryEntity(
      idCategory: 'food-4',
      strCategory: 'Post Workout',
      strCategoryThumb: AppDummyImage.dummyImageFood1,
    ),
    MealCategoryEntity(
      idCategory: 'food-5',
      strCategory: 'Energy Meal',
      strCategoryThumb: AppDummyImage.dummyImageFood1,
    ),
  ];

  static const List<MealCategoryEntity> foodCategories = [
    MealCategoryEntity(
      idCategory: 'food-1',
      strCategory: 'Protein Bowl',
      strCategoryThumb: AppDummyImage.dummyImageFood1,
    ),
    MealCategoryEntity(
      idCategory: 'food-2',
      strCategory: 'Lean Lunch',
      strCategoryThumb: AppDummyImage.dummyImageFood1,
    ),
    MealCategoryEntity(
      idCategory: 'food-3',
      strCategory: 'Healthy Snack',
      strCategoryThumb: AppDummyImage.dummyImageFood1,
    ),
    MealCategoryEntity(
      idCategory: 'food-4',
      strCategory: 'Post Workout',
      strCategoryThumb: AppDummyImage.dummyImageFood1,
    ),
    MealCategoryEntity(
      idCategory: 'food-5',
      strCategory: 'Energy Meal',
      strCategoryThumb: AppDummyImage.dummyImageFood1,
    ),
  ];

  static const Map<String, List<MealEntity>> foodMealsByCategory = {
    'Protein Bowl': [
      MealEntity(
        strMeal: 'Chicken Quinoa Bowl',
        strMealThumb: AppDummyImage.dummyImageFood1,
        idMeal: 'meal-1',
      ),
      MealEntity(
        strMeal: 'Beef Rice Bowl',
        strMealThumb: AppDummyImage.dummyImageFood1,
        idMeal: 'meal-2',
      ),
      MealEntity(
        strMeal: 'Tofu Protein Mix',
        strMealThumb: AppDummyImage.dummyImageFood1,
        idMeal: 'meal-3',
      ),
    ],
    'Lean Lunch': [
      MealEntity(
        strMeal: 'Grilled Chicken Salad',
        strMealThumb: AppDummyImage.dummyImageFood1,
        idMeal: 'meal-4',
      ),
      MealEntity(
        strMeal: 'Turkey Wrap',
        strMealThumb: AppDummyImage.dummyImageFood1,
        idMeal: 'meal-5',
      ),
      MealEntity(
        strMeal: 'Tuna Plate',
        strMealThumb: AppDummyImage.dummyImageFood1,
        idMeal: 'meal-6',
      ),
    ],
    'Healthy Snack': [
      MealEntity(
        strMeal: 'Greek Yogurt Cup',
        strMealThumb: AppDummyImage.dummyImageFood1,
        idMeal: 'meal-7',
      ),
      MealEntity(
        strMeal: 'Fruit Nuts Box',
        strMealThumb: AppDummyImage.dummyImageFood1,
        idMeal: 'meal-8',
      ),
      MealEntity(
        strMeal: 'Protein Bar Plate',
        strMealThumb: AppDummyImage.dummyImageFood1,
        idMeal: 'meal-9',
      ),
    ],
    'Post Workout': [
      MealEntity(
        strMeal: 'Egg White Toast',
        strMealThumb: AppDummyImage.dummyImageFood1,
        idMeal: 'meal-10',
      ),
      MealEntity(
        strMeal: 'Banana Shake',
        strMealThumb: AppDummyImage.dummyImageFood1,
        idMeal: 'meal-11',
      ),
      MealEntity(
        strMeal: 'Recovery Smoothie',
        strMealThumb: AppDummyImage.dummyImageFood1,
        idMeal: 'meal-12',
      ),
    ],
    'Energy Meal': [
      MealEntity(
        strMeal: 'Oats Power Bowl',
        strMealThumb: AppDummyImage.dummyImageFood1,
        idMeal: 'meal-13',
      ),
      MealEntity(
        strMeal: 'Rice Chicken Combo',
        strMealThumb: AppDummyImage.dummyImageFood1,
        idMeal: 'meal-14',
      ),
      MealEntity(
        strMeal: 'Sweet Potato Plate',
        strMealThumb: AppDummyImage.dummyImageFood1,
        idMeal: 'meal-15',
      ),
    ],
  };

  static MealDetailsEntity foodMealDetailsById(String mealId) {
    final allMeals = foodMealsByCategory.values.expand((list) => list).toList();
    final selectedMeal = allMeals.firstWhere(
      (meal) => meal.idMeal == mealId,
      orElse: () => allMeals.first,
    );
    final selectedCategory = foodMealsByCategory.entries
        .firstWhere(
          (entry) =>
              entry.value.any((meal) => meal.idMeal == selectedMeal.idMeal),
          orElse: () => foodMealsByCategory.entries.first,
        )
        .key;

    return MealDetailsEntity(
      idMeal: selectedMeal.idMeal,
      strMeal: selectedMeal.strMeal,
      strMealAlternate: null,
      strCategory: selectedCategory,
      strArea: 'International',
      strInstructions:
          'Combine ingredients, cook with light oil, and serve fresh for a healthy meal.',
      strMealThumb: selectedMeal.strMealThumb,
      strTags: 'healthy,fitness',
      strYoutube: '',
      strIngredient1: 'Protein source',
      strIngredient2: 'Complex carbs',
      strIngredient3: 'Fresh vegetables',
      strIngredient4: 'Olive oil',
      strIngredient5: 'Salt',
      strIngredient6: 'Black pepper',
      strIngredient7: '',
      strIngredient8: '',
      strIngredient9: '',
      strIngredient10: '',
      strIngredient11: '',
      strIngredient12: '',
      strIngredient13: '',
      strIngredient14: '',
      strIngredient15: '',
      strIngredient16: '',
      strIngredient17: '',
      strIngredient18: '',
      strIngredient19: '',
      strIngredient20: '',
      strMeasure1: '200 g',
      strMeasure2: '100 g',
      strMeasure3: '1 cup',
      strMeasure4: '1 tbsp',
      strMeasure5: 'to taste',
      strMeasure6: 'to taste',
      strMeasure7: '',
      strMeasure8: '',
      strMeasure9: '',
      strMeasure10: '',
      strMeasure11: '',
      strMeasure12: '',
      strMeasure13: '',
      strMeasure14: '',
      strMeasure15: '',
      strMeasure16: '',
      strMeasure17: '',
      strMeasure18: '',
      strMeasure19: '',
      strMeasure20: '',
      strSource: '',
      strImageSource: null,
      strCreativeCommonsConfirmed: null,
      dateModified: null,
    );
  }

  static List<MealEntity> foodRecommendedByCategory(String category) {
    return List<MealEntity>.from(foodMealsByCategory[category] ?? const []);
  }

  static const List<ExerciseDifficultyLevelEntity> exerciseDifficultyLevels = [
    ExerciseDifficultyLevelEntity(id: 'level-beginner', name: 'Beginner'),
    ExerciseDifficultyLevelEntity(
      id: 'level-intermediate',
      name: 'Intermediate',
    ),
    ExerciseDifficultyLevelEntity(id: 'level-advanced', name: 'Advanced'),
  ];

  static const Map<String, List<GetSelectedExerciseEntity>>
  exercisesByDifficultyLevel = {
    'level-beginner': [
      GetSelectedExerciseEntity(
        id: 'ex-1',
        exercise: 'Push Up',
        difficultyLevel: 'Beginner',
        targetMuscleGroup: 'Chest',
        primeMoverMuscle: 'Pectoralis',
        bodyRegion: 'Upper Body',
        mechanics: 'Compound',
        shortYoutubeDemonstrationLink:
            'https://www.youtube.com/watch?v=IODxDxX7oi4',
      ),
      GetSelectedExerciseEntity(
        id: 'ex-2',
        exercise: 'Bodyweight Squat',
        difficultyLevel: 'Beginner',
        targetMuscleGroup: 'Legs',
        primeMoverMuscle: 'Quadriceps',
        bodyRegion: 'Lower Body',
        mechanics: 'Compound',
        shortYoutubeDemonstrationLink:
            'https://www.youtube.com/watch?v=aclHkVaku9U',
      ),
      GetSelectedExerciseEntity(
        id: 'ex-3',
        exercise: 'Plank Hold',
        difficultyLevel: 'Beginner',
        targetMuscleGroup: 'Core',
        primeMoverMuscle: 'Rectus Abdominis',
        bodyRegion: 'Core',
        mechanics: 'Isometric',
        shortYoutubeDemonstrationLink:
            'https://www.youtube.com/watch?v=ASdvN_XEl_c',
      ),
    ],
    'level-intermediate': [
      GetSelectedExerciseEntity(
        id: 'ex-4',
        exercise: 'Incline Dumbbell Press',
        difficultyLevel: 'Intermediate',
        targetMuscleGroup: 'Chest',
        primeMoverMuscle: 'Upper Chest',
        bodyRegion: 'Upper Body',
        mechanics: 'Compound',
        shortYoutubeDemonstrationLink:
            'https://www.youtube.com/watch?v=8iPEnn-ltC8',
      ),
      GetSelectedExerciseEntity(
        id: 'ex-5',
        exercise: 'Romanian Deadlift',
        difficultyLevel: 'Intermediate',
        targetMuscleGroup: 'Hamstrings',
        primeMoverMuscle: 'Hamstrings',
        bodyRegion: 'Lower Body',
        mechanics: 'Compound',
        shortYoutubeDemonstrationLink:
            'https://www.youtube.com/watch?v=2SHsk9AzdjA',
      ),
      GetSelectedExerciseEntity(
        id: 'ex-6',
        exercise: 'Hanging Knee Raise',
        difficultyLevel: 'Intermediate',
        targetMuscleGroup: 'Core',
        primeMoverMuscle: 'Lower Abs',
        bodyRegion: 'Core',
        mechanics: 'Isolation',
        shortYoutubeDemonstrationLink:
            'https://www.youtube.com/watch?v=Rd8q8FZ6n0E',
      ),
    ],
    'level-advanced': [
      GetSelectedExerciseEntity(
        id: 'ex-7',
        exercise: 'Weighted Dip',
        difficultyLevel: 'Advanced',
        targetMuscleGroup: 'Chest/Triceps',
        primeMoverMuscle: 'Triceps',
        bodyRegion: 'Upper Body',
        mechanics: 'Compound',
        shortYoutubeDemonstrationLink:
            'https://www.youtube.com/watch?v=2z8JmcrW-As',
      ),
      GetSelectedExerciseEntity(
        id: 'ex-8',
        exercise: 'Front Squat',
        difficultyLevel: 'Advanced',
        targetMuscleGroup: 'Legs',
        primeMoverMuscle: 'Quadriceps',
        bodyRegion: 'Lower Body',
        mechanics: 'Compound',
        shortYoutubeDemonstrationLink:
            'https://www.youtube.com/watch?v=tLFQ6uQ7A94',
      ),
      GetSelectedExerciseEntity(
        id: 'ex-9',
        exercise: 'Dragon Flag',
        difficultyLevel: 'Advanced',
        targetMuscleGroup: 'Core',
        primeMoverMuscle: 'Abdominals',
        bodyRegion: 'Core',
        mechanics: 'Advanced Bodyweight',
        shortYoutubeDemonstrationLink:
            'https://www.youtube.com/watch?v=pvz7k5gO-DE',
      ),
    ],
  };

  static List<GetSelectedExerciseEntity> exercisesByLevel(String levelId) {
    return List<GetSelectedExerciseEntity>.from(
      exercisesByDifficultyLevel[levelId] ?? const [],
    );
  }

  static const List<MuscleGroupEntity> workoutGroups = [
    MuscleGroupEntity(id: 'group-strength', name: 'Strength'),
    MuscleGroupEntity(id: 'group-cardio', name: 'Cardio'),
    MuscleGroupEntity(id: 'group-mobility', name: 'Mobility'),
    MuscleGroupEntity(id: 'group-endurance', name: 'Endurance'),
  ];

  static const Map<String, List<MuscleEntity>> workoutsByGroup = {
    'group-strength': [
      MuscleEntity(
        id: 'w-1',
        name: 'Upper Push',
        image: AppDummyImage.dummyImageFitness7,
      ),
      MuscleEntity(
        id: 'w-2',
        name: 'Back Builder',
        image: AppDummyImage.dummyImageFitness7,
      ),
      MuscleEntity(
        id: 'w-3',
        name: 'Leg Force',
        image: AppDummyImage.dummyImageFitness7,
      ),
      MuscleEntity(
        id: 'w-4',
        name: 'Core Stability',
        image: AppDummyImage.dummyImageFitness7,
      ),
    ],
    'group-cardio': [
      MuscleEntity(
        id: 'w-5',
        name: 'HIIT Sprint',
        image: AppDummyImage.dummyImageFitness7,
      ),
      MuscleEntity(
        id: 'w-6',
        name: 'Cardio Flow',
        image: AppDummyImage.dummyImageFitness7,
      ),
      MuscleEntity(
        id: 'w-7',
        name: 'Fast Burn',
        image: AppDummyImage.dummyImageFitness7,
      ),
      MuscleEntity(
        id: 'w-8',
        name: 'Runner Mix',
        image: AppDummyImage.dummyImageFitness7,
      ),
    ],
    'group-mobility': [
      MuscleEntity(
        id: 'w-9',
        name: 'Stretch Deep',
        image: AppDummyImage.dummyImageFitness7,
      ),
      MuscleEntity(
        id: 'w-10',
        name: 'Joint Reset',
        image: AppDummyImage.dummyImageFitness7,
      ),
      MuscleEntity(
        id: 'w-11',
        name: 'Recovery Flow',
        image: AppDummyImage.dummyImageFitness7,
      ),
      MuscleEntity(
        id: 'w-12',
        name: 'Balance Work',
        image: AppDummyImage.dummyImageFitness7,
      ),
    ],
    'group-endurance': [
      MuscleEntity(
        id: 'w-13',
        name: 'Long Set',
        image: AppDummyImage.dummyImageFitness7,
      ),
      MuscleEntity(
        id: 'w-14',
        name: 'Tempo Circuit',
        image: AppDummyImage.dummyImageFitness7,
      ),
      MuscleEntity(
        id: 'w-15',
        name: 'Steady Burn',
        image: AppDummyImage.dummyImageFitness7,
      ),
      MuscleEntity(
        id: 'w-16',
        name: 'Engine Build',
        image: AppDummyImage.dummyImageFitness7,
      ),
    ],
  };
}
