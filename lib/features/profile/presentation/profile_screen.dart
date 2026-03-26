import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/app_providers.dart';
import '../../../core/navigation/app_routes.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = currentUserOf(ref);
    final settings = appSettingsOf(ref);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Профиль', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Card(
          child: ListTile(
            title: Text(user?.fullName ?? 'Demo User'),
            subtitle: Text(user?.email ?? 'demo@school.app'),
            trailing: Text(settings.role.name),
          ),
        ),
        Card(
          child: ListTile(
            title: const Text('Тип интерфейса'),
            subtitle: Text(settings.interfaceMode.name),
          ),
        ),
        Card(
          child: ListTile(
            title: const Text('Тема'),
            subtitle: Text(settings.themeVariant.name),
          ),
        ),
        const SizedBox(height: 12),
        FilledButton.tonalIcon(
          onPressed: () async {
            await ref.read(appStateProvider.notifier).logout();
            if (context.mounted) Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (_) => false);
          },
          icon: const Icon(Icons.logout),
          label: const Text('Выйти'),
        ),
      ],
    );
  }
}
