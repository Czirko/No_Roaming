import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String hint;
  final TextEditingController _controller;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 16.0);


  TextInput(this.hint,this._controller);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      obscureText: true,
      style: style,
      decoration: InputDecoration(

          contentPadding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
          hintText: hint,
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(26.0))),

    );;
  }
}
