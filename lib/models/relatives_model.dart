class Relatives {
  String? httpStatus;
  int? httpStatusCode;
  bool? success;
  String? message;
  String? apiName;
  Data? data;

  Relatives(
      {httpStatus,
        httpStatusCode,
        success,
        message,
        apiName,
        data});

  Relatives.fromJson(Map<String, dynamic> json) {
    httpStatus = json['httpStatus'];
    httpStatusCode = json['httpStatusCode'];
    success = json['success'];
    message = json['message'];
    apiName = json['apiName'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['httpStatus'] = httpStatus;
    data['httpStatusCode'] = httpStatusCode;
    data['success'] = success;
    data['message'] = message;
    data['apiName'] = apiName;
    data['data'] = this.data!.toJson();
    return data;
  }
}

class Data {
  int? pageNo;
  int? numberOfElements;
  int? pageSize;
  int? totalElements;
  int? totalPages;
  List<Relative>? allRelatives;

  Data(
      {pageNo,
        numberOfElements,
        pageSize,
        totalElements,
        totalPages,
        allRelatives});

  Data.fromJson(Map<String, dynamic> json) {
    pageNo = json['pageNo'];
    numberOfElements = json['numberOfElements'];
    pageSize = json['pageSize'];
    totalElements = json['totalElements'];
    totalPages = json['totalPages'];
    if (json['allRelatives'] != null) {
      allRelatives = <Relative>[];
      json['allRelatives'].forEach((v) {
        allRelatives!.add(Relative.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pageNo'] = pageNo;
    data['numberOfElements'] = numberOfElements;
    data['pageSize'] = pageSize;
    data['totalElements'] = totalElements;
    data['totalPages'] = totalPages;
    if (allRelatives != null) {
      data['allRelatives'] = allRelatives!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Relative {
  String? uuid;
  String? relation;
  int? relationId;
  String? firstName;
  String? middleName;
  String? lastName;
  String? fullName;
  String? gender;
  String? dateAndTimeOfBirth;
  BirthDetails? birthDetails;
  BirthPlace? birthPlace;

  Relative(
      {uuid,
        relation,
        relationId,
        firstName,
        middleName,
        lastName,
        fullName,
        gender,
        dateAndTimeOfBirth,
        birthDetails,
        birthPlace});

  Relative.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    relation = json['relation'];
    relationId = json['relationId'];
    firstName = json['firstName'];
    middleName = json['middleName'];
    lastName = json['lastName'];
    fullName = json['fullName'];
    gender = json['gender'];
    dateAndTimeOfBirth = json['dateAndTimeOfBirth'];
    birthDetails = json['birthDetails'] != null
        ?  BirthDetails.fromJson(json['birthDetails'])
        : null;
    birthPlace = json['birthPlace'] != null
        ?  BirthPlace.fromJson(json['birthPlace'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['uuid'] = uuid;
    data['relation'] = relation;
    data['relationId'] = relationId;
    data['firstName'] = firstName;
    data['middleName'] = middleName;
    data['lastName'] = lastName;
    data['fullName'] = fullName;
    data['gender'] = gender;
    data['dateAndTimeOfBirth'] = dateAndTimeOfBirth;
    if (birthDetails != null) {
      data['birthDetails'] = birthDetails!.toJson();
    }
    if (birthPlace != null) {
      data['birthPlace'] = birthPlace!.toJson();
    }
    return data;
  }
}

class BirthDetails {
  int? dobYear;
  int? dobMonth;
  int? dobDay;
  int? tobHour;
  int? tobMin;
  String? meridiem;

  BirthDetails(
      {dobYear,
        dobMonth,
        dobDay,
        tobHour,
        tobMin,
        meridiem});

  BirthDetails.fromJson(Map<String, dynamic> json) {
    dobYear = json['dobYear'];
    dobMonth = json['dobMonth'];
    dobDay = json['dobDay'];
    tobHour = json['tobHour'];
    tobMin = json['tobMin'];
    meridiem = json['meridiem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['dobYear'] = dobYear;
    data['dobMonth'] = dobMonth;
    data['dobDay'] = dobDay;
    data['tobHour'] = tobHour;
    data['tobMin'] = tobMin;
    data['meridiem'] = meridiem;
    return data;
  }
}

class BirthPlace {
  String? placeName;
  String? placeId;

  BirthPlace({placeName, placeId});

  BirthPlace.fromJson(Map<String, dynamic> json) {
    placeName = json['placeName'];
    placeId = json['placeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['placeName'] = placeName;
    data['placeId'] = placeId;
    return data;
  }
}