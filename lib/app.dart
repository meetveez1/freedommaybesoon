import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/app_providers.dart';
import 'core/navigation/app_routes.dart';
import 'features/auth/presentation/login_screen.dart';
import 'features/auth/presentation/register_screen.dart';
import 'features/home/presentation/home_screen.dart';
import 'features/news/presentation/news_detail_screen.dart';
import 'features/onboarding/presentation/interface_select_screen.dart';
import 'features/onboarding/presentation/role_select_screen.dart';
import 'features/onboarding/presentation/theme_select_screen.dart';
import 'features/onboarding/presentation/welcome_screen.dart';
import 'features/splash/presentation/splash_screen.dart';
import 'models/news_item.dart';
import 'theme/app_theme.dart';

class SchoolApp extends ConsumerWidget {
  const SchoolApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(appStateProvider);
    final settings = state.settings;

    return MaterialApp(
      title: 'School App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(settings.themeVariant),
      darkTheme: AppTheme.dark(settings.themeVariant),
      routes: {
        AppRoutes.splash: (_) => const SplashScreen(),
        AppRoutes.welcome: (_) => const WelcomeScreen(),
        AppRoutes.role: (_) => const RoleSelectScreen(),
        AppRoutes.interface: (_) => const InterfaceSelectScreen(),
        AppRoutes.theme: (_) => const ThemeSelectScreen(),
        AppRoutes.login: (_) => const LoginScreen(),
        AppRoutes.register: (_) => const RegisterScreen(),
        AppRoutes.home: (_) => const HomeScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == AppRoutes.newsDetails) {
          final news = settings.arguments! as NewsItem;
          return MaterialPageRoute(builder: (_) => NewsDetailScreen(news: news));
        }
        return null;
      },
      initialRoute: AppRoutes.splash,
    );
  }
}
