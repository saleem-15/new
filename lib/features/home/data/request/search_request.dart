class SearchRequest {
  String search;
  int page;
  int pageSize;
  String? country;
  String? category;
  String? sources;

  SearchRequest({
    required this.page,
    required this.pageSize,
    required this.country,
    required this.category,
    required this.sources,
    required this.search,
  });
}
