import 'package:json_annotation/json_annotation.dart';
part 'our-project-screen-model.g.dart';
@JsonSerializable()
class OurProjectScreenModel {
  String image_url, link, name;

  OurProjectScreenModel(this.image_url, this.link, this.name);


factory OurProjectScreenModel.fromJson(Map<String, dynamic> json) => _$OurProjectScreenModelFromJson(json);

Map<String, dynamic> toJson() => _$OurProjectScreenModelToJson(this);
}
