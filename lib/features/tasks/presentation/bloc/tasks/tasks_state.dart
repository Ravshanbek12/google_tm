// import 'package:productive/core/pages/tasks/models/loading_status.dart';
part of 'tasks_bloc.dart';

class TaskState {
  final String icon;
  final LoadingStatus status;
  final LoadingStatus taskCreationStatus;
  final List<TasksModel> upcomingTasks;
  final List<TasksModel> allTasks;
  final List<TasksModel> searchedTasks;
  final bool isSearching;

  TaskState({
    required this.taskCreationStatus,
    required this.icon,
    required this.status,
    required this.allTasks,
    required this.upcomingTasks,
    required this.isSearching,
    required this.searchedTasks,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TaskState &&
        other.status == status &&
        other.taskCreationStatus == taskCreationStatus &&
        listEquals(other.allTasks, allTasks) &&
        listEquals(other.upcomingTasks, upcomingTasks) &&
        listEquals(other.searchedTasks, searchedTasks) &&
        other.isSearching == isSearching && other.icon == icon;
  }

  @override
  int get hashCode =>
      status.hashCode ^
      taskCreationStatus.hashCode ^
      upcomingTasks.hashCode ^
      allTasks.hashCode ^
      searchedTasks.hashCode ^
      isSearching.hashCode;

  TaskState copyWith({
    String? icon,
    LoadingStatus? status,
    LoadingStatus?hashCode ,
    LoadingStatus? taskCreationStatus,
    List<TasksModel>? upcomingTasks,
    List<TasksModel>? allTasks,
    List<TasksModel>? searchedTasks,
    bool? isSearching,
  }) {
    return TaskState(
      taskCreationStatus: taskCreationStatus ?? this.taskCreationStatus,
      icon: icon ?? this.icon,
      status: status ?? this.status,
      upcomingTasks: upcomingTasks ?? this.upcomingTasks,
      allTasks: allTasks ?? this.allTasks,
      searchedTasks: searchedTasks ?? this.searchedTasks,
      isSearching: isSearching ?? this.isSearching,
    );
  }
}
