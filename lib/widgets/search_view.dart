import 'package:flutter/material.dart';

class SearchViewController {
  setText(String text) {
    svState.setText(text);
  }

  late _SearchViewState svState;
  void bind(_SearchViewState searchView) {
    svState = searchView;
  }
}

class SearchView extends StatefulWidget {
  final Function(String text) onTextChanged;
  final String hint;
  final SearchViewController controller;
  const SearchView({super.key, required this.controller, required this.onTextChanged, this.hint = "Keyword"});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController tec = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.controller.bind(this);
    debugPrint("SearchView.initState");
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("SearchView.build text=${tec.text}");
    return TextFormField(
      controller: tec,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: widget.hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40))
        )
      ),
      onChanged: (value) {
        widget.onTextChanged(value);
      }
    );
  }

  void setText(String text) {
    tec.text = text;
  }
}
