import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:productive/constants/icons.dart';
import 'package:productive/core/widgets/drawer/divider.dart';
import 'package:productive/core/widgets/drawer/drawer_widget.dart';

import '../../../../constants/colors.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({super.key});

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {

  @override
  Widget build(BuildContext context) {
    return Drawer(elevation: 0.0,
      backgroundColor: scaffoldBackgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[

          Padding(
            padding: const EdgeInsets.only(left: 238,top: 67,right: 18,),
            child: SvgPicture.asset(AppIcons.sun),
          ),
          const ListTile(
            leading:
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('assets/icons/drawer/image.png'),
            ),
            title: Text('Rozan',
                style: TextStyle(fontSize: 20,fontFamily: 'Barlow',fontWeight: FontWeight.w700,color: Colors.white)),
            subtitle: Text('rozan.hasan.matar115@gmail.com',overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14,fontFamily: 'Barlow',fontWeight: FontWeight.w400,color: Colors.white)),
          ),

          const SizedBox(height: 12),

          /// Premium button
           DrawerWidget(
            onTap: (){  Navigator.pop(context); },
              icon: AppIcons.premium,
              title: 'Premium'
          ),
            const Gap(20),
          /// Settings button
          DrawerWidget(
              onTap: (){  Navigator.pop(context); },
              icon: AppIcons.setting,
              title: 'Settings'
          ),
          const Gap(28),
          /// Articles button
          DrawerWidget(
              onTap: (){  Navigator.pop(context); },
              icon: AppIcons.article,
              title: 'Articles'
          ),
          const Gap(16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: WDivider(),
          ),
          const Gap(16),
          /// Help button
          DrawerWidget(
              onTap: (){  Navigator.pop(context); },
              icon: AppIcons.help,
              title: 'Help'
          ),
          const Gap(24),
          /// Terms button
          DrawerWidget(
              onTap: (){  Navigator.pop(context); },
              icon: AppIcons.terms,
              title: 'Terms'
          ),
          const Gap(24),
          /// FAQ button
          DrawerWidget(
              onTap: (){  Navigator.pop(context); },
              icon: AppIcons.faq,
              title: 'FAQ'
          ),

        ],
      ),
    );
  }
}