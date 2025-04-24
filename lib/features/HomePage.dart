import 'package:booklist/features/data/Book_Cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import 'SharedWidegts/BookListView.dart';
import 'SharedWidegts/SeachBar.dart';
import 'data/Book_State.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookCubit()..getBooks(),
      child: Scaffold(
          body: BlocBuilder<BookCubit, BookState>
            (builder: (context, state) {
        switch (state) {
          case BookLoading():
            return Center(
              child: CircularProgressIndicator(),
            );
          case BooksLists():
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SearchBarWidget(
                    hint: "Search books...",
                    onSearch: (query) {
                    context.read<BookCubit>().searchBooks(query);
                    },
                  ),
                ),
                Expanded(
                  child: Booklistview(list: state.Book_list),
                ),
              ],
            );

          case BookError():
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    "images/lottie/Error.json",
                    width: 200,
                    height: 200,
                    repeat: false,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Failed to load books",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<BookCubit>().getBooks();
                    },
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          case EmptyBook():
           return Center(child: Text(
        "No books found",
        style: Theme.of(context).textTheme.titleMedium,));
        }
      })),
    );
  }
}
