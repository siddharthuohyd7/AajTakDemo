class CategoryModel {
  String? httpStatus;
  int? httpStatusCode;
  bool? success;
  String? message;
  String? apiName;
  List<Category>? data;

  CategoryModel({httpStatus, httpStatusCode, success, message, apiName, data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    httpStatus = json['httpStatus'];
    httpStatusCode = json['httpStatusCode'];
    success = json['success'];
    message = json['message'];
    apiName = json['apiName'];
    if (json['data'] != null) {
      data = <Category>[];
      json['data'].forEach((v) {
        data!.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['httpStatus'] = httpStatus;
    data['httpStatusCode'] = httpStatusCode;
    data['success'] = success;
    data['message'] = message;
    data['apiName'] = apiName;
    data['data'] = this.data!.map((v) => v.toJson()).toList();
    return data;
  }
}

class Category {
  int? id;
  String? name;
  String? description;
  double? price;
  List<String>? suggestions;

  Category({id, name, description, price, suggestions});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    suggestions = json['suggestions'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['suggestions'] = suggestions;
    return data;
  }
}
