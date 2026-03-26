import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/app_providers.dart';
import '../../../core/navigation/app_routes.dart';
import '../../../models/app_enums.dart';
import '../../../shared/widgets/ui_kit.dart';

class NewsScreen extends ConsumerStatefulWidget {
  const NewsScreen({super.key});

  @override
  ConsumerState<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends ConsumerState<NewsScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(newsProvider);
    final role = appSettingsOf(ref).role;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppSectionTitle('Новости школы'),
          const SizedBox(height: 10),
          TextField(
            decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Поиск по новостям'),
            onChanged: (v) => setState(() => _query = v),
          ),
          const SizedBox(height: 12),
          if (role == UserRole.admin)
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton.icon(
                onPressed: () => _showAdminDialog(context),
                icon: const Icon(Icons.add),
                label: const Text('Добавить новость'),
              ),
            ),
          const SizedBox(height: 8),
          Expanded(
            child: state.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => const Center(child: Text('Ошибка загрузки новостей')),
              data: (_) {
                final filtered = ref.watch(filteredNewsProvider(_query));
                if (filtered.isEmpty) return const Center(child: Text('Новости не найдены'));
                return ListView.separated(
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (_, i) {
                    final n = filtered[i];
                    return Card(
                      child: ListTile(
                        onTap: () => Navigator.pushNamed(context, AppRoutes.newsDetails, arguments: n),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(n.imageUrl, width: 72, fit: BoxFit.cover),
                        ),
                        title: Text(n.title),
                        subtitle: Text('${DateFormat('dd.MM.yyyy').format(n.date)} • ${n.category}'),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void _showAdminDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => const AlertDialog(
        title: Text('Admin UI'),
        content: Text('Заготовка для добавления/редактирования новости (без backend).'),
      ),
    );
  }
}
