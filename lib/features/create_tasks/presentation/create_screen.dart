import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:productive/constants/colors.dart';
import 'package:productive/constants/routes.dart';
import 'package:productive/features/create_tasks/repository/tasks.dart';

import 'package:productive/core/data/models/priority.dart';
import 'package:productive/features/tasks/presentation/bloc/tasks/tasks_bloc.dart';
import 'package:productive/features/tasks/presentation/repository/tasks.dart';
import 'bloc/tasks/tasks_bloc.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final list = [
    'assets/icons/tasks/gym.svg',
    'assets/icons/tasks/meet.svg',
    'assets/icons/tasks/book.svg',
  ];
  late TextEditingController titleController;
  late TextEditingController noteController;
  final random = Random();

  DateTime? startDate;
  DateTime? dueDate;
  Priority? priority;
  String? icon;

  @override
  void initState() {
    titleController = TextEditingController();
    noteController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(repository: TaskRepository()),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text("Create Task",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 24),),
          ),
          body: BlocBuilder<TaskBloc, TaskState>(
            builder: (context, state) {
              print("${state.icon} :icon");

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: const Color(0xFF272C38),
                              builder: (modalBottomSheetContext) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 359,
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    children: List.generate(
                                      3,

                                      (index) => GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () {
                                          context.read<TaskBloc>().add(ChangeIcon(index: index));
                                          Navigator.of(modalBottomSheetContext)
                                              .pop();
                                          icon = state.icon;
                                        },
                                        child: SvgPicture.asset(
                                          list[index],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.5),
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromRGBO(
                                random.nextInt(255),
                                random.nextInt(255),
                                random.nextInt(255),
                                1,
                              ),
                            ),
                            child:
                                 SvgPicture.asset(state.icon) ,
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          child: TextField(
                            style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                              hintText: "New title",
                              hintStyle: TextStyle(color: Color(0xFF8E8E8E),fontWeight: FontWeight.w500,fontSize: 18)
                            ),
                            controller: titleController,
                          ),
                        ),
                      ],
                    ),
                    Gap(25.5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () async {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );

                            final day = await showDatePicker(
                               context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2024),
                            );

                            if (time != null && day != null) {
                              setState(() {
                                startDate = day.copyWith(
                                  hour: time.hour,
                                  minute: time.minute,
                                );
                              });
                            }
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Start',
                                style: TextStyle(color: activeColor,fontWeight: FontWeight.w500,fontSize: 16),
                              ),
                              Text(
                                '${startDate?.hour}:${startDate?.minute}',
                                style: TextStyle(color: Color(0xFF8E8E8E),fontSize: 14,fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () async {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );

                            final day = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2024),
                            );

                            if (time != null && day != null) {
                              setState(() {
                                dueDate = day.copyWith(
                                  hour: time.hour,
                                  minute: time.minute,
                                );
                              });
                            }
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'End',
                                style: TextStyle(color: activeColor,fontWeight: FontWeight.w500,fontSize: 16),
                              ),
                              Text(
                                '${dueDate?.hour}:${dueDate?.minute}',
                                style: TextStyle(color: Color(0xFF8E8E8E),fontSize: 14,fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Gap(10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Priority',
                        style: TextStyle(color: activeColor,fontSize: 16,fontWeight: FontWeight.w500),
                      ),
                    ),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        3,
                        (index) => GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            setState(() {
                              priority = getPriorityEnumValueByIndex(index);
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: getPriorityColorByIndex(index),

                              )
                            ),
                            child: Text(
                              getPriorityByIndex(index),
                              style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    TextField(
                      controller: noteController,
                    ),
                    const Spacer(),
                    MaterialButton(
                      onPressed: () {
                        if (icon == null) {
                          print(icon);
                          ScaffoldMessenger.of(context).showMaterialBanner(
                            MaterialBanner(
                              onVisible: () async {
                                await Future.delayed(
                                    const Duration(seconds: 3));
                                ScaffoldMessenger.of(context)
                                    .hideCurrentMaterialBanner();
                              },
                              content: Text('Icon cannot be null'),
                              actions: [SizedBox()],
                            ),
                          );
                          return;
                        }
                        if (startDate == null) {
                          ScaffoldMessenger.of(context).showMaterialBanner(
                            MaterialBanner(
                              onVisible: () async {
                                await Future.delayed(
                                    const Duration(seconds: 3));
                                ScaffoldMessenger.of(context)
                                    .hideCurrentMaterialBanner();
                              },
                              content: const Text('Start date cannot be null'),
                              actions: const [SizedBox()],
                            ),
                          );
                          return;
                        }
                        if (dueDate == null) {
                          ScaffoldMessenger.of(context).showMaterialBanner(
                            MaterialBanner(
                              onVisible: () async {
                                await Future.delayed(
                                    const Duration(seconds: 3));
                                ScaffoldMessenger.of(context)
                                    .hideCurrentMaterialBanner();
                              },
                              content: Text('Due date cannot be null'),
                              actions: [SizedBox()],
                            ),
                          );
                          return;
                        }
                        if (priority == null) {
                          ScaffoldMessenger.of(context).showMaterialBanner(
                            MaterialBanner(
                              onVisible: () async {
                                await Future.delayed(
                                    const Duration(seconds: 3));
                                ScaffoldMessenger.of(context)
                                    .hideCurrentMaterialBanner();
                              },
                              content: Text('Priority date cannot be null'),
                              actions: [SizedBox()],
                            ),
                          );
                          return;
                        }
                        context.read<TaskBloc>().add(
                              CreateTaskButtonPressed(
                                icon: icon!,
                                title: titleController.text,
                                startDate: startDate!,
                                dueDate: dueDate!,
                                note: noteController.text,
                                priority: priority!,
                                onSuccess: () {
                                  // Navigator.of(context).pop();
                                  Navigator.of(context).pushNamed(AppRoutes.taskPage);
                                },
                                onFailure: (errorMessage) {
                                  print(errorMessage);
                                  ScaffoldMessenger.of(context)
                                      .showMaterialBanner(
                                    MaterialBanner(
                                      onVisible: () async {
                                        await Future.delayed(
                                            const Duration(seconds: 3));
                                        ScaffoldMessenger.of(context)
                                            .hideCurrentMaterialBanner();
                                      },
                                      content: Text(errorMessage),
                                      actions: const [
                                        SizedBox(),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );

                      },
                      child: const Text(
                        'Create task',
                        style: TextStyle(color: white),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    noteController.dispose();
    super.dispose();
  }

  String getPriorityByIndex(int index) {
    switch (index) {
      case 0:
        return 'High';
      case 1:
        return 'Medium';
      case 2:
        return 'Low';
      default:
        return '';
    }
  }

  Priority getPriorityEnumValueByIndex(int index) {
    switch (index) {
      case 0:
        return Priority.high;
      case 1:
        return Priority.medium;
      case 2:
        return Priority.low;
      default:
        return Priority.low;
    }
  }

  Color getPriorityColorByIndex(int index) {
    switch (index) {
      case 0:
        return const Color(0xFFFF2752);
      case 1:
        return const Color(0xFFF6A845);
      case 2:
        return const Color(0xFF44DB4A);
      default:
        return Colors.white;
    }
  }
}
