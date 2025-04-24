
import 'package:booklist/features/data/Book_State.dart';
import 'package:booklist/features/model/BookModel.dart';
import 'package:booklist/features/repo/BookRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookCubit extends Cubit<BookState>{
  BookCubit():super(BookLoading());
  BookRepo repo=BookRepo();
  String ? query;
   getBooks() async{
     try{
       emit(BookLoading());
       await Future.delayed(Duration(seconds: 3));
      final List<BookModel> books= await repo.getBooks();
      print("List Cubitttt   ");
      print(books);
      emit(BooksLists(books));
     } catch(e)
     {
       emit(BookError(e.toString()));
     }
   }
   searchBooks(String search)async{
     final List<BookModel> books= await repo.getBooks();

     final searchedBook=books.where((e)=>e.title.toLowerCase().contains(search.toLowerCase())).toList();
     print("Searched  $search");
     print("Books are $searchedBook");
     emit(BooksLists(searchedBook));
   }
}