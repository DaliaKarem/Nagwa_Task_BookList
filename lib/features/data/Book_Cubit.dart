import 'package:booklist/features/data/Book_State.dart';
import 'package:booklist/features/data/Offline_data/SQFlite.dart';
import 'package:booklist/features/model/BookModel.dart';
import 'package:booklist/features/repo/BookRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookCubit extends Cubit<BookState> {
  BookCubit() : super(BookLoading());
  BookRepo repo = BookRepo();
  String? query;
  SQFlite sqFlite = SQFlite();

  getBooks() async {
    emit(BookLoading());
    try {
      final local = await sqFlite.getAllBooks();
      if (local.isNotEmpty) {
        emit(BooksLists(local));
      }
    try {
      await Future.delayed(Duration(seconds: 3));
      final List<BookModel> books = await repo.getBooks();
        await sqFlite.insert(books);
      print("List Cubitttt   ");
      print(books);
      emit(BooksLists(books));
    } catch (networkError) {
      print("Network Error");
      if (local.isEmpty) {
        emit(BookError(networkError.toString()));
      }
    }
  }catch (e) {
      emit(BookError(e.toString()));
    }
  }

  searchBooks(String search) async {
    try{
      final List<BookModel>local=await sqFlite.searchBooks(search);
      final List<BookModel> books = await repo.getBooks();
      final searchedBook = books
          .where((e) => e.title.toLowerCase().contains(search.toLowerCase()))
          .toList();
      print("Searched  $search");
      print("Books are $searchedBook");
      emit(BooksLists(searchedBook));
    } catch(e){
      emit(BookError(e.toString()));
    }
  }
}
