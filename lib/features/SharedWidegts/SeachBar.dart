import 'package:flutter/material.dart';
class SearchBarWidget extends StatelessWidget {
  SearchBarWidget({super.key,required this.hint, required Null Function(dynamic query) onSearch});
   String hint;
  @override
  Widget build(BuildContext context) {
    return  Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(vertical: 10),
        child: TextFormField(
          // controller: ,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {}, icon: Icon(Icons.search_rounded)),
              hintText: hint,
              contentPadding:
              EdgeInsets.symmetric(vertical: 2, horizontal: 1),
              border: OutlineInputBorder(
                  borderSide: BorderSide(),
                  borderRadius: BorderRadius.all(Radius.circular(10)))),
        )
    );
  }
}
