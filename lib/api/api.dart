import 'package:unimove/controllers/biometric_controller.dart';
import 'package:unimove/controllers/base_app_controller.dart';
import 'package:unimove/helpers/snackbar_helpers.dart';
import 'package:unimove/helpers/storage.dart';
import 'package:unimove/models/user.dart';
import 'package:unimove/pages/dashboard.dart';
import 'package:unimove/pages/splash.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'dart:io';

part 'api_config.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class Api {
  String endpoint = ENDPOINT;
  final dio = Dio();
  BaseAppController controller = Get.find();

  Map<String, String> headers() {
    String token = storage.read('token') ?? '';

    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + '$token',
    };
  }

  Future testAllEndpoint() async {
    return [
      await dio.get(
        '$endpoint/api/v1/check',
      ),
      await login(email: 'zunnurhaq123@gmail.com', password: 'Password1234'),
    ];
  }

  Future login({required String email, required String password}) async {
    try {
      var response = await dio.post(
        '$endpoint/api/v1/login',
        options: Options(
          headers: headers(),
        ),
        queryParameters: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        controller.setToken(response.data['data']['token'].toString());
        controller.setUser(User.fromJson(response.data['data']));

        topSnackBarSuccess(
          title: 'Login Successful !',
          message: 'Welcome back, ${controller.user!.name}',
        );

        Get.offAll(() => Dashboard());
      }

      print(response.data['data']['token']);
    } on DioException catch (e) {
      if (e.response != null) {
        var error = e.response!.data['message'];

        topSnackBarAction(
          title: 'Authentication Error',
          message: error ?? 'Invalid email or password',
        );
      } else {
        print(e);
      }
    } catch (e) {
      print(e);
    }
  }

  Future logout() async {
    print(controller.auth_token);

    try {
      var response = await dio.post(
        '$endpoint/api/v1/logout',
        options: Options(
          headers: headers(),
        ),
      );

      if (response.statusCode == 200) {
        controller.clearSettings();
        Get.offAll(() => SplashScreen());
      }
    } on DioException catch (e) {
      print(e);
    }
  }

  Future<bool> profile() async {
    try {
      var response = await dio.post(
        '$endpoint/api/v1/profile',
        options: Options(
          headers: headers(),
        ),
      );

      if (response.statusCode == 200) {
        var responseData = response.data['data'];
        controller.setUser(User.fromJson(responseData));
        controller.user_type.value = responseData['typeable_type'] ?? '';

        topSnackBarSuccess(
          title: 'Login Successful !',
          message: 'Welcome back, ${controller.user!.name}',
        );

        print(controller.user!.name);
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);

        if (e.response!.data['message'] == 'Unauthenticated.') {
          topSnackBarAction(
            title: 'Session Expired',
            message: 'Please login again',
          );

          return false;
        }

        Map<String, dynamic> errors = e.response!.data['errors'];
        errors.forEach((key, value) {
          print('$key: ${value.join(', ')}');
        });

        topSnackBarAction(
          title: 'Validation Error',
          message: errors.values.map((e) => e.join(', ')).join('\n'),
        );
      } else {
        print(e);
      }

      return false;
    } catch (e) {
      print(e);

      return false;
    }
  }

  Future getBiometric() async {
    try {
      var response = await dio.get(
        '$endpoint/api/v1/user-biometric',
        options: Options(
          headers: headers(),
        ),
      );

      if (response.statusCode == 200) {
        var responseData = response.data['data'][0];
        return Biometric.fromJson(responseData);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);

        Map<String, dynamic> errors = e.response!.data['errors'];
        errors.forEach((key, value) {
          print('$key: ${value.join(', ')}');
        });

        topSnackBarAction(
          title: 'Validation Error',
          message: errors.values.map((e) => e.join(', ')).join('\n'),
        );
      } else {
        print(e);
      }
    }

    return [];
  }

  Future<String> requestTac({
    required String email,
    required String name,
  }) async {
    try {
      var response = await dio.post(
        '$endpoint/api/v1/request-tac',
        queryParameters: {
          'name': name,
          'email': email,
        },
      );

      if (response.statusCode == 200) {
        var tacResponse = response.data['data']['tac'].toString();

        topSnackBarSuccess(
          title: 'TAC Requested !',
          message: response.data['message'],
        );

        return tacResponse;
      }
    } on DioException catch (e) {
      print(e);
    }

    return '';
  }

  Future updateProfile(Map<String, dynamic> data) async {
    try {
      var response = await dio.post(
        '$endpoint/api/v1/update-profile',
        options: Options(
          headers: headers(),
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        topSnackBarSuccess(
          title: 'Profile Updated !',
          message: response.data['message'],
        );

        topSnackBarAction(
          title: 'Please Wait...',
          message: 'Reloading Updated Data, Please Login Again',
        );

        Future.delayed(Duration(seconds: 7), () {
          controller.clearSettings();
          Get.offAll(() => SplashScreen());
        });
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        Map<String, dynamic> errors = e.response!.data['errors'];
        errors.forEach((key, value) {
          print('$key: ${value.join(', ')}');
        });

        topSnackBarAction(
          title: 'Validation Error',
          message: errors.values.map((e) => e.join(', ')).join('\n'),
        );
      } else {
        print(e);
      }
    } catch (e) {
      print(e);
    }
  }

  Future register({
    required String name,
    required String email,
    required String username,
    required String password,
    required String password_confirmation,
    required String tac,
  }) async {
    try {
      var response = await dio.post(
        '$endpoint/api/v1/register',
        queryParameters: {
          'name': name,
          'email': email,
          'username': username,
          'password': password,
          'password_confirmation': password_confirmation,
          'tac': tac,
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        var responseData = response.data['data'];

        controller.setToken(responseData['user']['token'].toString());

        topSnackBarSuccess(
          title: 'Successful Registration !',
          message: responseData['message'],
        );

        Get.offAll(() => SplashScreen());
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        Map<String, dynamic> errors = e.response!.data['errors'];
        errors.forEach((key, value) {
          print('$key: ${value.join(', ')}');
        });

        topSnackBarAction(
          title: 'Validation Error',
          message: errors.values.map((e) => e.join(', ')).join('\n'),
        );
      } else {
        print(e);
      }
    } catch (e) {
      print(e);
    }
  }
}

final api = Api();
