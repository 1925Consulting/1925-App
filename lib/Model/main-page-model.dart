import 'package:json_annotation/json_annotation.dart';

part 'main-page-model.g.dart';

@JsonSerializable()
class MainPageModel {
  String tagline, welcome_message;

  MainPageModel(this.tagline, this.welcome_message);

  factory MainPageModel.fromJson(Map<String, dynamic> json) =>
      _$MainPageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MainPageModelToJson(this);
}
