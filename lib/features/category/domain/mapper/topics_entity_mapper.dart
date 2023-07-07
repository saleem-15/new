import 'package:nuntium/features/category/domain/entity/topics_entites.dart';
import 'package:nuntium/features/category/domain/mapper/topic_entity_mapper.dart';
import 'package:nuntium/features/category/presentation/models/topic.dart';

extension TopicsEntityMapper on TopicsEntity {
  List<Topic> toPresentation() {
    return topics
        .map(
          (topicEntity) =>topicEntity.toPresentation(),
        )
        .toList();
  }
}
