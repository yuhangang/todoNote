import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noname/views/home/home_page.dart';
import 'package:noname/state/providers/global/globalProvider.dart';
import 'package:noname/state/providers/local/edit_todo/edit_todo_provider.dart';
import 'package:noname/widgets/setting/button_setting_item.dart';
import 'package:noname/widgets/setting/switch_button_item.dart';

class AccountPage extends StatelessWidget {
  static const route = "/account-page";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomePage.homePageAppbar(context, title: 'Account'),
      body: Container(
        padding: const EdgeInsets.only(top: 10),
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            Consumer(
              builder: (_, watch, child) {
                return SwitchButtonItem(
                  value: watch(GlobalProvider.themeProvider).isDarkMode,
                  title: "dark mode",
                  onchange: (bool val) {
                    context
                        .read(GlobalProvider.themeProvider.notifier)
                        .switchDarkLightMode(val);
                  },
                );
              },
            ),
            const Divider(),
            SwitchButtonItem(
              value: true,
              disabled: true,
            ),
            ButtonSettingItem(
              title: 'Sign Out',
              icon: Icon(Icons.logout),
              onTapItem: () {
                context.read(GlobalProvider.authProvider.notifier).signOut();
              },
            )
          ],
        ),
      ),
    );
  }
}
