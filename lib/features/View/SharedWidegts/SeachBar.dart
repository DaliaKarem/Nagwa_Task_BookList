import 'package:flutter/material.dart';
class SearchBarWidget extends StatefulWidget {
  SearchBarWidget({super.key,required this.hint, required this.onSearch});
   String hint;
  void Function(String)? onSearch;

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        widget.onSearch!('');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(vertical: 10),
        child: TextFormField(
           controller:_controller ,
          onFieldSubmitted: widget.onSearch,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: (){
                    widget.onSearch!(_controller.text);
                  },
                  icon: Icon(Icons.search_rounded)),
              hintText: widget.hint,
              contentPadding:
              EdgeInsets.symmetric(vertical: 2, horizontal: 1),
              border: OutlineInputBorder(
                  borderSide: BorderSide(),
                  borderRadius: BorderRadius.all(Radius.circular(10)))),
        )
    );
  }
}
