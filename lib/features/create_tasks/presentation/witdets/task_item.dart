import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:productive/features/tasks/presentation/bloc/tasks/tasks_bloc.dart';

import '../../../../constants/colors.dart';
import '../../../../core/data/models/tasks.dart';
import '../bloc/tasks/tasks_bloc.dart';

class CreateTaskItem extends StatelessWidget {

  final TasksModel taskModel;

  const CreateTaskItem({Key? key, required this.taskModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color:
        containerBackgroundColor.withOpacity(.02),
        borderRadius: BorderRadius.circular(8),
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
                padding: EdgeInsets.all(7),
                decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(10),
                    color:
                    taskModel.iconColor),
                child: SvgPicture.asset(taskModel.icon),
              ),
              const Gap(10),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      taskModel.title!,
                      style: TextStyle(
                        color: white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        decoration: taskModel.isChecked!
                            ? TextDecoration.lineThrough
                            : null,
                        decorationColor: white,
                      ),
                    ),
                    const Gap(2),
                    Text(
                      "${getProperTime(taskModel.startDate)} - ${getProperTime(taskModel.dueDate)}",
                      style: TextStyle(
                        color: Color(0xFFABABAB),
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        decoration: taskModel.isChecked!
                            ? TextDecoration.lineThrough
                            : null,
                        decorationColor: white,
                      ),
                    ),
                  ],
                ),
              ),
              Checkbox(
                mouseCursor: MouseCursor.defer,
                value: taskModel.isChecked,
                onChanged: (value) {
                  context.read<TaskBloc>().add(
                    ToggleTaskCheckedValue(
                      id: taskModel.id,
                    ),
                  );
                  print("${taskModel.id}");
                },
                checkColor: Color(0xFF4b7fd6),
                activeColor: Color(0xFF4b7fd6),
              ),
            ],
          ),
          if (taskModel.note != null) ...{
            const Gap(8),
            Text(
              taskModel.note!,
              style:  TextStyle(
                color: white,
                fontWeight: FontWeight.w400,
                fontSize: 14,
                decoration: taskModel.isChecked!
                    ? TextDecoration.lineThrough
                    : null,
                decorationColor: white,
              ),
            ),
          }
        ],
      ),
    );
  }

  String getProperTime(DateTime dateTime){
    final hour = dateTime.hour<10?'0${dateTime.hour}':'${dateTime.hour}';
    final minute = dateTime.minute<10?'0${dateTime.minute}':'${dateTime.minute}';
    return '$hour:$minute';
  }
}