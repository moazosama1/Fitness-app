import 'package:elevate_super_fitness/core/constants/app_theme.dart';
import 'package:elevate_super_fitness/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:elevate_super_fitness/core/router/app_router.dart';


class TestAppWrapper extends StatelessWidget {
  final Widget child;

  const TestAppWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) {
        return MaterialApp(
          title: AppLocalizations().appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          onGenerateRoute: AppRouter.onGenerateRoute,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.delegate.supportedLocales,
          locale: const Locale("en"),
          home: child,
        );
      },
    );
  }
}

