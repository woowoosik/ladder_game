import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ladder_game/widget_text_field.dart';
import 'package:provider/provider.dart';

import 'viewmodel.dart';

class GoalInputText extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GoalInputText();
  }
}

class _GoalInputText extends State<GoalInputText> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ViewModel>(context);

    var n = 0;
    if (provider.N <= 4) {
      n = provider.N;
    } else {
      n = 4;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (var i = 0; i < n; i++) ...[

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: TextFieldWidget(
                      password: false,
                      hint: '도착 $i',
                      callback: (val) {
                        provider.goalTextList[i] = val;
                      }),
                ),


              ],
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              if (provider.N >= 5) ...[
                for (var i = 0; i < provider.N - 4; i++) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: TextFieldWidget(
                        password: false,
                        hint: '도착 ${i + 4}',
                        callback: (val) {
                          provider.goalTextList[i + 4] = val;
                        }),
                  ),
                ],
              ]
            ],
          ),
        ),
      ],
    );
  }
}
