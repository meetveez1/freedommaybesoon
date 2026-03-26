class ScheduleItem {
  const ScheduleItem({
    required this.subject,
    required this.time,
    required this.room,
    required this.teacher,
    required this.weekday,
  });

  final String subject;
  final String time;
  final String room;
  final String teacher;
  final int weekday;
}
