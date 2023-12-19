import 'package:flutter/material.dart';
import 'package:productive/constants/routes.dart';
import 'package:productive/core/pages/error.dart';
import 'package:productive/core/pages/onboarding.dart';
import 'package:productive/features/create_tasks/presentation/create_screen.dart';
import 'package:productive/features/tasks/notes/notes.dart';
import 'package:productive/features/tasks/presentation/task_screen.dart';

import '../../features/home/presentation/home_screen.dart';
import '../../features/tasks/home/home.dart';
import '../functions/app_functions.dart';
import '../pages/splash.dart';

class AppRouter {
  static Route<dynamic> router(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return fade(const SplashScreen());
      case AppRoutes.home:
        return fade(const HomeScreen());
      case AppRoutes.taskPage:
        return fade(const TaskScreen());
      case AppRoutes.onboarding:
        return fade(const OnboardingScreen());
      case AppRoutes.notesPage:
        return fade(const NotesPage());
      default:
        return fade(const ErrorScreen());
    }
  }
}
