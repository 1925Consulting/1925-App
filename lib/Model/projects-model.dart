import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'projects-model.g.dart';

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) {
    return timestamp.toDate();
  }

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}

@JsonSerializable()
class ProjectModel {
  @TimestampConverter()
  final DateTime create_on;
  @TimestampConverter()
  final DateTime estimate_completion_date;
  @TimestampConverter()
  final DateTime start_date;
  @TimestampConverter()
  final DateTime end_date;

  String balance_paid;
  String balance_due;
  String project_status;
  String status;
  String project_name;
  String total_charge;
  String project_image;

  ProjectModel(
      this.balance_paid,
      this.balance_due,
      this.create_on,
      this.estimate_completion_date,
      this.project_name,
      this.status,
      this.start_date,
      this.project_image,
      this.total_charge,
      this.end_date,
      this.project_status);

  factory ProjectModel.fromJson(Map<dynamic, dynamic> json) =>
      _$ProjectModelFromJson(json);

  Map<dynamic, dynamic> toJson() => _$ProjectModelToJson(this);
}
