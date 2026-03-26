import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/app_providers.dart';
import '../../../core/navigation/app_routes.dart';
import '../../../shared/widgets/ui_kit.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _remember = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Вход')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AppInput(
                controller: _email,
                label: 'Email',
                validator: (v) => (v == null || !v.contains('@')) ? 'Введите корректный email' : null,
              ),
              const SizedBox(height: 12),
              AppInput(
                controller: _password,
                label: 'Пароль',
                obscure: true,
                validator: (v) => (v == null || v.length < 6) ? 'Минимум 6 символов' : null,
              ),
              CheckboxListTile(
                value: _remember,
                onChanged: (v) => setState(() => _remember = v ?? false),
                title: const Text('Запомнить меня'),
                contentPadding: EdgeInsets.zero,
              ),
              AppPrimaryButton(
                text: 'Войти',
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;
                  final ok = await ref.read(appStateProvider.notifier).login(_email.text, _password.text);
                  if (!mounted) return;
                  if (ok) {
                    Navigator.pushReplacementNamed(context, AppRoutes.home);
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('Пользователь не найден. Сначала зарегистрируйтесь.')));
                  }
                },
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, AppRoutes.register),
                child: const Text('Нет аккаунта? Регистрация'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
