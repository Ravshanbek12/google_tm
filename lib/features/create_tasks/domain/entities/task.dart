import 'dart:ui';

class TaskEntity {
  final String id;
  final String icon;
  final Color iconBackgroundColor;
  final bool isChecked;
  final String title;
  final DateTime createdDate;
  final DateTime dueDate;
  final String description;
  final String? link;

  TaskEntity({
    required this.id,
    required this.icon,
    required this.iconBackgroundColor,
    required this.isChecked,
    required this.title,
    required this.createdDate,
    required this.dueDate,
    required this.description,
    this.link,
  });
}
