class appLinks{
  static const String baseUrl = 'https://gutendex.com';
  static const String booksEndpoint = '/books';
  static const String url = '$baseUrl$booksEndpoint';
  static const int itemsPerPage = 20;
  static const Duration apiTimeout = Duration(seconds: 10);
}