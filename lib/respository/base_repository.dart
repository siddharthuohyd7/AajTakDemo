import 'package:aajtak/services/api_service_handler.dart';

abstract class BaseRepository{
  late ApiServiceHandler apiServiceHandler;

  BaseRepository() {
    apiServiceHandler = ApiServiceHandler();
  }
}