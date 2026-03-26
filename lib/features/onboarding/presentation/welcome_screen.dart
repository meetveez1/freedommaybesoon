import 'package:flutter/material.dart';

import '../../../core/navigation/app_routes.dart';
import '../../../shared/widgets/ui_kit.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              const AppSectionTitle('Добро пожаловать в School App'),
              const SizedBox(height: 12),
              Text(
                'Новости школы, расписание, профиль и умные настройки интерфейса в одном приложении.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Spacer(),
              AppPrimaryButton(
                text: 'Начать',
                onPressed: () => Navigator.pushNamed(context, AppRoutes.role),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
