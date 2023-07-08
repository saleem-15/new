class HomeRequest {
  int? page;
  int? pageSize;
  String? country;
  String? category;
  String? sources;
  String? search;

  HomeRequest({
    required this.page,
    required this.pageSize,
    required this.country,
    required this.category,
    required this.sources,
    required this.search,
  });
}
