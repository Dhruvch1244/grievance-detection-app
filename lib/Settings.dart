import 'package:Deshatan/Profile.dart';
import 'package:Deshatan/changepassword.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'index.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationEnabled = false;

  @override
  void initState() {
    super.initState();
    loadNotificationSetting();
  }

  Future<void> loadNotificationSetting() async {
    bool isEnabled = await getNotificationSetting();
    setState(() {
      notificationEnabled = isEnabled;
    });
  }

  Future<void> saveNotificationSetting(bool isEnabled) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notification_enabled', isEnabled);
  }

  Future<bool> getNotificationSetting() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('notification_enabled') ?? false;
  }

  Future<void> logOut() async {
    // Implement your log out logic here
    // For example, clear user session, navigate to login screen, etc.
  }

  List<Widget> buildSettingsList() {
    List<Widget> settingsList = [];

    // Enable Notifications Switch
    settingsList.add(
      SwitchListTile(
        title: Text('Enable Notifications'),
        value: notificationEnabled,
        onChanged: (bool value) {
          setState(() {
            notificationEnabled = value;
          });
          saveNotificationSetting(value);
        },
      ),
    );

    // Change Password Button
    settingsList.add(
      ListTile(
        leading: Icon(Icons.lock),
        title: Text('Change Password'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChangePasswordScreen(),
            ),
          );
        },
      ),
    );

    // Log Out Button
    settingsList.add(
      ListTile(
        leading: Icon(Icons.logout),
        title: Text('Log Out'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => IndexPage(),
          ),
          );
        },
      ),
    );

    return settingsList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Color(0xFF023436),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: buildSettingsList(),
      ),
    );
  }

}
