import 'package:nuntium/core/storage/local/model/article_model.dart';

class Constants {
  static const int splashDuration = 3;

  //design dimensions
  static const double deviceWidth = 375;
  static const double deviceHeight = 812;

  //languages keys
  static const String arabicKey = 'ar';
  static const String englishKey = 'en';
  static const String arabic = 'العربية';
  static const String english = 'English';
}

class ConstantsPrefsKeys {
  static const String outBoardingViewedKey = 'out_boarding_viewed';
  static const String loggedIn = "loggedIn";
  static const String FavouriteViewed = "FavouriteViewed";
  static const String Registered = "Registered";
  static const String locale = 'locale';
  static const String email = 'email';
  static const String name = 'name';
  static const String notificationOn = 'notification_on';
}

class FirestoreConstants {
  static const String topics = "categories";

  //users
  static const String users = "Users";
  static const String name = "name";
  static const String email = "email";
}

class ApiConstants {
  static const String API_KEY = "8afe77481e534d1ab76a4dbf5d533508";
  static const String baseUrl = "https://newsapi.org/v2";
  static const String authorization = 'authorization';
  static const int sendTimeOutDuration = 120;
  static const int receiveTimeOutDuration = 120;

  /// the key that is used for the first page in paginatoin
  static const int firstPageKey = 1;
  static const String noInternetConnection = 'No Internet connection';
  static const String email = 'email';
  static const String password = 'password';

  //Home Request
  static const String pageSize = 'pageSize';
  static const int homeaPgeSizeValue = 20;
  static const String page = 'page';
  static const String country = 'country';
  static const String category = 'category';
  static const String sources = 'sources';
  static const String search = 'q';

  //Home Response
  static const String status = 'status';
  static const String source = 'source';
  static const String articles = 'articles';
  static const String totalResults = 'totalResults';

  //article (Home Response)
  static const String author = 'author';
  static const String content = 'content';
  static const String publishedAt = 'publishedAt';
  static const String urlToImage = 'urlToImage';
  static const String url = 'url';
  static const String description = 'description';
  static const String title = 'title';

  //source (Home Response)
  static const String id = 'id';
  static const String name = 'name';
}

class GetBuilderIDs {
  GetBuilderIDs._();

  static String articleBookmarkIcon(Article article) {
    return article.url!;
  }

  static const String categories_list = 'categories_list';
  static const String bookmarks_list = 'bookmarks_list';
}
