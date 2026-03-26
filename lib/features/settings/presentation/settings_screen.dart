import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/app_providers.dart';
import '../../../models/app_enums.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = appSettingsOf(ref);
    final notifier = ref.read(appStateProvider.notifier);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Настройки', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        DropdownButtonFormField<ThemeVariant>(
          value: settings.themeVariant,
          decoration: const InputDecoration(labelText: 'Тема'),
          items: ThemeVariant.values
              .map((v) => DropdownMenuItem(value: v, child: Text(v.name)))
              .toList(),
          onChanged: (v) {
            if (v != null) notifier.updateTheme(v);
          },
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<InterfaceMode>(
          value: settings.interfaceMode,
          decoration: const InputDecoration(labelText: 'Тип интерфейса'),
          items: InterfaceMode.values
              .map((v) => DropdownMenuItem(value: v, child: Text(v.name)))
              .toList(),
          onChanged: (v) {
            if (v != null) notifier.updateInterfaceMode(v);
          },
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<UserRole>(
          value: settings.role,
          decoration: const InputDecoration(labelText: 'Роль (demo)'),
          items: UserRole.values
              .map((v) => DropdownMenuItem(value: v, child: Text(v.name)))
              .toList(),
          onChanged: (v) {
            if (v != null) notifier.updateRole(v);
          },
        ),
        SwitchListTile(
          value: settings.animationsEnabled,
          onChanged: notifier.setAnimations,
          title: const Text('Включить анимации'),
        ),
        const AboutListTile(
          icon: Icon(Icons.info_outline),
          applicationName: 'School App',
          applicationVersion: '1.0.0',
          applicationLegalese: 'Demo MVP для школы',
        )
      ],
    );
  }
}
