import 'package:flutter/cupertino.dart';

class RefreshProviderEvent extends ChangeNotifier {
  String _updateMsg = '';

  String get updateMsg => _updateMsg;

  set updateMsg(String value) {
    _updateMsg = value;
    notifyListeners();
  }
}
