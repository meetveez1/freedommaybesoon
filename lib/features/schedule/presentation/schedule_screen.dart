import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/app_providers.dart';
import '../../../models/app_enums.dart';

class ScheduleScreen extends ConsumerStatefulWidget {
  const ScheduleScreen({super.key});

  @override
  ConsumerState<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends ConsumerState<ScheduleScreen> {
  int _day = 1;

  static const days = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт'];

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(scheduleProvider);
    final role = appSettingsOf(ref).role;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Расписание', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                days.length,
                (i) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(days[i]),
                    selected: _day == i + 1,
                    onSelected: (_) => setState(() => _day = i + 1),
                  ),
                ),
              ),
            ),
          ),
          if (role == UserRole.admin)
            TextButton.icon(
              onPressed: () => showDialog<void>(
                context: context,
                builder: (_) => const AlertDialog(content: Text('UI-заготовка для управления расписанием.')),
              ),
              icon: const Icon(Icons.edit_calendar),
              label: const Text('Управление расписанием'),
            ),
          Expanded(
            child: state.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => const Center(child: Text('Ошибка загрузки расписания')),
              data: (items) {
                final dayItems = items.where((e) => e.weekday == _day).toList();
                if (dayItems.isEmpty) return const Center(child: Text('На этот день уроков нет'));
                return ListView.builder(
                  itemCount: dayItems.length,
                  itemBuilder: (_, i) {
                    final l = dayItems[i];
                    return Card(
                      child: ListTile(
                        title: Text(l.subject),
                        subtitle: Text('${l.time} • ${l.room}\n${l.teacher}'),
                        isThreeLine: true,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
