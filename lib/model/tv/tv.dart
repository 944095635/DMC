import 'package:dmc/model/media/media.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tv.g.dart';

@JsonSerializable()
class Tv extends Media {
  @JsonKey(defaultValue: false)
  bool star;

  String? image;

  List<String> source;

  /// 节点序号
  @JsonKey(defaultValue: 0)
  int sourceId;

  Tv(super.name, this.source, this.sourceId, this.star);
  factory Tv.fromJson(Map<String, dynamic> data) => _$TvFromJson(data);
  Map<String, dynamic> toJson() => _$TvToJson(this);
}
