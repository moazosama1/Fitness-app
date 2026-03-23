import 'package:elevate_super_fitness/core/constants/app_colors.dart';
import 'package:elevate_super_fitness/core/constants/const_keys.dart';
import 'package:elevate_super_fitness/core/di/di.dart';
import 'package:elevate_super_fitness/core/router/route_names.dart';
import 'package:elevate_super_fitness/presentation/splash/widgets/splash_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    autoNavigateToOnBoardingScreen();
  }

  void autoNavigateToOnBoardingScreen() async {
    final bool rememberMe = await getRememberMe();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(
          context,
          rememberMe ? RouteNames.mainHome : RouteNames.onBoarding,
        );
      }
    });
  }

  Future<bool> getRememberMe() async {
    final FlutterSecureStorage secureStorage = getIt
        .get<FlutterSecureStorage>();
    try {
      final String? rememberMeValue = await secureStorage.read(
        key: ConstKeys.keyRememberMe,
      );
      return rememberMeValue == "true";
    } catch (_) {
      // Web secure storage may throw OperationError when persisted data is stale.
      await secureStorage.deleteAll();
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundL[10],
      body: const SafeArea(child: SplashViewBody()),
    );
  }
}
