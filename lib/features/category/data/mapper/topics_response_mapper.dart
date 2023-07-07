import 'package:nuntium/features/category/data/mapper/topic_response_mapper.dart';
import 'package:nuntium/features/category/data/response/topics_response.dart';
import 'package:nuntium/features/category/domain/entity/topics_entites.dart';

extension TopicsResopnseMapper on TopicsResopnse {
  TopicsEntity toDomain() {
    return TopicsEntity(
        topics: topics.docs
            .map(
              (document) => document.topicDocToDomain(),
            )
            .toList());
  }
}
