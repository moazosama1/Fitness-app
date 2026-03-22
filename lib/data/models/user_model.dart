import 'package:elevate_super_fitness/domain/entites/user_entity.dart';

class UserModel extends UserEntity {
  final String password;

  const UserModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required this.password,
    required super.gender,
    required super.age,
    required super.weight,
    required super.height,
    required super.activityLevel,
    required super.goal,
    required super.photo,
    required super.createdAt,
  });

  UserModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? gender,
    int? age,
    int? weight,
    int? height,
    String? activityLevel,
    String? goal,
    String? photo,
    String? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      activityLevel: activityLevel ?? this.activityLevel,
      goal: goal ?? this.goal,
      photo: photo ?? this.photo,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      gender: gender,
      age: age,
      weight: weight,
      height: height,
      activityLevel: activityLevel,
      goal: goal,
      photo: photo,
      createdAt: createdAt,
    );
  }
}
