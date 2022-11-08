import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'testimonials-page-model.g.dart';

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
class TestimonialsPageModel {
  String text, written_by;
  double rating;
  @TimestampConverter()
  DateTime date;


  TestimonialsPageModel(this.text, this.written_by);

  factory TestimonialsPageModel.fromJson(Map<String, dynamic> json) =>
      _$TestimonialsPageModelFromJson(json);

  Map<String, dynamic> toJson() => _$TestimonialsPageModelToJson(this);
}
