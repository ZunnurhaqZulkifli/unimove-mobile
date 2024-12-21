import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimove/api/api.dart';
import 'package:unimove/controllers/base_app_controller.dart';
import 'package:unimove/pages/settings.dart';
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
    userType = controller.user!.type.toString().toLowerCase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(
          20.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Profile',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
              ListTile(
                title: Text('Name'),
                subtitle: Text(controller.user!.name ?? ''),
                visualDensity: VisualDensity.compact,
              ),
              ListTile(
                title: Text('Profile Type'),
                subtitle: Text(controller.user!.type.toString().toUpperCase()),
                visualDensity: VisualDensity.compact,
              ),
              if (userType == 'student') StudentFields(controller: controller),
              if (userType == 'driver') DriverFields(controller: controller),
              if (userType == 'staff') StaffFields(controller: controller),
              ListTile(
                visualDensity: VisualDensity.compact,
                title: Text('Destination Settings'),
                onTap: () {
                  Get.to(
                    () => SettingsPage(),
                  );
                },
                trailing: Icon(Icons.arrow_forward_ios),
              ),
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
              await api.logout();
            },
            child: Text(
              'Logout',
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
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
          subtitle: Text(controller.user!.profile!.student_id ?? ''),
          visualDensity: VisualDensity.compact,
        ),
        ListTile(
          title: Text('address'),
          subtitle: Text(controller.user!.profile!.address ?? ''),
          visualDensity: VisualDensity.compact,
        ),
        ListTile(
          title: Text('name'),
          subtitle: Text(controller.user!.profile!.name ?? ''),
          visualDensity: VisualDensity.compact,
        ),
        ListTile(
          title: Text('phone'),
          subtitle: Text(controller.user!.profile!.phone ?? ''),
          visualDensity: VisualDensity.compact,
        ),
        ListTile(
          title: Text('status'),
          subtitle: Text(controller.user!.profile!.status ?? ''),
          visualDensity: VisualDensity.compact,
        ),
        ListTile(
          title: Text('verified'),
          subtitle: Text(
            controller.user!.profile!.verified.toString(),
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
          title: Text('Student Id'),
          subtitle: Text(controller.user!.profile!.student_id ?? ''),
          visualDensity: VisualDensity.compact,
        ),
        ListTile(
          title: Text('address'),
          subtitle: Text(controller.user!.profile!.address ?? ''),
          visualDensity: VisualDensity.compact,
        ),
        ListTile(
          title: Text('name'),
          subtitle: Text(controller.user!.profile!.name ?? ''),
          visualDensity: VisualDensity.compact,
        ),
        ListTile(
          title: Text('phone'),
          subtitle: Text(controller.user!.profile!.phone ?? ''),
          visualDensity: VisualDensity.compact,
        ),
        ListTile(
          title: Text('status'),
          subtitle: Text(controller.user!.profile!.status ?? ''),
          visualDensity: VisualDensity.compact,
        ),
        ListTile(
          title: Text('verified'),
          subtitle: Text(
            controller.user!.profile!.verified.toString(),
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
          subtitle: Text(controller.user!.profile!.student_id ?? ''),
          visualDensity: VisualDensity.compact,
        ),
        ListTile(
          title: Text('address'),
          subtitle: Text(controller.user!.profile!.address ?? ''),
          visualDensity: VisualDensity.compact,
        ),
        ListTile(
          title: Text('name'),
          subtitle: Text(controller.user!.profile!.name ?? ''),
          visualDensity: VisualDensity.compact,
        ),
        ListTile(
          title: Text('phone'),
          subtitle: Text(controller.user!.profile!.phone ?? ''),
          visualDensity: VisualDensity.compact,
        ),
        ListTile(
          title: Text('status'),
          subtitle: Text(controller.user!.profile!.status ?? ''),
          visualDensity: VisualDensity.compact,
        ),
        ListTile(
          title: Text('verified'),
          subtitle: Text(
            controller.user!.profile!.verified.toString(),
          ),
          visualDensity: VisualDensity.compact,
        ),
      ],
    );
  }
}
