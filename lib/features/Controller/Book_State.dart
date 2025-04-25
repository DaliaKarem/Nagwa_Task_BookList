// have 3 states Loading_ get Data _ Error


import 'package:booklist/features/model/BookModel.dart';
import 'package:equatable/equatable.dart';

sealed class BookState extends Equatable{
  const BookState();

  @override
  List<Object?> get props=>[];
}
class EmptyBook extends BookState{
  const EmptyBook();
  @override
  List<Object?> get props=>[];
}
class BookLoading extends BookState{
  const BookLoading();
  //Empty List
  @override
  List<Object?> get props=>[];

}
class BooksLists extends BookState{
  //get List
  final List <BookModel> Book_list;
  const BooksLists(this.Book_list);
  @override
  List<Object?> get props=>[Book_list];

}
class BookError extends BookState{
  // Empty list error img
  final String message;

  const BookError(this.message);
  @override
  List<Object?> get props=>[message];
}
