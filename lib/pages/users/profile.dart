import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimove/api/user_api.dart';
import 'package:unimove/controllers/base_app_controller.dart';
import 'package:unimove/pages/settings/settings.dart';
import 'package:unimove/themes/theme_controller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController passwordController = TextEditingController();
  final ThemeController themeController = Get.find();
  BaseAppController controller = Get.find();
  String userType = '';

  @override
  void initState() {
    userType = controller.user.value!.type.toString().toLowerCase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                controller.user.value!.type.toString().toLowerCase() ==
                        'student'
                    ? '👨🏼‍🎓'
                    : controller.user.value!.type.toString().toLowerCase() ==
                            'driver'
                        ? '🚘'
                        : '👨🏼‍ 💼',
                // style: themeController.currentTheme.textTheme.displayLarge,
                style: TextStyle(fontSize: 50),
              ),
              ListTile(
                title: Text('Name'),
                subtitle: Text(controller.user.value!.name ?? ''),
                visualDensity: VisualDensity.compact,
              ),
              ListTile(
                title: Text('Profile Type'),
                subtitle:
                    Text(controller.user.value!.type.toString().toUpperCase()),
                visualDensity: VisualDensity.compact,
              ),
              if (userType == 'student') StudentFields(controller: controller),
              if (userType == 'driver') DriverFields(controller: controller),
              if (userType == 'staff') StaffFields(controller: controller),
              ListTile(
                visualDensity: VisualDensity.compact,
                title: Text('App Settings'),
                onTap: () {
                  Get.to(
                    () => SettingsPage(),
                  );
                },
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Container(
          padding: const EdgeInsets.all(2),
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              await authApi.logout();
            },
            child: Text(
              'Logout',
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber[800],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class StudentFields extends StatelessWidget {
  final BaseAppController controller;
  const StudentFields({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text('Student Id'),
          subtitle: Text(controller.user.value!.profile!.student_id ?? ''),
          visualDensity: VisualDensity.compact,
        ),
        ListTile(
          title: Text('Address'),
          subtitle: Text(controller.user.value!.profile!.address ?? ''),
          visualDensity: VisualDensity.compact,
        ),
        ListTile(
          title: Text('Name'),
          subtitle: Text(controller.user.value!.profile!.name ?? ''),
          visualDensity: VisualDensity.compact,
        ),
        ListTile(
          title: Text('Phone'),
          subtitle: Text(controller.user.value!.profile!.phone ?? ''),
          visualDensity: VisualDensity.compact,
        ),
        ListTile(
          title: Text('Status'),
          subtitle: Text(controller.user.value!.profile!.status ?? ''),
          visualDensity: VisualDensity.compact,
        ),
        ListTile(
          title: Text('Verified'),
          subtitle: Text(
            controller.user.value!.profile!.verified.toString(),
          ),
          visualDensity: VisualDensity.compact,
        ),
      ],
    );
  }
}

class DriverFields extends StatelessWidget {
  final BaseAppController controller;
  const DriverFields({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text('Uniten Id'),
          subtitle: Text(controller.user.value!.profile!.driver_id ?? ''),
          visualDensity: VisualDensity.compact,
        ),
        ListTile(
          title: Text('Address'),
          subtitle: Text(controller.user.value!.profile!.address ?? ''),
          visualDensity: VisualDensity.compact,
        ),
        ListTile(
          title: Text('Name'),
          subtitle: Text(controller.user.value!.profile!.name ?? ''),
          visualDensity: VisualDensity.compact,
        ),
        ListTile(
          title: Text('Phone'),
          subtitle: Text(controller.user.value!.profile!.phone ?? ''),
          visualDensity: VisualDensity.compact,
        ),
        ListTile(
          title: Text('Status'),
          subtitle: Text(controller.user.value!.profile!.status ?? ''),
          visualDensity: VisualDensity.compact,
        ),
        ListTile(
          title: Text('Verified'),
          subtitle: Text(
            controller.user.value!.profile!.verified.toString(),
          ),
          visualDensity: VisualDensity.compact,
        ),
      ],
    );
  }
}

class StaffFields extends StatelessWidget {
  final BaseAppController controller;
  const StaffFields({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text('Student Id'),
          subtitle: Text(controller.user.value!.profile!.student_id ?? ''),
          visualDensity: VisualDensity.compact,
        ),
        ListTile(
          title: Text('Address'),
          subtitle: Text(controller.user.value!.profile!.address ?? ''),
          visualDensity: VisualDensity.compact,
        ),
        ListTile(
          title: Text('Name'),
          subtitle: Text(controller.user.value!.profile!.name ?? ''),
          visualDensity: VisualDensity.compact,
        ),
        ListTile(
          title: Text('Phone'),
          subtitle: Text(controller.user.value!.profile!.phone ?? ''),
          visualDensity: VisualDensity.compact,
        ),
        ListTile(
          title: Text('Status'),
          subtitle: Text(controller.user.value!.profile!.status ?? ''),
          visualDensity: VisualDensity.compact,
        ),
        ListTile(
          title: Text('Verified'),
          subtitle: Text(
            controller.user.value!.profile!.verified.toString(),
          ),
          visualDensity: VisualDensity.compact,
        ),
      ],
    );
  }
}
