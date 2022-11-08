// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service-page-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServicePageModel _$ServicePageModelFromJson(Map<String, dynamic> json) {
  return ServicePageModel(
    json['title'] as String,
    json['description'] as String,
    json['image_url'] as String,
    json['small_icon'] as String,
    json['small_icon_white'] as String,
  );
}

Map<String, dynamic> _$ServicePageModelToJson(ServicePageModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'image_url': instance.image_url,
      'small_icon': instance.small_icon,
      'small_icon_white': instance.small_icon_white,
    };
