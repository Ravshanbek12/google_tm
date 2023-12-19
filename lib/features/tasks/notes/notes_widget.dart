import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:productive/constants/colors.dart';
import 'package:productive/constants/icons.dart';
class ListItem extends StatelessWidget {
  final String title;
  final String desc;
  final String date;
  final String? image;
  final bool isAudio;


  const ListItem({
    super.key,
    required this.title,
    required this.desc,
    required this.date,
    this.image,
    required this.isAudio,

  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            width: double.infinity,
            decoration: BoxDecoration(
                color: textFieldBackgroundColor,
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                      ),
                      const Gap(4),
                      Text(
                        desc,
                        style:  TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: white.withOpacity(0.6),
                        ),
                        maxLines: 1,
                      ),
                      const Gap(8),
                      Row(
                        children: [
                          Text(
                            date,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: white,
                            ),
                          ),
                          const SizedBox(width: 12),
                          if (isAudio)
                            Image.asset(AppIcons.voice),
                        ],
                      ),
                    ],
                  ),
                ),
                if (image != null)
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset(
                      image!,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
