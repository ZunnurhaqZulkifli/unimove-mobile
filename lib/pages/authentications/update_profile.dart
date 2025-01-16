import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';
import 'package:unimove/api/user_api.dart';
import 'package:unimove/controllers/base_app_controller.dart';
import 'package:unimove/themes/theme_controller.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  String user_type = '';
  bool canSubmit = false;
  final ThemeController themeController = Get.find();
  Map<String, dynamic> profileData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Profile',
          style: themeController.currentTheme.textTheme.displayLarge,
        ),
      ),
      backgroundColor: themeController.currentTheme.scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 10),
              Text(
                'Note : What would you like to sign-up as ?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                (user_type == '')
                    ? "Reminder : You can't change this later once your profile is set."
                    : "Please fill in your details.",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  wordSpacing: 1,
                  color: (user_type == '') ? Colors.red : Colors.green,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                (user_type == '')
                    ? 'Select your role'
                    : "( " + (user_type) + " )",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 30),
              (user_type == '')
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: Get.width / 4,
                          width: Get.width / 4,
                          child: InkWell(
                            onTap: () => setState(() {
                              user_type = 'student';
                            }),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      UniconsLine.user,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 15),
                                    Text(
                                      'Student',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => setState(() {
                            user_type = 'staff';
                          }),
                          child: Container(
                            height: Get.width / 4,
                            width: Get.width / 4,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      UniconsLine.mobile_android,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 15),
                                    Text(
                                      'Staff',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => setState(() {
                            user_type = 'driver';
                          }),
                          child: Container(
                            height: Get.width / 4,
                            width: Get.width / 4,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      UniconsLine.streering,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 15),
                                    Text(
                                      'Driver',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : SizedBox(),
              SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: ProfileForms(
                    onChange: (canSubmit)
                        ? (value) {
                            setState(() {
                              profileData = value;
                            });
                          }
                        : (value) {},
                    canSubmit: (value) {
                      Future.delayed(Duration(milliseconds: 200), () {
                        setState(() {
                          canSubmit = value;
                        });
                      });
                    },
                    type: user_type,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: (user_type != '')
          ? FloatingActionButton(
              onPressed: () async {
                if (canSubmit) {
                  profileData['type'] = user_type;
                  print(profileData);

                  await userApi.updateProfile(profileData);
                } else {
                  setState(() {
                    user_type = '';
                  });
                }
              },
              child: Icon(
                (canSubmit) ? UniconsLine.check : UniconsLine.refresh,
              ),
            )
          : null,
    );
  }
}

class ProfileForms extends StatefulWidget {
  final Function(bool) canSubmit;
  final Function(Map<String, dynamic>) onChange;
  final String type;

  const ProfileForms({
    super.key,
    required this.type,
    required this.canSubmit,
    required this.onChange,
  });

  @override
  State<ProfileForms> createState() => _ProfileFormsState();
}

class _ProfileFormsState extends State<ProfileForms> {
  Map<String, dynamic> profile = {};
  BaseAppController controller = Get.find();

  Map<String, dynamic> student_fields = {
    'student_id': '',
    'phone': '',
    'address': '',
  };

  Map<String, dynamic> staff_fields = {
    'staff_id': '',
    'phone': '',
    'address': '',
  };

  Map<String, dynamic> driver_fields = {
    'driver_id': '',
    'phone': '',
    'address': '',
    'license_no': '',
  };

  List<Widget> fields = [];

  void canSubmit(Map<String, dynamic> profile) {
    for (var item in profile.entries) {
      if (item.value == '') {
        widget.canSubmit(false);
        return;
      }
    }

    if (profile.isNotEmpty) {
      widget.canSubmit(true);
    }
  }

  void setFieldTypes() {
    profile = {};

    if (widget.type == 'driver') {
      print('driver');
      setState(() {
        profile = {};
        profile = driver_fields;
      });
    }

    if (widget.type == 'student') {
      print('student');
      setState(() {
        profile = {};
        profile = student_fields;
      });
    }

    if (widget.type == 'staff') {
      print('staff');
      setState(() {
        profile = {};
        profile = staff_fields;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    setFieldTypes();
    return Padding(
      padding: const EdgeInsets.only(left: 27, right: 27),
      child: Column(
        children: [
          Builder(
            builder: (context) {
              fields = [];
              for (var item in profile.entries) {
                // skip the license_expiry and type fields
                if (item.key == 'license_expiry' || item.key == 'type') {
                  continue;
                }
                fields.add(
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: item.key,
                      hintText: 'Enter your ${item.key}',
                      prefixIcon: Icon(UniconsLine.user),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        profile[item.key] = value;
                      });

                      widget.onChange(profile);
                      canSubmit(profile);
                    },
                  ),
                );
                fields.add(SizedBox(height: 10));
              }
              return ListBody(
                children: fields,
              );
            },
          ),
          (widget.type == 'driver')
              ? Column(
                  children: [
                    InkWell(
                      onTap: () {
                        showDatePicker(
                                context: context,
                                firstDate: DateTime.parse('2021-01-01'),
                                lastDate: DateTime.now().add(
                                  Duration(days: 3650),
                                ),
                                initialDate: DateTime.now())
                            .then((value) {
                          setState(() {
                            profile['license_expiry'] = value.toString();
                          });

                          Future.delayed(Duration(milliseconds: 200), () {
                            widget.onChange(profile);
                            canSubmit(profile);
                          });
                        });
                      },
                      child: TextFormField(
                        decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          labelText: (profile['license_expiry'] != null)
                              ? profile['license_expiry']
                                  .toString()
                                  .substring(0, 10)
                              : 'Lisence Expiry',
                          hintText: 'Enter your Lisence Expiry',
                          prefixIcon: Icon(UniconsLine.calculator),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        enabled: false,
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
