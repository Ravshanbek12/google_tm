import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:productive/constants/colors.dart';
import 'package:productive/constants/icons.dart';
import 'package:productive/constants/routes.dart';
import 'package:productive/core/data/models/loading_status.dart';
import 'package:productive/core/data/models/priority.dart';
import 'package:productive/core/data/models/tasks.dart';
import 'package:productive/core/widgets/drawer/drawer.dart';
import 'package:productive/features/tasks/notes/notes.dart';
import 'package:productive/features/tasks/presentation/repository/tasks.dart';
import 'package:productive/main.dart';
import 'bloc/tasks/tasks_bloc.dart';
import 'models/task.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(repository: TaskRepository()),
      child: Builder(builder: (context) {
        return Scaffold(
          drawer: const Drawer(
            child: DrawerMenu(),
          ),
          appBar: AppBar(
            backgroundColor: scaffoldBackgroundColor,
            automaticallyImplyLeading: false,
            titleSpacing: 0,
            toolbarHeight: 116,
            title: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Builder(builder: (context) {
                        return GestureDetector(
                          onTap: () {
                            print("Drawer started");
                            Scaffold.of(context).openDrawer();
                          },
                          child: SvgPicture.asset(AppIcons.hamburger),
                        );
                      }),
                      const Spacer(),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NotesPage()));
                          },
                          // onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Notes(),)),
                          child: SvgPicture.asset(AppIcons.note)),
                      const SizedBox(width: 24),
                      SvgPicture.asset(AppIcons.notification),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    onChanged: (value) {
                      context.read<TaskBloc>().add(SearchTask(query: value));
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 44, vertical: 13.5),
                      prefixIcon: Container(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset(
                          AppIcons.search,
                        ),
                      ),
                      suffixIcon: Container(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset(AppIcons.filter),
                      ),
                      filled: true,
                      fillColor: textFieldBackgroundColor,
                      hintText: 'Search by events, tasks.. ',
                    ),
                  ),
                ],
              ),
            ),
            bottom: TabBar(
              controller: tabController,
              labelColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: activeColor,
              tabs: [
                Tab(
                    child: Text(
                  "Upcoming",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.white),
                )),
                Tab(
                  child: Text(
                    "All",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          body: BlocBuilder<TaskBloc, TaskState>(
            builder: (context, state) {
              switch (state.status) {
                case LoadingStatus.pure:
                  context.read<TaskBloc>().add(LoadTasks());
                  return const SizedBox();
                case LoadingStatus.loading:
                  return const Center(child: CupertinoActivityIndicator());
                case LoadingStatus.loadedWithSuccess:
                  return state.isSearching
                      ? ListView.separated(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 16,
                          ),
                          itemBuilder: (_, index) =>
                              TaskItem(task: state.searchedTasks[index]),
                          separatorBuilder: (_, __) => const Gap(16),
                          itemCount: state.searchedTasks.length,
                        )
                      : TabBarView(
                          controller: tabController,
                          children: [
                            ListView.separated(
                              padding: const EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 16,
                              ),
                              itemBuilder: (_, index) =>
                                  TaskItem(task: state.upcomingTasks[index]),
                              separatorBuilder: (_, __) => const Gap(16),
                              itemCount: state.upcomingTasks.length,
                            ),
                            ListView.separated(
                              padding: const EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 16,
                              ),
                              itemBuilder: (_, index) =>
                                  TaskItem(task: state.allTasks[index]),
                              separatorBuilder: (_, __) => const Gap(16),
                              itemCount: state.allTasks.length,
                            )
                          ],
                        );
                case LoadingStatus.loadedWithFailure:
                  return const SizedBox();
                default:
                  return const SizedBox();
              }
            },
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}

class TaskItem extends StatelessWidget {
  final TasksModel task;

