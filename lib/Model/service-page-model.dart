import 'package:json_annotation/json_annotation.dart';

part 'service-page-model.g.dart';

@JsonSerializable()
class ServicePageModel {
  String title, description, image_url, small_icon, small_icon_white;

  ServicePageModel(this.title, this.description, this.image_url,
      this.small_icon, this.small_icon_white);

  factory ServicePageModel.fromJson(Map<String, dynamic> json) =>
      _$ServicePageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ServicePageModelToJson(this);
}
