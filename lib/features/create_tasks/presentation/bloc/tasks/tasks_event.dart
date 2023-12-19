// part of 'tasks_bloc.dart';
//
// @immutable
// abstract class TasksEvent {
//   const TasksEvent();
// }
//
// class GetTasksEvent extends TasksEvent {
//   final Function() onSuccess;
//   final Function(String errorMessage) onFailure;
//
//   const GetTasksEvent({
//     required this.onSuccess,
//     required this.onFailure,
//   });
// }
//
//
// class LoadTasks extends TasksEvent{}
//
//
// class ToggleTaskCheckedValue extends TasksEvent{
//   final int id;
//
//    ToggleTaskCheckedValue({required this.id});
// }
//
//
// class ChangeIcon extends TasksEvent{
//   final int index;
//
//    ChangeIcon({required this.index});
// }
//
//
//
// class CreateTaskButtonPressed extends TasksEvent {
//   final String icon;
//   final String title;
//   final DateTime startDate;
//   final DateTime dueDate;
//   final String? note;
//   final Priority priority;
//   final VoidCallback onSuccess;
//   final ValueChanged<String> onFailure;
//
//   const CreateTaskButtonPressed({
//     required this.icon,
//     required this.title,
//     required this.startDate,
//     required this.dueDate,
//     required this.note,
//     required this.priority,
//     required this.onSuccess,
//     required this.onFailure,
//   });
// }