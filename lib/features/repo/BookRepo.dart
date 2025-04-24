import 'dart:convert';

import 'package:booklist/core/appLinks.dart';
import 'package:booklist/features/data/Book_State.dart';
import 'package:booklist/features/model/BookModel.dart';
import 'package:http/http.dart'as http;
class BookRepo{
  Future<List<BookModel>>getBooks()async{
    final uri = Uri.parse(appLinks.url);
    var res=await http.get(uri).timeout(appLinks.apiTimeout);
    if(res.statusCode==200)
      {
        print("Repo");
        final body = jsonDecode(res.body);
        final results = body['results'] as List<dynamic>;
        print(results);
        print("End Repo");
        print("Fetched ${results.length} books");
        return results.map((e) => BookModel.fromJson(e)).toList();
      }
    else{
      throw Exception("Faild");
    }
  }
}