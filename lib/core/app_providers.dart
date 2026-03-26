import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/app_settings.dart';
import '../models/app_user.dart';
import '../models/news_item.dart';
import '../models/schedule_item.dart';
import '../services/local_storage_service.dart';
import '../services/mock_data_service.dart';
import 'app_state_controller.dart';

final sharedPrefsProvider = Provider<SharedPreferences>((_) {
  throw UnimplementedError();
});

final storageServiceProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService(ref.watch(sharedPrefsProvider));
});

final mockDataServiceProvider = Provider<MockDataService>((_) => MockDataService());

final appStateProvider = StateNotifierProvider<AppStateController, AppState>((ref) {
  return AppStateController(ref.watch(storageServiceProvider));
});

final newsProvider = FutureProvider<List<NewsItem>>((ref) async {
  await Future<void>.delayed(const Duration(milliseconds: 400));
  return ref.watch(mockDataServiceProvider).getNews();
});

final scheduleProvider = FutureProvider<List<ScheduleItem>>((ref) async {
  await Future<void>.delayed(const Duration(milliseconds: 350));
  return ref.watch(mockDataServiceProvider).getSchedule();
});

final filteredNewsProvider = Provider.family<List<NewsItem>, String>((ref, query) {
  final data = ref.watch(newsProvider).valueOrNull ?? [];
  if (query.trim().isEmpty) return data;
  final q = query.toLowerCase();
  return data
      .where((n) =>
          n.title.toLowerCase().contains(q) ||
          n.category.toLowerCase().contains(q) ||
          n.description.toLowerCase().contains(q))
      .toList();
});

AppSettings appSettingsOf(WidgetRef ref) => ref.watch(appStateProvider).settings;
AppUser? currentUserOf(WidgetRef ref) => ref.watch(appStateProvider).user;
