import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/app_providers.dart';
import '../../../core/navigation/app_routes.dart';
import '../../../models/app_enums.dart';

class InterfaceSelectScreen extends ConsumerWidget {
  const InterfaceSelectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Выбор интерфейса')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _ModeCard(
              title: 'Обычный интерфейс',
              subtitle: 'Минималистичный UI без фоновых эффектов',
              icon: Icons.dashboard_customize,
              onTap: () async {
                await ref.read(appStateProvider.notifier).updateInterfaceMode(InterfaceMode.standard);
                if (context.mounted) Navigator.pushNamed(context, AppRoutes.theme);
              },
            ),
            const SizedBox(height: 16),
            _ModeCard(
              title: 'Анимированный интерфейс',
              subtitle: 'Плавающие размытые квадраты на фоне',
              icon: Icons.animation,
              onTap: () async {
                await ref.read(appStateProvider.notifier).updateInterfaceMode(InterfaceMode.animated);
                if (context.mounted) Navigator.pushNamed(context, AppRoutes.theme);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ModeCard extends StatelessWidget {
  const _ModeCard({required this.title, required this.subtitle, required this.icon, required this.onTap});

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        onTap: onTap,
      ),
    );
  }
}
