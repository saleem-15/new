import 'package:json_annotation/json_annotation.dart';

import 'package:nuntium/config/constants.dart';

import 'article_response.dart';
import 'source_response.dart';

part 'search_response.g.dart';

@JsonSerializable()
class SearchResopnse {
  @JsonKey(name: ApiConstants.status)
  String status;

  @JsonKey(name: ApiConstants.totalResults)
  int totalResults;

  @JsonKey(name: ApiConstants.source)
  SourceResponse? source;

  @JsonKey(name: ApiConstants.articles)
  List<ArticleResponse>? articles;

  SearchResopnse({
    required this.status,
    required this.articles,
    required this.source,
    required this.totalResults,
  });

  factory SearchResopnse.fromJson(Map<String, dynamic> json) => _$SearchResopnseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResopnseToJson(this);
}
