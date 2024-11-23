import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';
import 'package:unimove/api/api.dart';
import 'package:unimove/helpers/string_helpers.dart';
import 'package:unimove/helpers/snackbar_helpers.dart';
import 'package:unimove/themes/theme.dart';
import 'package:unimove/themes/theme_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfimationController = TextEditingController();
  TextEditingController tacController = TextEditingController();
  final ThemeController themeController = Get.find();
  bool isTacValid = false;
  String serverTac = '';
  bool isShownPassword = false;

  bool checkTac() {
    if (tacController.text.length < 6) {
    } else {
      if (tacController.text == serverTac) {
        setState(() {
          isTacValid = true;
        });

        return true;
      } else {
        topSnackBarAction(title: 'Error', message: 'TAC Number is invalid');
        return false;
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registration Account',
          style: themeController.currentTheme.textTheme.displayLarge,
        ),
      ),
      backgroundColor: themeController.currentTheme.scaffoldBackgroundColor,
      body: Center(
        child: SizedBox(
          width: Get.width - 60,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nameController,
                enableIMEPersonalizedLearning: true,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: themeController.currentTheme.textTheme.bodyLarge,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                ),
                onChanged: (value) {
                  Future.delayed(Duration(milliseconds: 0), () {
                    nameController.text = value
                        // .replaceAll(' ', '-')
                        .toString()
                        .toTitleCase(); // Set username to lowercase and remove spaces
                  });
                },
                textAlignVertical: TextAlignVertical.center,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: usernameController,
                enableIMEPersonalizedLearning: true,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                ],
                onChanged: (value) {
                  Future.delayed(Duration(milliseconds: 100), () {
                    usernameController.text = value
                        .replaceAll(' ', '-')
                        .toUpperCase(); // Set username to lowercase and remove spaces
                  });
                },
                maxLength: 12,
                decoration: InputDecoration(
                  labelText: 'Nric / Passport',
                  labelStyle: themeController.currentTheme.textTheme.bodyLarge,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                ),
                textAlignVertical: TextAlignVertical.center,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: emailController,
                enableIMEPersonalizedLearning: true,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: themeController.currentTheme.textTheme.bodyLarge,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                ),
                textAlignVertical: TextAlignVertical.center,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                obscureText: (isShownPassword) ? false : true,
                controller: passwordController,
                enableIMEPersonalizedLearning: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: themeController.currentTheme.textTheme.bodyLarge,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      (isShownPassword)
                          ? UniconsLine.eye_slash
                          : UniconsLine.eye,
                    ),
                    onPressed: () {
                      setState(() {
                        isShownPassword = !isShownPassword;
                      });
                    },
                  ),
                ),
                textAlignVertical: TextAlignVertical.center,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                obscureText: (isShownPassword) ? false : true,
                controller: passwordConfimationController,
                enableIMEPersonalizedLearning: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      enabled: (serverTac == '') ? false : true,
                      controller: tacController,
                      enableIMEPersonalizedLearning: true,
                      decoration: InputDecoration(
                        labelText: 'TAC Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          isTacValid = false;
                        });

                        if (value.length == 6) {
                          checkTac();
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (nameController.text == '' ||
                          emailController.text == '') {
                        topSnackBarAction(
                            title: 'Error',
                            message: 'Name and Email is required');
                        return;
                      } else {
                        var tacData = await api.requestTac(
                          name: nameController.text,
                          email: emailController.text,
                        );

                        setState(() {
                          serverTac = tacData;
                        });
                      }
                    },
                    child: Icon(UniconsLine.envelope),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: (serverTac == '')
                            ? ThemeColors.oldYellow
                            : Colors.grey,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: Size(40, 50)),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 20.0),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await checkTac();

                    (!isTacValid)
                        ? topSnackBarAction(
                            title: 'Error', message: 'TAC Number is required')
                        : await api.register(
                            name: nameController.text,
                            email: emailController.text,
                            username: usernameController.text,
                            password: passwordController.text,
                            password_confirmation:
                                passwordConfimationController.text,
                            tac: tacController.text,
                          );
                  },
                  child: Text(
                    'Register',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: (isTacValid)
                        ? themeController
                            .currentTheme.appBarTheme.backgroundColor
                        : Colors.grey,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
