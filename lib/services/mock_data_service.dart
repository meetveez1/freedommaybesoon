import '../models/news_item.dart';
import '../models/schedule_item.dart';

class MockDataService {
  List<NewsItem> getNews() => [
        NewsItem(
          id: '1',
          title: 'Школьная олимпиада по математике',
          description:
              'В пятницу состоится олимпиада среди 8-11 классов. Регистрация открыта до 20:00 четверга.',
          date: DateTime(2026, 3, 24),
          category: 'Учёба',
          imageUrl: 'https://picsum.photos/seed/school1/800/450',
        ),
        NewsItem(
          id: '2',
          title: 'Весенний концерт',
          description:
              'Приглашаем родителей и учеников на концерт в актовом зале. Начало в 17:30.',
          date: DateTime(2026, 3, 21),
          category: 'События',
          imageUrl: 'https://picsum.photos/seed/school2/800/450',
        ),
        NewsItem(
          id: '3',
          title: 'Обновление школьной библиотеки',
          description:
              'Поступили новые книги по программированию и естественным наукам. Приходите за новинками.',
          date: DateTime(2026, 3, 15),
          category: 'Школа',
          imageUrl: 'https://picsum.photos/seed/school3/800/450',
        ),
      ];

  List<ScheduleItem> getSchedule() => const [
        ScheduleItem(
          subject: 'Алгебра',
          time: '08:30 - 09:15',
          room: 'Каб. 204',
          teacher: 'Иванова А.В.',
          weekday: 1,
        ),
        ScheduleItem(
          subject: 'Физика',
          time: '09:25 - 10:10',
          room: 'Лаб. 12',
          teacher: 'Сергеев М.Н.',
          weekday: 1,
        ),
        ScheduleItem(
          subject: 'Английский язык',
          time: '10:30 - 11:15',
          room: 'Каб. 110',
          teacher: 'Петрова Е.С.',
          weekday: 2,
        ),
        ScheduleItem(
          subject: 'История',
          time: '11:25 - 12:10',
          room: 'Каб. 301',
          teacher: 'Кириллов Д.И.',
          weekday: 3,
        ),
        ScheduleItem(
          subject: 'Информатика',
          time: '12:20 - 13:05',
          room: 'Каб. 208',
          teacher: 'Орлова Н.П.',
          weekday: 4,
        ),
      ];
}
