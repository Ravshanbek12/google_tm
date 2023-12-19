// import 'package:flutter/foundation.dart';
// import 'package:productive/core/data/models/priority.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:productive/core/data/models/loading_status.dart';
// import 'package:productive/core/data/models/tasks.dart';
// import '../../../repository/tasks.dart';
//
// part 'tasks_state.dart';
//
// part 'tasks_event.dart';
//
//
//
//
// class TasksBloc extends Bloc<TasksEvent, TaskState> {
//   final TaskRepository _repository;
//
//   TasksBloc({required TaskRepository repository})
//       : _repository = repository,
//         super(
//            TaskState(
//             status: LoadingStatus.pure,
//             allTasks: [],
//             upcomingTasks: [],
//             taskCreationStatus: LoadingStatus.pure,
//             isSearching: false,
//             searchedTasks: [], icon: 'assets/icons/tasks/gym.svg',
//           ),
//         ) {
//     on<LoadTasks>((event, emit) async {
//       emit(state.copyWith(status: LoadingStatus.loading));
//       try {
//         final tasksListRepo = await _repository.getTasks();
//         emit(state.copyWith(
//           status: LoadingStatus.loadedWithSuccess,
//           allTasks: tasksListRepo,
//           upcomingTasks: tasksListRepo.where((element) => element.isChecked!).toList(),
//         ));
//       } catch (e) {
//         addError(e);
//         emit(state.copyWith(status: LoadingStatus.loadedWithFailure));
//       }
//     });
//     on<ToggleTaskCheckedValue>((event, emit) {
//       var newList = <TasksModel>[];
//       for (var i = 0; i < state.allTasks.length; i++) {
//         if (state.allTasks[i].id == event.id) {
//           newList.add(state.allTasks[i]
//               .copyWith(isChecked: !state.allTasks[i].isChecked!));
//         } else {
//           newList.add(state.allTasks[i]);
//         }
//       }
//       emit(state.copyWith(
//           allTasks: newList,
//           upcomingTasks:
//               newList.where((element) => element.isChecked!).toList()));
//     });
//     on<CreateTaskButtonPressed>((event, emit) async {
//       emit(state.copyWith(taskCreationStatus: LoadingStatus.loading));
//       try {
//         if (event.note == null || event.note!.isEmpty) {
//           throw Exception("Note is Required");
//         }
//         final newTask = await _repository.createTask(
//           title: event.title,
//           icon: event.icon,
//           dueDate: event.dueDate,
//           note: event.note,
//           priority: event.priority,
//           startDate: event.startDate,
//         );
//         final updatedList = [...state.allTasks, newTask];
//         emit(
//           state.copyWith(
//             taskCreationStatus: LoadingStatus.loadedWithSuccess,
//             allTasks: updatedList,
//             upcomingTasks: updatedList
//                 .where(
//                   (element) => element.isChecked!,
//                 )
//                 .toList(),
//           ),
//         );
//
//         event.onSuccess();
//       } catch (error) {
//         print("$error");
//         emit(state.copyWith(
//           taskCreationStatus: LoadingStatus.loadedWithFailure,
//         ));
//         event.onFailure("$error");
//       }
//     });
//     on<ChangeIcon>((event, emit)async{
//       final list = [
//         'assets/icons/tasks/gym.svg',
//         'assets/icons/tasks/meet.svg',
//         'assets/icons/tasks/book.svg',
//       ];
//       Future.delayed(const Duration(seconds: 2));
//       final icon = list[event.index];
//        emit(state.copyWith(icon: icon));
//     });
//   }
//
//   @override
//   void onError(Object error, StackTrace stackTrace) {
//     print(error);
//     super.onError(error, stackTrace);
//   }
// }
