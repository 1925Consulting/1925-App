// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'our-project-screen-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OurProjectScreenModel _$OurProjectScreenModelFromJson(
    Map<String, dynamic> json) {
  return OurProjectScreenModel(
    json['image_url'] as String,
    json['link'] as String,
    json['name'] as String,
  );
}

Map<String, dynamic> _$OurProjectScreenModelToJson(
        OurProjectScreenModel instance) =>
    <String, dynamic>{
      'image_url': instance.image_url,
      'link': instance.link,
      'name': instance.name,
    };
