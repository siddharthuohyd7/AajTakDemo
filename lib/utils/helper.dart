import 'package:intl/intl.dart';

bool emailValidator(String? value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value ?? '')) {
    return false;
  } else {
    return true;
  }
}

List<String> getAllPossibleRelatives() {
  return [
    'Mother',
    "Father",
    "Brother",
    "Sister",
    "GrandFather",
    "GrandMother",
    "Aunt",
    "Uncle"
  ];
}

DateTime? getNetworkDateTime(String rawDate) {
  return DateFormat('yyyy-MM-ddThh:mm').parse(rawDate);
}

String? getDate(DateTime dateTime) {
  return DateFormat('dd-MM-yyyy').format(dateTime);
}

String? getTime(int? hour, int? min, String? amPm) {
  String? newHour = (hour! >= 0 && hour <= 9) ? '0${hour.toString()}' : hour.toString();
  String? newMin = (min! >= 0 && min <= 9) ? '0${min.toString()}' : min.toString();
  return '${(newHour == '0' ? '00' : newHour)}:${(newMin == '0' ? '00' : newMin)} $amPm';
}
