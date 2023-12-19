import 'dart:ui';

import 'package:productive/features/create_tasks/domain/entities/task.dart';


class TaskModel extends TaskEntity {
  TaskModel({
    required super.id,
    required super.icon,
    required super.iconBackgroundColor,
    required super.isChecked,
    required super.title,
    required super.createdDate,
    required super.dueDate,
    required super.description,
    super.link,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] ?? '',
      icon: json['icon'] ?? '',
      iconBackgroundColor: json['icon_background_color'] as Color,
      isChecked: json['is_checked'],
      title: json['title'],
      createdDate: json['created_date'] as DateTime,
      dueDate: json['due_date'] as DateTime,
      description: json['description'] ?? '',
      link: json['link'],
    );
  }
}
