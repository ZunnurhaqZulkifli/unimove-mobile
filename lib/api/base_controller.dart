part 'api_config.dart';

class Api {
  String endpoint = ENDPOINT;

  Function initialize() {
    return () {
      print('Api initialized');
    };
  }
}
