import 'package:dio/dio.dart';
import 'package:unimove/api/user_api.dart';
import 'package:unimove/helpers/snackbar_helpers.dart';
import 'package:unimove/models/dashboaed_images.dart';

class DashboardApi extends Api {
  //
  Future loadDashboardImages() async {
    try {
      var response = await dio.get(
        '$endpoint/api/v1/dashboard-images',
        options: Options(
          headers: headers(),
        ),
      );

      if (response.statusCode == 200) {
        var responseData = response.data['data'];

        controller.dashboardController.dashboardImages.clear();

        for (var item in responseData) {
          controller.dashboardController.dashboardImages
              .add(DashboardImage.fromJson(item));
        }

        return;
      }
    } on DioException catch (e) {
      if (e.response != null) {
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
}

final dashboardApi = DashboardApi();
