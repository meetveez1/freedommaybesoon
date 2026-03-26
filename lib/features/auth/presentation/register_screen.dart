import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/app_providers.dart';
import '../../../core/navigation/app_routes.dart';
import '../../../models/app_enums.dart';
import '../../../models/app_user.dart';
import '../../../shared/widgets/ui_kit.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  UserRole _role = UserRole.student;

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Регистрация')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AppInput(controller: _firstName, label: 'Имя', validator: _required),
              const SizedBox(height: 12),
              AppInput(controller: _lastName, label: 'Фамилия', validator: _required),
              const SizedBox(height: 12),
              AppInput(controller: _email, label: 'Email', validator: _emailValidator),
              const SizedBox(height: 12),
              AppInput(controller: _password, label: 'Пароль', obscure: true, validator: _passwordValidator),
              const SizedBox(height: 12),
              AppInput(
                controller: _confirmPassword,
                label: 'Подтверждение пароля',
                obscure: true,
                validator: (v) => v != _password.text ? 'Пароли не совпадают' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<UserRole>(
                value: _role,
                items: const [
                  DropdownMenuItem(value: UserRole.student, child: Text('Обучающийся')),
                  DropdownMenuItem(value: UserRole.admin, child: Text('Администратор')),
                ],
                onChanged: (v) => setState(() => _role = v ?? UserRole.student),
                decoration: const InputDecoration(labelText: 'Роль пользователя'),
              ),
              const SizedBox(height: 18),
              AppPrimaryButton(
                text: 'Зарегистрироваться',
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;
                  final user = AppUser(
                    firstName: _firstName.text.trim(),
                    lastName: _lastName.text.trim(),
                    email: _email.text.trim(),
                    password: _password.text,
                    role: _role,
                  );
                  await ref.read(appStateProvider.notifier).register(user);
                  if (context.mounted) Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (_) => false);
                },
              ),
              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.login),
                child: const Text('Уже есть аккаунт? Войти'),
              )
            ],
          ),
        ),
      ),
    );
  }

  String? _required(String? v) => (v == null || v.trim().isEmpty) ? 'Обязательное поле' : null;

  String? _emailValidator(String? v) => (v == null || !v.contains('@')) ? 'Введите корректный email' : null;

  String? _passwordValidator(String? v) => (v == null || v.length < 6) ? 'Минимум 6 символов' : null;
}
