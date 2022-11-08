// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'projects-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectModel _$ProjectModelFromJson(Map<String, dynamic> json) {
  return ProjectModel(
    json['balance_paid'] as String,
    json['balance_due'] as String,
    const TimestampConverter().fromJson(json['create_on'] as Timestamp),
    const TimestampConverter()
        .fromJson(json['estimate_completion_date'] as Timestamp),
    json['project_name'] as String,
    json['status'] as String,
    const TimestampConverter().fromJson(json['start_date'] as Timestamp),
    json['project_image'] as String,
    json['total_charge'] as String,
    const TimestampConverter().fromJson(json['end_date'] as Timestamp),
    json['project_status'] as String,
  );
}

Map<String, dynamic> _$ProjectModelToJson(ProjectModel instance) =>
    <String, dynamic>{
      'create_on': const TimestampConverter().toJson(instance.create_on),
      'estimate_completion_date':
          const TimestampConverter().toJson(instance.estimate_completion_date),
      'start_date': const TimestampConverter().toJson(instance.start_date),
      'end_date': const TimestampConverter().toJson(instance.end_date),
      'balance_paid': instance.balance_paid,
      'balance_due': instance.balance_due,
      'project_status': instance.project_status,
      'status': instance.status,
      'project_name': instance.project_name,
      'total_charge': instance.total_charge,
      'project_image': instance.project_image,
    };
