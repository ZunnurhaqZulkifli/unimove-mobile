part of 'user_api.dart';

class DriverApi extends Api {
  final BaseAppController _baseController = Get.put(BaseAppController());
  //

  Future<bool> checkHasOrder() async {
    try {
      var response = await dio.get(
        '$endpoint/api/v1/driver/order-check',
        options: Options(
          headers: headers(),
        ),
      );

      if (response.statusCode == 200) {
        var responseData = response.data['data'];
        _baseController.driverOrderController.hasOrder.value = responseData;

        return responseData;
      }

      return false;
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);
      } else {
        print(e);
      }

      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<dynamic>> getOrderList() async {
    try {
      var response = await dio.get(
        '$endpoint/api/v1/driver/orders',
        options: Options(
          headers: headers(),
        ),
      );

      if (response.statusCode == 200) {
        var responseData = response.data['data'];

        List<Order> orderList = [];

        for (var item in responseData) {
          orderList.add(Order.fromJson(item));
        }

        _baseController.driverOrderController.pendingOrders.value = orderList;

        if (orderList.isNotEmpty) {
          _baseController.driverOrderController.loadedPendingOrders.value =
              true;
        }
        // _baseController.driverOrderController.

        return responseData;
      }

      return [];
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);

        return [];
      } else {
        print(e);

        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future acceptOrder(int order) async {
    try {
      var response = await dio.post(
        '$endpoint/api/v1/driver/accept-order',
        options: Options(
          headers: headers(),
        ),
        data: {
          'order_id': order,
        },
      );

      if (response.statusCode == 200) {
        _baseController.driverOrderController.hasOrder.value = true;
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

  Future<bool> checkDriverBooking() async {
    try {
      var response = await dio.get(
        '$endpoint/api/v1/check-has-booking',
        options: Options(
          headers: headers(),
        ),
      );

      if (response.statusCode == 200) {
        var responseData = response.data['data'];

        return responseData;
      }

      return false;
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);

        return false;
      } else {
        print(e);

        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<Booking?> getBooking() async {
    try {
      var response = await dio.get(
        '$endpoint/api/v1/driver/get-active-booking',
        options: Options(
          headers: headers(),
        ),
      );

      if (response.statusCode == 200) {
        var responseData = response.data['data'];
        Booking booking = Booking.fromJson(responseData);
        _baseController.driverBookingController.booking.value = booking;
        _baseController.driverBookingController.isLoaded.value = true;

        return booking;
      }
      return null;
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);
      } else {
        print(e);
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future onGoingRide(String id) async {
    try {
      var response = await dio.get(
        '$endpoint/api/v1/driver/on-going-ride',
        options: Options(
          headers: headers(),
        ),
        data: {
          'order_id': id,
        },
      );

      if (response.statusCode == 200) {
        _baseController.driverBookingController.onGoingRide.value = true;
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
        '$endpoint/api/v1/driver/complete-ride',
        options: Options(
          headers: headers(),
        ),
        data: {
          'order_id': id,
        },
      );

      if (response.statusCode == 200) {
        _baseController.driverBookingController.clearSettings();
        _baseController.driverOrderController.clearSettings();
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

final driverApi = DriverApi();
