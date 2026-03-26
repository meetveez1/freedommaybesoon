import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/app_providers.dart';
import '../../../core/navigation/app_routes.dart';
import '../../../shared/widgets/app_shell_background.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      final state = ref.read(appStateProvider);
      final route = !state.settings.onboardingComplete
          ? AppRoutes.welcome
          : (state.settings.isLoggedIn ? AppRoutes.home : AppRoutes.login);
      Navigator.pushReplacementNamed(context, route);
    });
  }

  @override
  Widget build(BuildContext context) {
    final settings = appSettingsOf(ref);
    return Scaffold(
      body: AppShellBackground(
        variant: settings.themeVariant,
        interfaceMode: settings.interfaceMode,
        animationsEnabled: settings.animationsEnabled,
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.school_rounded, color: Colors.white, size: 74),
              SizedBox(height: 12),
              Text('School App',
                  style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
