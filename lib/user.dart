import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import 'color.dart';
import 'viewmodel.dart';

class User extends StatefulWidget {
  late var num;

  late var size;

  User({required this.num, required this.size});

  @override
  State<StatefulWidget> createState() {
    return _user(num: num, size: size);
  }
}

class _user extends State<User> with TickerProviderStateMixin {
  late var num;
  late var size;


  _user({required this.num, required this.size});

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(color[num % 10], BlendMode.srcIn),
      child: Icon(
        Icons.account_circle,
        size: size.toDouble(),
      ),
      // FlutterLogo(size: size.toDouble()),
    );
  }
}
