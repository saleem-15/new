import 'package:get/get.dart';
import 'package:nuntium/config/dependency_injection.dart';
import 'package:nuntium/features/category/domain/mapper/topics_entity_mapper.dart';
import 'package:nuntium/features/category/domain/use_case/topics_use_case.dart';
import 'package:nuntium/features/category/presentation/models/topic.dart';

class CategoriesController extends GetxController {
  late final _topicsUseCase = getIt<TopicsUseCase>();

  List<Topic> topics = [];

  @override
  void onInit() {
    super.onInit();
    fetchTopics();
  }

  Future<void> fetchTopics() async {
    (await _topicsUseCase.execute()).fold(
      (l) => Get.rawSnackbar(message: l.message),
      (r) {
        topics = r.toPresentation();
        update();
      },
    );
  }
}
