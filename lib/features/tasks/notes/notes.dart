import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:productive/constants/colors.dart';
import 'package:productive/constants/icons.dart';
import 'package:productive/features/tasks/notes/notes_widget.dart';
class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<String> titles = [
    "Commitment resource lecture",
    "Duas",
    "Commitment resource lecture",
    "Commitment resource lecture",
    "Duas",
  ];
  List<String> desc = [
    "We explained the definition of commitment and it.. ",
    "Allahuma aeni ealaa dikrika wa shukrika wa husn e..",
    "We explained the definition of commitmen..",
    "We explained the definition of commitment and it..",
    "Allahuma aeni ealaa dikrika wa shukrika wa husn e..",
  ];
  List<bool> audio = [false, false, true, false, false];
  List<String?> images = [null, null, "assets/images/box_picture.png", null, null];

  @override
  Widget build(BuildContext context) {
    print("Keldi----");
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Notes',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(20),
             Text(
              "Books",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: white.withOpacity(0.5)),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                     Image.asset(
                       AppIcons.password_book,
                               ),
                      const Gap(6),
                      const Text(
                        "Password",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: white),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset(
                      AppIcons.memorise_book,
                    ),
                      const Gap(6),
                      const Text(
                        "Memories",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: white),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset(
                        AppIcons.create_book,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Gap(25),

            Row(
              children: [
                 Expanded(
                    child: Text(
                      "Quick Notes",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: white.withOpacity(0.5)),
                    )),
                Image.asset(
                  AppIcons.plus,
                ),
              ],
            ),
            const SizedBox(height: 24),
            ListView.builder(
                padding: const EdgeInsets.only(bottom: 24),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: titles.length,
                itemBuilder: (context, index) {
                  return ListItem(
                    title: titles[index],
                    image: images[index],
                    desc: desc[index],
                    date: "15 November",
                    isAudio: audio[index],

                  );
                }),
            const Gap(100),
          ],
        ),
      ),
    );
  }
}
