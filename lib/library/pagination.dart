class PaginationLoadData<T> {
  final List<T> data;
  final int currentPage;
  final int totalPage;

  PaginationLoadData({
    required this.data,
    required this.currentPage,
    required this.totalPage,
  });
}

typedef PaginationLoad<T> = Future<PaginationLoadData<T>> Function(int);

class Pagination<T> {
  final _data = <T>[];
  late int _currentPage;
  late int _totalPage;
  bool isLoad = false;
  final PaginationLoad<T> load;

  List<T> get data => _data;

  Pagination(this.load);

  Future<void> loadNextPage() async {
    if (isLoad || _currentPage >= _totalPage) return;
    isLoad = true;

    final nextPage = _currentPage + 1;
    try {
      final response = await load(nextPage);
      _data.addAll(response.data);
      _currentPage = response.currentPage;
      _totalPage = response.totalPage;
      isLoad = false;
    } catch (err) {
      isLoad = false;
    }
  }

  Future<void> reset() async {
    _currentPage = 0;
    _totalPage = 1;
    _data.clear();
    await loadNextPage();
  }
}
