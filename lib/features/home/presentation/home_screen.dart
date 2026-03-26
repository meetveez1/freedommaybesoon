import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/app_providers.dart';
import '../../../shared/widgets/app_shell_background.dart';
import '../../news/presentation/news_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../schedule/presentation/schedule_screen.dart';
import '../../settings/presentation/settings_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final settings = appSettingsOf(ref);
    final tabs = const [NewsScreen(), ScheduleScreen(), ProfileScreen(), SettingsScreen()];

    return Scaffold(
      body: AppShellBackground(
        variant: settings.themeVariant,
        interfaceMode: settings.interfaceMode,
        animationsEnabled: settings.animationsEnabled,
        child: Column(
          children: [
            const SizedBox(height: 52),
            Expanded(
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: tabs[_index],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (v) => setState(() => _index = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.newspaper), label: 'Новости'),
          NavigationDestination(icon: Icon(Icons.calendar_month), label: 'Расписание'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Профиль'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Настройки'),
        ],
      ),
    );
  }
}
