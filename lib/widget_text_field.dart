import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'color.dart';

typedef Callback = void Function(String);

class TextFieldWidget extends StatelessWidget {
  String hint;

  bool password;

  Callback callback;

  TextFieldWidget(
      {super.key,
      required this.password,
      required this.hint,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const ShapeDecoration(
        gradient: LinearGradient(
          colors: [TEXT_COLOR_1, TEXT_COLOR_2],
          stops: [0.0, 0.05],
          tileMode: TileMode.clamp,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
      ),
      child: TextField(
        expands: false,
        style: const TextStyle(fontSize: 17.0, color: Colors.black54),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10.0),
          hintText: hint,
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.black26),
        ),
        obscureText: password ? true : false,
        keyboardType: TextInputType.text,
        // onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        onChanged: (val) {
          callback.call(val);
        },
      ),
    );
  }
}
