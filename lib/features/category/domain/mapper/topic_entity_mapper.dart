import 'package:nuntium/features/category/domain/entity/topic_entity.dart';
import 'package:nuntium/features/category/presentation/models/topic.dart';

extension TopicEntityMapper on TopicEntity {
  Topic toPresentation() {
    return Topic(name: name);
  }
}
