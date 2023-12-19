// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gap/gap.dart';
// import 'package:productive/core/data/models/loading_status.dart';
// import 'package:productive/features/create_tasks/presentation/bloc/tasks/tasks_bloc.dart';
// import 'package:productive/features/create_tasks/presentation/witdets/task_item.dart';
//
// import '../repository/tasks.dart';
//
// class TasksScreen extends StatefulWidget {
//   const TasksScreen({Key? key}) : super(key: key);
//
//   @override
//   State<TasksScreen> createState() => _TasksScreenState();
// }
//
// class _TasksScreenState extends State<TasksScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController tabController;
//
//   @override
//   void initState() {
//     tabController = TabController(length: 2, vsync: this);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => TasksBloc(repository: TaskRepository()),
//       child: Builder(builder: (context) {
//         return Scaffold(
//           appBar: AppBar(
//             backgroundColor: Colors.transparent,
//             bottom: TabBar(
//               indicatorColor: Colors.blue,
//               controller: tabController,
//               tabs: const [
//                 Tab(
//                   text: "Upcoming",
//                 ),
//                 Tab(
//                   text: "All",
//                 ),
//               ],
//             ),
//           ),
//           body: BlocBuilder<TasksBloc, TaskState>(
//             builder: (context, state) {
//               switch (state.status) {
//                 case LoadingStatus.pure:
//                   context.read<TasksBloc>().add(LoadTasks());
//                   return const SizedBox();
//                 case LoadingStatus.loading:
//                   return const Center(
//                     child: CupertinoActivityIndicator(),
//                   );
//
//                 case LoadingStatus.loadedWithSuccess:
//                   return TabBarView(
//                     controller: tabController,
//                     children: [
//                       ListView.separated(
//                           padding:const EdgeInsets.symmetric(
//                               horizontal: 16, vertical: 20),
//                           itemBuilder: (_, index) {
//                             return CreateTaskItem(taskModel: state.upcomingTasks[index],);
//                           },
//                           separatorBuilder: (_, __) => const Gap(16),
//                           itemCount: state.upcomingTasks.length),
//                       ListView.separated(
//                           padding:const EdgeInsets.symmetric(
//                               horizontal: 16, vertical: 20),
//                           itemBuilder: (_, index) {
//                             return state.allTasks.isEmpty? const Center(child: Text("Is Empty"),):CreateTaskItem(taskModel: state.allTasks[index],);
//                           },
//                           separatorBuilder: (_, __) => const Gap(16),
//                           itemCount: state.allTasks.length),
//                     ],
//                   );
//                 case LoadingStatus.loadedWithFailure:
//                   return const SizedBox();
//                 default:
//                   return const SizedBox();
//               }
//             },
//           ),
//         );
//       }),
//     );
//   }
//
//   @override
//   void dispose() {
//     tabController.dispose();
//     super.dispose();
//   }
//
//
//
// }
//
//
//
//
//
