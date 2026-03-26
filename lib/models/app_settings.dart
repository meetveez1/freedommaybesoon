import 'app_enums.dart';

class AppSettings {
  const AppSettings({
    this.role = UserRole.student,
    this.interfaceMode = InterfaceMode.standard,
    this.themeVariant = ThemeVariant.ocean,
    this.onboardingComplete = false,
    this.isLoggedIn = false,
    this.animationsEnabled = true,
  });

  final UserRole role;
  final InterfaceMode interfaceMode;
  final ThemeVariant themeVariant;
  final bool onboardingComplete;
  final bool isLoggedIn;
  final bool animationsEnabled;

  AppSettings copyWith({
    UserRole? role,
    InterfaceMode? interfaceMode,
    ThemeVariant? themeVariant,
    bool? onboardingComplete,
    bool? isLoggedIn,
    bool? animationsEnabled,
  }) {
    return AppSettings(
      role: role ?? this.role,
      interfaceMode: interfaceMode ?? this.interfaceMode,
      themeVariant: themeVariant ?? this.themeVariant,
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      animationsEnabled: animationsEnabled ?? this.animationsEnabled,
    );
  }

  Map<String, dynamic> toJson() => {
        'role': role.name,
        'interfaceMode': interfaceMode.name,
        'themeVariant': themeVariant.name,
        'onboardingComplete': onboardingComplete,
        'isLoggedIn': isLoggedIn,
        'animationsEnabled': animationsEnabled,
      };

  factory AppSettings.fromJson(Map<String, dynamic> json) => AppSettings(
        role: UserRole.values.byName(json['role'] as String? ?? 'student'),
        interfaceMode: InterfaceMode.values
            .byName(json['interfaceMode'] as String? ?? 'standard'),
        themeVariant:
            ThemeVariant.values.byName(json['themeVariant'] as String? ?? 'ocean'),
        onboardingComplete: json['onboardingComplete'] as bool? ?? false,
        isLoggedIn: json['isLoggedIn'] as bool? ?? false,
        animationsEnabled: json['animationsEnabled'] as bool? ?? true,
      );
}
