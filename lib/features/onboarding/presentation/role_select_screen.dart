import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/app_providers.dart';
import '../../../core/navigation/app_routes.dart';
import '../../../models/app_enums.dart';

class RoleSelectScreen extends ConsumerWidget {
  const RoleSelectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Выбор роли')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _RoleCard(
              title: 'Обучающийся',
              subtitle: 'Просмотр новостей и расписания',
              icon: Icons.person,
              onTap: () async {
                await ref.read(appStateProvider.notifier).updateRole(UserRole.student);
                if (context.mounted) Navigator.pushNamed(context, AppRoutes.interface);
              },
            ),
            const SizedBox(height: 16),
            _RoleCard(
              title: 'Администратор',
              subtitle: 'Управление контентом и расписанием',
              icon: Icons.admin_panel_settings,
              onTap: () async {
                await ref.read(appStateProvider.notifier).updateRole(UserRole.admin);
                if (context.mounted) Navigator.pushNamed(context, AppRoutes.interface);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Icon(icon, size: 30),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        onTap: onTap,
      ),
    );
  }
}