  const TaskItem({
    required this.task,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF272C38),
          border: Border(
            right: BorderSide(
              width: 10,
              style: BorderStyle.solid,
              color: getProperColor(task.priority),
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: task.iconColor,
                  ),
                  child: SvgPicture.asset(
                    task.icon,
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title!,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          decoration: task.isChecked!
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      const Gap(2),
                      Text(
                        '${getProperTime(task.startDate)} - ${getProperTime(task.dueDate)}',
                        style: TextStyle(
                          color: const Color(0xFFABABAB),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          decoration: task.isChecked!
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.read<TaskBloc>().add(ToggleTaskCheckedValue(
                          id: task.id,
                        ));
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset(
                        AppIcons.check,
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                            color: verificationResentColor,
                            borderRadius: BorderRadius.circular(6)),
                        child: task.isChecked == true
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 16,
                              )
                            : const SizedBox(),
                      )
                    ],
                  ),
                )
              ],
            ),
            if (task.note != null) ...{
              const Gap(8),
              Text(
                task.note!,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  decoration: task.isChecked!
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              )
            }
          ],
        ),
      ),
    );
  }

  String getProperTime(DateTime date) {
    final hour = date.hour < 10 ? '0${date.hour}' : '${date.hour}';
    final minute = date.minute < 10 ? '0${date.minute}' : '${date.minute}';
    return '$hour:$minute ${date.hour < 12 ? "AM" : "PM"}';
  }

  Color getProperColor(Priority priority) {
    switch (priority) {
      case Priority.high:
        return const Color(0xFFFF2752);
      case Priority.medium:
        return const Color(0xFFF6A845);
      case Priority.low:
        return const Color(0xFF44DB4A);
      default:
        return Colors.white;
    }
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:gap/gap.dart';
// import 'package:productive/constants/colors.dart';
// import 'package:productive/constants/icons.dart';
// import 'package:productive/features/tasks/presentation/bloc/tasks/tasks_bloc.dart';
// import 'package:productive/features/tasks/presentation/models/loading_status.dart';
// import 'package:productive/features/tasks/presentation/models/priority.dart';
// import 'package:productive/features/tasks/presentation/models/task.dart';
// import 'package:productive/features/tasks/presentation/repository/tasks.dart';
//
// class TaskScreen extends StatefulWidget {
//   const TaskScreen({super.key});
//
//   @override
//   State<TaskScreen> createState() => _TaskScreenState();
// }
//
// class _TaskScreenState extends State<TaskScreen> with SingleTickerProviderStateMixin {
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
//       create: (context) => TaskBloc(repository: TaskRepository()),
//       child: Builder(builder: (context) {
//         return Scaffold(
//           appBar: AppBar(
//             backgroundColor: scaffoldBackgroundColor,
//             automaticallyImplyLeading: false,
//             titleSpacing: 0,
//             toolbarHeight: 116,
//             title: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Builder(builder: (context) {
//                         return GestureDetector(
//                           onTap: () {
//                             print("Drawer started");
//                             Scaffold.of(context).openDrawer();
//                           },
//                           child: SvgPicture.asset(AppIcons.hamburger),
//                         );
//                       }),
//                       const Spacer(),
//                       GestureDetector(
//                           // onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Notes(),)),
//                           child: SvgPicture.asset(AppIcons.note)),
//                       const SizedBox(width: 24),
//                       SvgPicture.asset(AppIcons.notification),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   TextField(
//                     decoration: InputDecoration(
//                       contentPadding: const EdgeInsets.symmetric(
//                           horizontal: 44, vertical: 13.5),
//                       prefixIcon: Container(
//                         padding: const EdgeInsets.all(10),
//                         child: SvgPicture.asset(
//                           AppIcons.search,
//                         ),
//                       ),
//                       suffixIcon: Container(
//                         padding: const EdgeInsets.all(10),
//                         child: SvgPicture.asset(AppIcons.filter),
//                       ),
//                       filled: true,
//                       fillColor: textFieldBackgroundColor,
//                       hintText: 'Search by events, tasks.. ',
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             bottom: TabBar(
//               controller: tabController,
//               tabs: const [
//                 Tab(text: 'Upcoming'),
//                 Tab(text: 'All'),
//               ],
//             ),
//           ),
//           body: BlocBuilder<TaskBloc, TaskState>(
//             builder: (context, state) {
//               switch (state.status) {
//                 case LoadingStatus.pure:
//                   context.read<TaskBloc>().add(LoadTasks());
//                   return const SizedBox();
//                 case LoadingStatus.loading:
//                   return const Center(child: CupertinoActivityIndicator());
//                 case LoadingStatus.loadedWithSuccess:
//                   return TabBarView(
//                     controller: tabController,
//                     children: [
//                       ListView.separated(
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 20,
//                           horizontal: 16,
//                         ),
//                         itemBuilder: (_, index) =>
//                             TaskItem(task: state.upcomingTasks[index]),
//                         separatorBuilder: (_, __) => const Gap(16),
//                         itemCount: state.upcomingTasks.length,
//                       ),
//                       ListView.separated(
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 20,
//                           horizontal: 16,
//                         ),
//                         itemBuilder: (_, index) =>
//                             TaskItem(task: state.allTasks[index]),
//                         separatorBuilder: (_, __) => const Gap(16),
//                         itemCount: state.allTasks.length,
//                       )
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
// }
//
// class TaskItem extends StatelessWidget {
//   final TaskModel task;
//   const TaskItem({
//     required this.task,
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(10),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//         decoration: BoxDecoration(
//           color: const Color(0xFF272C38),
//           border: Border(
//             right: BorderSide(
//               width: 10,
//               style: BorderStyle.solid,
//               color: getProperColor(task.priority),
//             ),
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(
//               children: [
//                 Container(
//                   width: 38,
//                   height: 38,
//                   padding: const EdgeInsets.all(7),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: task.iconColor,
//                   ),
//                   child: SvgPicture.asset(
//                     task.icon,
//                   ),
//                 ),
//                 const Gap(10),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         task.title,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w600,
//                           fontSize: 16,
//                           decoration: task.isChecked
//                               ? TextDecoration.lineThrough
//                               : TextDecoration.none,
//                         ),
//                       ),
//                       const Gap(2),
//                       Text(
//                         '${getProperTime(task.startDate)} - ${getProperTime(task.dueDate)}',
//                         style: TextStyle(
//                           color: const Color(0xFFABABAB),
//                           fontWeight: FontWeight.w400,
//                           fontSize: 14,
//                           decoration: task.isChecked
//                               ? TextDecoration.lineThrough
//                               : TextDecoration.none,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Checkbox(
//                   value: task.isChecked,
//                   onChanged: (value) {
//                     context.read<TaskBloc>().add(ToggleTaskCheckedValue(
//                       id: task.id,
//                     ));
//                   },
//                   checkColor: const Color(0xFF4B7FD6),
//                   activeColor: const Color(0xFF4B7FD6),
//                 )
//               ],
//             ),
//             if (task.note != null) ...{
//               const Gap(8),
//               Text(
//                 task.note!,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w400,
//                   fontSize: 14,
//                   decoration: task.isChecked
//                       ? TextDecoration.lineThrough
//                       : TextDecoration.none,
//                 ),
//               )
//             }
//           ],
//         ),
//       ),
//     );
//   }
//
//   String getProperTime(DateTime date) {
//     final hour = date.hour < 10 ? '0${date.hour}' : '${date.hour}';
//     final minute = date.minute < 10 ? '0${date.minute}' : '${date.minute}';
//     return '$hour:$minute';
//   }
//
//   Color getProperColor(Priority priority) {
//     switch (priority) {
//       case Priority.high:
//         return const Color(0xFFFF2752);
//       case Priority.medium:
//         return const Color(0xFFF6A845);
//       case Priority.low:
//         return const Color(0xFF44DB4A);
//       default:
//         return Colors.white;
//     }
//   }
// }
