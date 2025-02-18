import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';
import 'package:unimove/api/user_api.dart';
import 'package:unimove/pages/authentications/register.dart';
import 'package:unimove/themes/theme_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final ThemeController themeController = Get.find();
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login - Unimove',
          style: themeController.currentTheme.textTheme.displayLarge,
        ),
      ),
      backgroundColor: themeController.currentTheme.scaffoldBackgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: Image(
                    image: AssetImage(
                      'assets/images/login.png',
                    ),
                  ),
                  width: 170,
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        TextField(
                          controller: emailController,
                          enableIMEPersonalizedLearning: true,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: themeController
                                .currentTheme.textTheme.bodyLarge,
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
                          height: 30,
                        ),
                        TextField(
                          controller: passwordController,
                          enableIMEPersonalizedLearning: true,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                isHidden
                                    ? UniconsLine.eye
                                    : UniconsLine.eye_slash,
                              ),
                              onPressed: () {
                                setState(() {
                                  isHidden = !isHidden;
                                });
                              },
                            ),
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          obscureText: isHidden,
                          obscuringCharacter: '-',
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 30.0),
                          width: Get.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: Get.width / 2 - 50,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    await authApi.login(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  },
                                  child: Text(
                                    'Login',
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: themeController
                                        .currentTheme
                                        .appBarTheme
                                        .backgroundColor,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              Container(
                                width: Get.width / 2 - 50,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    Get.to(() => RegisterPage());
                                  },
                                  child: Text(
                                    'Register',
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: themeController
                                        .currentTheme.primaryColor,
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
