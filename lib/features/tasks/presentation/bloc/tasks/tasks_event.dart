part of 'tasks_bloc.dart';

@immutable
abstract class TaskEvent {
  const TaskEvent();
}
class GetTasksEvent extends TaskEvent {
  final Function() onSuccess;
  final Function(String errorMessage) onFailure;

  const GetTasksEvent({
    required this.onSuccess,
    required this.onFailure,
  });
}
class LoadTasks extends TaskEvent {}
class ChangeIcon extends TaskEvent{
  final int index;

  ChangeIcon({required this.index});
}
class ToggleTaskCheckedValue extends TaskEvent {
  final int id;

  ToggleTaskCheckedValue({required this.id});
}
class SearchTask extends TaskEvent {
  final String query;

  SearchTask({required this.query});
}

class CreateTaskButtonPressed extends TaskEvent {
  final String icon;
  final String title;
  final DateTime startDate;
  final DateTime dueDate;
  final String? note;
  final Priority priority;
  final VoidCallback onSuccess;
  final ValueChanged<String> onFailure;

  const CreateTaskButtonPressed({
    required this.icon,
    required this.title,
    required this.startDate,
    required this.dueDate,
    required this.note,
    required this.priority,
    required this.onSuccess,
    required this.onFailure,
  });
}