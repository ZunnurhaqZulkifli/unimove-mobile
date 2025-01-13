part of 'api.dart';

class Api2 extends Api {
  // bbok destination
  Future bookDestination(Map<String, dynamic> data) async {
    try {
      var response = await dio.post(
        '$endpoint/api/v1/order-ride',
        options: Options(
          headers: headers(),
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        var responseData = response.data['data'];

        print(responseData);

        topSnackBarSuccess(
          title: 'Booking Successful !',
          message: 'Your Destination To Has, ${controller.user!.name}',
        );
      } else {
        print(response.data);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);

        Map<String, dynamic> errors = e.response!.data['errors'];
        errors.forEach((key, value) {
          print('$key: ${value.join(', ')}');
        });

        topSnackBarAction(
          title: 'Booking Error',
          message: errors.values.map((e) => e.join(', ')).join('\n'),
        );
      } else {
        print(e);
      }
    } catch (e) {
      print(e);
    }
  }

  // this gets all the orders
  Future<RxList<Order>> getOrders() async {
    try {
      var response = await dio.get(
        '$endpoint/api/v1/orders',
        options: Options(
          headers: headers(),
        ),
      );

      if (response.statusCode == 200) {
        var responseData = response.data['data'];

        controller.driverOrderController.orders.clear();

        for (var item in responseData) {
          controller.driverOrderController.orders.add(Order.fromJson(item));
        }

        return controller.driverOrderController.orders;
      }
      return controller.driverOrderController.orders;
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
        return controller.driverOrderController.orders;
      }
      
      return controller.driverOrderController.orders;

    } catch (e) {
      return controller.driverOrderController.orders;
    }
  }

  Future getMyOrders() async {
    try {
      var response = await dio.get(
        '$endpoint/api/v1/my-orders',
        options: Options(
          headers: headers(),
        ),
      );

      if (response.statusCode == 200) {
        var responseData = response.data['data'];

        controller.driverOrderController.myOrders.clear();

        if (responseData != null) {
          for (var item in responseData) {
            controller.driverOrderController.myOrders.add(Order.fromJson(item));
          }

          // this checks if the user has orders or nto
          if (controller.driverOrderController.myOrders.isNotEmpty) {
            controller.hasOrder.value = true;
          } else {
            controller.hasOrder.value = false;
          }
        }
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

  Future acceptOrder(int id) async {
    print(id.toString());
    try {
      var response = await dio.post(
        '$endpoint/api/v1/accept-order',
        options: Options(
          headers: headers(),
        ),
        data: {
          'order_id': id,
        },
      );

      if (response.statusCode == 200) {
        var responseData = response.data['data'];

        print(responseData);

        topSnackBarSuccess(
          title: 'Order Accepted !',
          message: 'Your Order Has Been Accepted',
        );
      } else {
        print(response.data);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);

        Map<String, dynamic> errors = e.response!.data['errors'];
        errors.forEach((key, value) {
          print('$key: ${value.join(', ')}');
        });

        topSnackBarAction(
          title: 'Booking Error',
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
    try {
      var response = await dio.get(
        '$endpoint/api/v1/user-wallet',
        options: Options(
          headers: headers(),
        ),
      );

      if (response.statusCode == 200) {
        var responseData = response.data['data'];
        controller.user!.wallet = Wallet.fromJson(responseData);
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

  Future<Map<String, dynamic>> calculateData(String df, String dt) async {
    try {
      var response = await dio.post(
        '$endpoint/api/v1/calculate-destination',
        options: Options(
          headers: headers(),
        ),
        data: {
          'df': df,
          'dt': dt,
        },
      );

      if (response.statusCode == 200) {
        var responseData = response.data['data'];

        return responseData['data'];
      }

      return {};
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
        return {};
      }
    } catch (e) {
      print(e);
      return {};
    }

    return {};
  }

  Future getBooking() async {
    BookingController controller = Get.find();

    try {
      var response = await dio.get(
        '$endpoint/api/v1/get-bookings',
        options: Options(
          headers: headers(),
        ),
      );

      if (response.statusCode == 200) {
        controller.setBooking(Booking.fromJson(response.data['data']));
      }

      return {};
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);

        Map<String, dynamic> errors = e.response!.data['errors'];

        errors.forEach((key, value) {
          print('$key: ${value.join(', ')}');
        });

        topSnackBarAction(
          title: 'Application Get Error !',
          message: errors.values.map((e) => e.join(', ')).join('\n'),
        );
      } else {
        print(e);
        return {};
      }
    } catch (e) {
      print(e);
      return {};
    }

    return {};
  }

  Future<bool> checkHasBooking() async {
    try {
      var response = await dio.get(
        '$endpoint/api/v1/check-has-order',
        options: Options(
          headers: headers(),
        ),
      );

      if (response.statusCode == 200) {
        var responseData = response.data['data'];

        if (responseData) {
          return true;
        }

        return false;
      }

      return false;
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);

        Map<String, dynamic> errors = e.response!.data['errors'];

        errors.forEach((key, value) {
          print('$key: ${value.join(', ')}');
        });

        topSnackBarAction(
          title: 'Application Get Error !',
          message: errors.values.map((e) => e.join(', ')).join('\n'),
        );
      } else {
        print(e);
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }

    return false;
  }

  Future getMyCurrentOrder() async {
    OrderController controller = Get.find();
    try {
      var response = await dio.get(
        '$endpoint/api/v1/my-current-order',
        options: Options(
          headers: headers(),
        ),
      );

      if (response.statusCode == 200) {
        var responseData = response.data['data'];
        controller.currentOrder = Order.fromJson(responseData[0]);

        print('current order status is : ${controller.currentOrder!.status}');

        return false;
      }

      return false;
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);

        Map<String, dynamic> errors = e.response!.data['errors'];

        errors.forEach((key, value) {
          print('$key: ${value.join(', ')}');
        });

        topSnackBarAction(
          title: 'Application Get Error !',
          message: errors.values.map((e) => e.join(', ')).join('\n'),
        );
      } else {
        print(e);
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }

    return false;
  }
}

final api2 = Api2();
