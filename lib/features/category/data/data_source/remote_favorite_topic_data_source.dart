import 'package:nuntium/features/category/data/request/favorite_topic_request.dart';

abstract class RemoteFavoriteTopicDataSource {
  Future<void> selectFavoriteTopic(SelectFavoriteTopicRequest selectFavoriteTopicRequest);
}

class RemoteFavoriteTopicDataSourceImplement implements RemoteFavoriteTopicDataSource {
  @override
  Future<void> selectFavoriteTopic(SelectFavoriteTopicRequest selectFavoriteTopicRequest) async {
    // await FirebaseAuth.instance.selectFavoriteTopic(
    //   verifyCodeRequest.verificationCode!,
    // );
  }
}
