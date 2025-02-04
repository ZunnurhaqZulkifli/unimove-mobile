part of 'user_api.dart';

class CustomerApi extends Api {
  final BaseAppController _baseController = Get.put(BaseAppController());

  Future<bool> checkHasOrder() async {
    try {
      var response = await dio.get(
        '$endpoint/api/v1/customer/order-check',
        options: Options(
          headers: headers(),
        ),
      );

      if (response.statusCode == 200) {
        var responseData = response.data['data'];

        if (responseData) {
          _baseController.customerOrderController.hasOrder.value = true;
          return true;
        }

        return false;
      }

      return false;
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);
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

  Future getOrder() async {
    // CustomerOrderController controller = Get.find();
    try {
      var response = await dio.get(
        '$endpoint/api/v1/customer/get-active-order',
        options: Options(
          headers: headers(),
        ),
      );

      if (response.statusCode == 200) {
        var responseData = response.data['data'];

        if (responseData.toString() != '[]') {
          _baseController.customerOrderController.order.value =
              Order.fromJson(responseData[0]);

          _baseController.customerOrderController.isLoaded.value = true;

          print(
            'order status is : ' +
                (_baseController.customerOrderController.order.value?.status ??
                    ''),
          );
        } else if (responseData.toString() == '[]') {
          _baseController.customerOrderController.hasOrder.value = false;
          _baseController.customerOrderController.order.value = null;
        }
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);
      } else {
        print(e);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> checkHasBooking() async {
    try {
      var response = await dio.get(
        '$endpoint/api/v1/customer/booking-check',
        options: Options(
          headers: headers(),
        ),
      );

      if (response.statusCode == 200) {
        var responseData = response.data['data'];

        if (responseData) {
          _baseController.customerBookingController.hasBooking.value = true;
          return true;
        }

        return false;
      }

      return false;
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);
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

  // bbok destination
  Future bookDestination(Map<String, dynamic> data) async {
    try {
      var response = await dio.post(
        '$endpoint/api/v1/customer/order-ride',
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
          message: 'Your Destination To Has, ${controller.user.value?.name}',
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

  Future cancelOrder(var controller, var id) async {
    try {
      var response = await dio.post(
        '$endpoint/api/v1/customer/cancel-order',
        options: Options(
          headers: headers(),
        ),
        data:{'order_id' : id}
      );

      if (response.statusCode == 200) {
        var responseData = response.data['data'];

        controller.clearSettings();

        topSnackBarSuccess(
          title: 'Order Cancelled !',
          message: 'You have cancelled your order',
        );
        
        Future.delayed(Duration(seconds: 2)).then((_) => Get.to(Dashboard()));

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
          title: 'Order Error',
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

  Future<Booking?> getBooking() async {
    try {
      var response = await dio.get(
        '$endpoint/api/v1/customer/get-active-booking',
        options: Options(
          headers: headers(),
        ),
      );

      if (response.statusCode == 200) {
        var responseData = response.data['data'];

        if (responseData != null) {
          Booking booking = Booking.fromJson(responseData);
          _baseController.customerBookingController.booking.value = booking;
          _baseController.customerBookingController.isLoaded.value = true;

          return booking;
        } else {
          // Booking booking = Booking.fromJson(responseData);
          _baseController.customerBookingController.booking.value = null;
          _baseController.customerBookingController.isLoaded.value = true;
          _baseController.customerBookingController.hasBooking.value = false;
          _baseController.customerOrderController.hasOrder.value = false;

          return null;
        }
      }

      return null;
    } on DioException catch (e) {
      if (e.response != null) {
        _baseController.customerBookingController.booking.value = null;
        _baseController.customerBookingController.isLoaded.value = true;
        _baseController.customerBookingController.hasBooking.value = false;
        _baseController.customerOrderController.hasOrder.value = false;
      } else {
        print(e);
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }

    return null;
  }

  Future onGoingRide(String id) async {
    try {
      var response = await dio.get(
        '$endpoint/api/v1/customer/on-going-ride',
        options: Options(
          headers: headers(),
        ),
        data: {
          'order_id': id,
        },
      );

      if (response.statusCode == 200) {
        _baseController.customerBookingController.onGoingRide.value = true;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);
      } else {
        print(e);
      }
    } catch (e) {
      print(e);
    }
  }

  Future completeRide(String id) async {
    try {
      var response = await dio.get(
        '$endpoint/api/v1/customer/complete-ride',
        options: Options(
          headers: headers(),
        ),
        data: {
          'order_id': id,
        },
      );

      if (response.statusCode == 200) {
        _baseController.customerBookingController.clearSettings();
        _baseController.customerOrderController.clearSettings();
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);
      } else {
        print(e);
      }
    } catch (e) {
      print(e);
    }
  }
}

final customerApi = CustomerApi();
