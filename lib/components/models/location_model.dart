import 'package:cloud_firestore/cloud_firestore.dart';

class LocationModel {
  String? id;
  final String userName;
  final String vehicleType;
  final String vehicleNum;
  final double lat;
  final double lang;

  LocationModel({
    this.id = '',
    required this.userName,
    required this.vehicleType,
    required this.vehicleNum,
    required this.lat,
    required this.lang,
  });

  toJson() {
    return {
      'id': id,
      'userName': userName,
      'vehicleType': vehicleType,
      'vehicleNum': vehicleNum,
      'lat': lat,
      'lang': lang,
    };
  }

  factory LocationModel.fromJson(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final json = snapshot.data()!;
    return LocationModel(
      id: json["id"],
      userName: json["userName"],
      vehicleType: json["vehicleType"],
      vehicleNum: json["vehicleNum"],
      lat: json['lat'],
      lang: json['lang'],
    );
  }
}
