import 'package:easy_localization/easy_localization.dart';

class Category {
  final String _name;

  String get name => tr(_name);

  Category({
    required String name,
  }) : _name = name;
}
