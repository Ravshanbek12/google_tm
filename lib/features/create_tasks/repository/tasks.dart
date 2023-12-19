// import 'dart:math';
// import 'dart:ui';
//
// import 'package:productive/core/data/models/priority.dart';
// import 'package:productive/core/data/models/tasks.dart';
// import 'package:productive/features/tasks/presentation/mock_data.dart';
//
// class TaskRepository {
//   Future<List<TasksModel>> getTasks() async {
//     await Future.delayed(const Duration(seconds: 2));
//
//     return (data['tasks'] as List)
//         .map((e) => TasksModel(
//             id: e['id']?? 0,
//             icon: e['icon']?? '',
//             title: e['title']?? '',
//             priority: e['priority'],
//             note: e['note']?? '',
//             startDate: e['start_date'],
//             dueDate: e['due_date'],
//             isChecked: e['is_checked'], iconColor: e['icon_color']??Color(0xFFFFFFFF)))
//         .toList();
//   }
//
//
//
//   Future<TasksModel> createTask({
//     required String icon,
//     required String title,
//     required DateTime startDate,
//     required DateTime dueDate,
//     required String? note,
//     required Priority priority,
//   }) async {
//     final random = Random();
//
//     Future.delayed(const Duration(seconds: 3));
//
//     if (title.isEmpty || title.length < 3) {
//       throw Exception('Title is invalid');
//     }
//
//     final newTask = TasksModel(
//       id: (data['tasks'] as List).lastOrNull['id'] + 1 ?? 0,
//       icon: icon,
//       title: title,
//       priority: priority,
//       note: note!,
//       startDate: startDate,
//       dueDate: dueDate,
//       isChecked: false,
//       iconColor: Color.fromRGBO(
//         random.nextInt(255),
//         random.nextInt(255),
//         random.nextInt(255),
//         1,
//       ),
//     );
//
//     data['tasks'].add(
//       {
//         "id": newTask.id,
//         "title": newTask.title,
//         "icon": newTask.icon,
//         "priority": newTask.priority,
//         "note": newTask.note,
//         "start_date": newTask.startDate,
//         "due_date": newTask.dueDate,
//         "is_checked": newTask.isChecked,
//         "icon_color": newTask.iconColor
//       },
//     );
//     return newTask;
//   }
// }
