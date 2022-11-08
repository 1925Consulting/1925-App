// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'testimonials-page-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestimonialsPageModel _$TestimonialsPageModelFromJson(
    Map<String, dynamic> json) {
  return TestimonialsPageModel(
    json['text'] as String,
    json['written_by'] as String,
  )
    ..rating = (json['rating'] as num)?.toDouble()
    ..date = const TimestampConverter().fromJson(json['date'] as Timestamp);
}

Map<String, dynamic> _$TestimonialsPageModelToJson(
        TestimonialsPageModel instance) =>
    <String, dynamic>{
      'text': instance.text,
      'written_by': instance.written_by,
      'rating': instance.rating,
      'date': const TimestampConverter().toJson(instance.date),
    };
