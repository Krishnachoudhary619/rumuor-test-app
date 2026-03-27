import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: avoid_classes_with_only_static_members
class TimestampConverter {
  static DateTime? fromJson(dynamic timestamp) {
    if (timestamp == null) return null;
    return (timestamp as Timestamp).toDate();
  }

  static dynamic toJson(DateTime? date) {
    if (date == null) return null;
    return Timestamp.fromDate(date);
  }
}
