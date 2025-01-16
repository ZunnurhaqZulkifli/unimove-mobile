import 'package:unimove/controllers/biometric_controller.dart';
import 'package:unimove/controllers/base_app_controller.dart';
import 'package:unimove/controllers/customer_booking_controller.dart';
import 'package:unimove/helpers/snackbar_helpers.dart';
import 'package:unimove/helpers/storage.dart';
import 'package:unimove/models/order.dart';
import 'package:unimove/models/user.dart';
import 'package:unimove/models/wallet.dart';
import 'package:unimove/pages/splash.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'dart:io';

part 'api_config.dart';
part 'auth_api.dart';
part 'customer_api.dart';
part 'driver_api.dart';

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
  BiometricController biometricController = Get.put(BiometricController());

  Map<String, String> headers() {
    String token = storage.read('token') ?? '';

    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + '$token',
    };
  }

  Future checkApi() async {
    try {
      var response = await dio.get(
        '$endpoint/api/v1/check',
      );

      if (response.statusCode == 200) {
        return true;
      }
    } on DioException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }

    return false;
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
        controller.user.value = User.fromJson(responseData);
        controller.user_type.value = responseData['typeable_type'] ?? '';

        topSnackBarSuccess(
          title: 'Login Successful !',
          message: 'Welcome back, ${controller.user.value?.name}',
        );

        print(controller.user.value?.name);
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

        Future.delayed(Duration(seconds: 3), () {
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

  Future getDestinations() async {
    try {
      var response = await dio.get(
        '$endpoint/api/v1/destinations',
        options: Options(
          headers: headers(),
        ),
      );

      if (response.statusCode == 200) {
        var responseData = response.data['data'];

        controller.destinationController.setDestinationsModel(responseData);
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

  Future getWallet() async {
    print('loading user wallet...');
    try {
      var response = await dio.get(
        '$endpoint/api/v1/user-wallet',
        options: Options(
          headers: headers(),
        ),
      );

      if (response.statusCode == 200) {
        var responseData = response.data['data'];
        controller.user.value?.wallet = Wallet.fromJson(responseData);
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

final userApi = Api();
