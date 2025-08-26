import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  final Function(String text) onTextChanged;
  final String hint;
  const SearchView({super.key, required this.onTextChanged, this.hint = ""});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController tec = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: tec,
      decoration: InputDecoration(
        hintText: widget.hint
      ),
      onChanged: (value) {
        widget.onTextChanged(value);
      }
    );
  }
}
