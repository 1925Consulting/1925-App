// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main-page-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainPageModel _$MainPageModelFromJson(Map<String, dynamic> json) {
  return MainPageModel(
    json['tagline'] as String,
    json['welcome_message'] as String,
  );
}

Map<String, dynamic> _$MainPageModelToJson(MainPageModel instance) =>
    <String, dynamic>{
      'tagline': instance.tagline,
      'welcome_message': instance.welcome_message,
    };
