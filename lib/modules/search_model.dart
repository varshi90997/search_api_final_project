import 'dart:io';

class ApiModel {
  QueryStatistics? queryStatistics;
  int? totalPages;
  int? currentPageIndex;
  int? totalRecords;
  int? returnedRecords;
  List<Items>? items;

  ApiModel(
      {this.queryStatistics,
      this.totalPages,
      this.currentPageIndex,
      this.totalRecords,
      this.returnedRecords,
      this.items});

  ApiModel.fromJson(Map<String, dynamic> json) {
    queryStatistics = json['queryStatistics'] != null
        ? QueryStatistics.fromJson(json['queryStatistics'])
        : null;
    totalPages = json['totalPages'];
    currentPageIndex = json['currentPageIndex'];
    totalRecords = json['totalRecords'];
    returnedRecords = json['returnedRecords'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (queryStatistics != null) {
      data['queryStatistics'] = queryStatistics!.toJson();
    }
    data['totalPages'] = totalPages;
    data['currentPageIndex'] = currentPageIndex;
    data['totalRecords'] = totalRecords;
    data['returnedRecords'] = returnedRecords;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QueryStatistics {
  QueryStatistics();

  QueryStatistics.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    return data;
  }
}

class Items {
  String? title;
  bool? isTrusted;
  int? type;
  String? description;
  String? thumbnailUrl;
  String? entityId;
  int? referenceCount;
  String? image;
  List? imagess;

  Items(
      {this.image,
      this.imagess,
      this.title,
      this.isTrusted,
      this.type,
      this.description,
      this.thumbnailUrl,
      this.entityId,
      this.referenceCount});

  Items.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    isTrusted = json['isTrusted'];
    type = json['type'];
    description = json['description'];
    thumbnailUrl = json['thumbnailUrl'];
    entityId = json['entityId'];
    referenceCount = json['referenceCount'];
    image = json['image'];
    imagess = json['imagess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = title;
    data['isTrusted'] = isTrusted;
    data['type'] = type;
    data['description'] = description;
    data['thumbnailUrl'] = thumbnailUrl;
    data['entityId'] = entityId;
    data['referenceCount'] = referenceCount;
    data['image'] = image;
    data['imagess'] = imagess;
    return data;
  }
}
