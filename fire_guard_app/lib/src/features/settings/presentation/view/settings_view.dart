// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../core/resource/colors_manager.dart';
import '../../../../../core/resource/styles_manager.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool isDark = false;
  final List settingsItems = [
    {
      'title': 'Language',
      'leading': Icons.language,
      'trailing': DropdownButton<String>(
        items: const [
          DropdownMenuItem(
            child: Text(
              'English',
            ),
          ),
        ],
        onChanged: (Object? value) {},
      ),
    },
    {
      'title': 'Notifaication',
      'leading': Icons.notifications,
      'trailing': null,
    },
    {
      'title': 'Dark Mode',
      'leading': Icons.wb_sunny_outlined,
      'trailing': Switch(
        activeColor: ColorsManager.primaryColor,
        value: true,
        onChanged: (bool value) {},
      ),
    },
    {
      'title': 'Privacy Policy',
      'leading': Icons.privacy_tip_outlined,
      'trailing': null,
    },
    {
      'title': 'Logout',
      'leading': Icons.logout,
      'trailing': null,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Gap(60),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Settings',
                  style: StylesManager.interFontFamilyBold(
                    fontSize: 20,
                    color: ColorsManager.blackColor,
                  ),
                ),
                const Icon(
                  Icons.notifications_outlined,
                  color: ColorsManager.blackColor,
                ),
              ],
            ),
          ),
          const Gap(37),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return SettingsItem(
                  title: settingsItems[index]['title'],
                  iconData: settingsItems[index]['leading'],
                  trailing: settingsItems[index]['trailing'],
                );
              },
              separatorBuilder: (context, index) => const Gap(14),
              itemCount: settingsItems.length,
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  const SettingsItem({
    super.key,
    required this.title,
    this.trailing,
    required this.iconData,
  });
  final String title;
  final Widget? trailing;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(
        iconData,
      ),
      trailing: trailing,
    );
  }
}
