import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ladder_game/viewmodel.dart';

import 'package:provider/provider.dart';

import 'color.dart';

class Count extends StatefulWidget{

  @override
  State createState() {
    return _Count();
  }
}

class _Count extends State<Count>{

  @override
  Widget build(BuildContext context) {

    print("@@@@@@@@@@@@@ _Count @@@@@@@@@@@@@");
    return SafeArea(
      child:Text(
        '${context.watch<ViewModel>().N.toString()} 명',
        style: const TextStyle(
          color: FONT_COLOR,
          fontSize: 35,
          shadows: [
            Shadow(
              blurRadius: 10.0,
              color: FONT_SHADOW_1,
              offset: Offset(2.0, 2.0),
            ),
            Shadow(
              color: FONT_SHADOW_2,
              blurRadius: 10.0,
              offset: Offset(-2.0, 2.0),
            ),
          ],

        ),
       ),
    );
  }
}