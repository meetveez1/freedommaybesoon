import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/app_providers.dart';
import '../../../core/navigation/app_routes.dart';
import '../../../models/app_enums.dart';
import '../../../theme/app_gradients.dart';
import '../../../shared/widgets/ui_kit.dart';

class ThemeSelectScreen extends ConsumerWidget {
  const ThemeSelectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> chooseTheme(ThemeVariant variant) async {
      await ref.read(appStateProvider.notifier).updateTheme(variant);
      await ref.read(appStateProvider.notifier).completeOnboarding();
      if (context.mounted) Navigator.pushReplacementNamed(context, AppRoutes.login);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Выбор темы')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppSectionTitle('Зелёно-синие темы'),
            const SizedBox(height: 16),
            ...ThemeVariant.values.map((v) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: InkWell(
                    onTap: () => chooseTheme(v),
                    borderRadius: BorderRadius.circular(20),
                    child: Ink(
                      height: 88,
                      decoration: BoxDecoration(
                        gradient: AppGradients.build(v),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(v.name, style: const TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
