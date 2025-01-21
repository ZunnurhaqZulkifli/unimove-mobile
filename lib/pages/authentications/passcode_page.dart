import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimove/api/user_api.dart';
import 'package:unimove/controllers/base_app_controller.dart';
import 'package:unimove/controllers/biometric_controller.dart';
import 'package:unimove/controllers/dashboard_controller.dart';
import 'package:unimove/helpers/snackbar_helpers.dart';
import 'package:unimove/pages/dashboard.dart';
import 'package:unimove/pages/settings/maintainance_mode.dart';
import 'package:unimove/themes/theme.dart';

class PasscodePage extends StatefulWidget {
  const PasscodePage({super.key});

  @override
  State<PasscodePage> createState() => _PasscodePageState();
}

class _PasscodePageState extends State<PasscodePage> {
  BaseAppController baseAppController = Get.put(BaseAppController());
  DashboardController dashboardController = Get.put(DashboardController());
  TextEditingController passcodeController = TextEditingController();
  BiometricController biometricController = Get.find();
  String passcode = '';
  bool firstTimeSetup = false;

  void checkPasscode() {
    print('Checking Passcode');

    if (passcodeController.text == passcode) {
      topSnackBarInfo(
          title: 'Authentication Successful !',
          message: 'Welcome back, ' + baseAppController.user.value!.name!);

      Get.offAll(() => Dashboard());
    } else {
      topSnackBarAction(
          title: 'Wrong Passcode',
          message: 'The passcode you entered is incorrect');
    }
  }

  void createPasscode() async {
    if (passcodeController.text.length < 6) {
      topSnackBarAction(
          title: 'Passcode too short',
          message: 'Passcode must be at least 6 characters long !');
    } else {
      var passcodeData = {
        'type': 'passcode',
        'passcode_number': passcodeController.text,
        'initial': true,
      };

      if (await authApi.updateBiometric(passcodeData)) {
        setState(() {
          passcode = passcodeController.text;
          firstTimeSetup = false;
        });
      }
    }
  }

  void checkUserBiometrics() async {
    await authApi.getBiometric();

    // if the biometric is not enabled, then it should create a passcode (first time setup)
    if (!biometricController.biometric.value.enabled!) {
      setState(() {
        firstTimeSetup = true;
      });
    } else {
      // this is when the biometric is enabled
      setState(() {
        passcode = biometricController.biometric.value.passcode_number!;
      });

      if (baseAppController.user.value!.name == 'Zunnurhaq' ||
          baseAppController.user.value!.name == 'System Administrator' ||
          baseAppController.user.value!.name == 'Student 04') {
        Future.delayed(Duration(milliseconds: 400), () {
          passcodeController.text = passcode;
        });

        Future.delayed(Duration(milliseconds: 2500), () {
          checkPasscode();
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    checkUserBiometrics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Enter Passcode',
          style: themeController.currentTheme.textTheme.displayLarge,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: TextField(
                readOnly: true,
                keyboardType: TextInputType.number,
                controller: passcodeController,
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                onTap: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.white,
                    context: context,
                    builder: (context) {
                      return PasscodeGridButton(
                        passcodeController: passcodeController,
                        firstTimeSetup: firstTimeSetup,
                        checkPasscode: checkPasscode,
                        createPasscode: createPasscode,
                        onKeyPressed: () {
                          Navigator.pop(context);

                          Future.delayed(
                            Duration(milliseconds: 200),
                            () {
                              if (!firstTimeSetup) {
                                if (passcodeController.text.length == 6) {
                                  return checkPasscode();
                                }
                              } else {
                                if (passcodeController.text.length == 6) {
                                  return createPasscode();
                                }
                              }
                            },
                          );
                        },
                      );
                    },
                  );
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Passcode',
                ),
                onChanged: (value) => {
                  if (value.length == 6)
                    {
                      setState(() {
                        passcodeController.text = value;
                      })
                    }
                },
                maxLength: 6,
              ),
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Forgot Passcode ?'),
            TextButton(
              onPressed: () {
                Get.to(() => ResetPasscodePage());
              },
              child: Text('Reset Passcode'),
            ),
          ],
        )
      ],
    );
  }
}

class PasscodeGridButton extends StatefulWidget {
  final TextEditingController passcodeController;
  final bool firstTimeSetup;
  final Function checkPasscode;
  final Function createPasscode;
  final Function() onKeyPressed;
  // final Function onBackspacePressed;

  const PasscodeGridButton({
    super.key,
    required this.onKeyPressed,
    required this.passcodeController,
    required this.firstTimeSetup,
    required this.checkPasscode,
    required this.createPasscode,
  });

  @override
  State<PasscodeGridButton> createState() => _PasscodeGridButtonState();
}

class _PasscodeGridButtonState extends State<PasscodeGridButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextField(
            readOnly: true,
            keyboardType: TextInputType.number,
            controller: widget.passcodeController,
            // onTapOutside: (event) {
            //   FocusScope.of(context).unfocus();
            // },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter Passcode',
            ),
            onChanged: (value) => {
              if (value.length == 6)
                {
                  setState(() {
                    widget.passcodeController.text = value;
                  })
                }
            },
            maxLength: 6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PasscodeButton(
                passcodeController: widget.passcodeController,
                number: '1',
              ),
              PasscodeButton(
                passcodeController: widget.passcodeController,
                number: '2',
              ),
              PasscodeButton(
                passcodeController: widget.passcodeController,
                number: '3',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PasscodeButton(
                passcodeController: widget.passcodeController,
                number: '4',
              ),
              PasscodeButton(
                passcodeController: widget.passcodeController,
                number: '5',
              ),
              PasscodeButton(
                passcodeController: widget.passcodeController,
                number: '6',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PasscodeButton(
                passcodeController: widget.passcodeController,
                number: '7',
              ),
              PasscodeButton(
                passcodeController: widget.passcodeController,
                number: '8',
              ),
              PasscodeButton(
                passcodeController: widget.passcodeController,
                number: '9',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PasscodeButton(
                passcodeController: widget.passcodeController,
                number: '0',
              ),
              PasscodeButton(
                passcodeController: widget.passcodeController,
                number: 'C',
              ),
              PasscodeButton(
                passcodeController: widget.passcodeController,
                number: '>',
                onPressed: () => widget.onKeyPressed(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PasscodeButton extends StatefulWidget {
  final TextEditingController passcodeController;
  final String number;
  final Function()? onPressed;

  const PasscodeButton({
    Key? key,
    required this.passcodeController,
    required this.number,
    this.onPressed,
  }) : super(key: key);

  @override
  State<PasscodeButton> createState() => _PasscodeButtonState();
}

class _PasscodeButtonState extends State<PasscodeButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ThemeColors.orange100,
          fixedSize: Size(Get.width / 3 - 40, Get.width / 3 - 80),
        ),
        onPressed: () {
          if (widget.number == 'C') {
            setState(() {
              widget.passcodeController.text = '';
            });
          }

          if (widget.number == '>') {
            widget.onPressed!();
          }

          if (widget.number != 'C' && widget.number != '>') {
            if (widget.passcodeController.text.length < 6) {
              setState(() {
                widget.passcodeController.text += widget.number;
              });
            }
          }
        },
        child: Text(
          widget.number,
          style: (widget.number == 'E')
              ? TextStyle(
                  fontSize: 12,
                )
              : TextStyle(
                  fontSize: 20,
                ),
        ),
      ),
    );
  }
}

class ResetPasscodePage extends StatelessWidget {
  const ResetPasscodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Passcode'),
      ),
      body: Container(
        child: Text('Reset Passcode'),
      ),
    );
  }
}
