import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/app_enums.dart';
import '../models/app_settings.dart';
import '../models/app_user.dart';
import '../services/local_storage_service.dart';

class AppState {
  const AppState({
    this.settings = const AppSettings(),
    this.user,
    this.isBootstrapping = true,
  });

  final AppSettings settings;
  final AppUser? user;
  final bool isBootstrapping;

  AppState copyWith({
    AppSettings? settings,
    AppUser? user,
    bool clearUser = false,
    bool? isBootstrapping,
  }) {
    return AppState(
      settings: settings ?? this.settings,
      user: clearUser ? null : (user ?? this.user),
      isBootstrapping: isBootstrapping ?? this.isBootstrapping,
    );
  }
}

class AppStateController extends StateNotifier<AppState> {
  AppStateController(this._storage) : super(const AppState()) {
    _bootstrap();
  }

  final LocalStorageService _storage;

  Future<void> _bootstrap() async {
    final settingsRaw = _storage.readSettings();
    final userRaw = _storage.readUser();

    final settings = settingsRaw == null
        ? const AppSettings()
        : AppSettings.fromJson(jsonDecode(settingsRaw) as Map<String, dynamic>);
    final user = userRaw == null
        ? null
        : AppUser.fromJson(jsonDecode(userRaw) as Map<String, dynamic>);

    state = state.copyWith(
      settings: settings,
      user: user,
      isBootstrapping: false,
    );
  }

  Future<void> updateRole(UserRole role) async {
    await _saveSettings(state.settings.copyWith(role: role));
  }

  Future<void> updateInterfaceMode(InterfaceMode mode) async {
    await _saveSettings(state.settings.copyWith(interfaceMode: mode));
  }

  Future<void> updateTheme(ThemeVariant theme) async {
    await _saveSettings(state.settings.copyWith(themeVariant: theme));
  }

  Future<void> setAnimations(bool enabled) async {
    await _saveSettings(state.settings.copyWith(animationsEnabled: enabled));
  }

  Future<void> completeOnboarding() async {
    await _saveSettings(state.settings.copyWith(onboardingComplete: true));
  }

  Future<void> register(AppUser user) async {
    await _storage.saveUser(user.toJson());
    await _saveSettings(state.settings.copyWith(isLoggedIn: true, role: user.role));
    state = state.copyWith(user: user);
  }

  Future<bool> login(String email, String password) async {
    final userRaw = _storage.readUser();
    if (userRaw == null) return false;
    final user = AppUser.fromJson(jsonDecode(userRaw) as Map<String, dynamic>);
    if (user.email == email.trim() && user.password == password) {
      await _saveSettings(state.settings.copyWith(isLoggedIn: true));
      state = state.copyWith(user: user);
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    await _saveSettings(state.settings.copyWith(isLoggedIn: false));
    state = state.copyWith(clearUser: true);
  }

  Future<void> _saveSettings(AppSettings settings) async {
    await _storage.saveSettings(settings.toJson());
    state = state.copyWith(settings: settings);
  }
}
