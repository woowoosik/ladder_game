import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ladder_game/color.dart';
import 'package:ladder_game/viewmodel.dart';
import 'package:provider/provider.dart';

typedef Callback = Function();

class Button extends StatefulWidget {
  Callback callback;

  Button({super.key, required this.callback});

  @override
  State<StatefulWidget> createState() {
    return _Button();
  }
}

class _Button extends State<Button> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ViewModel>(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                var N = provider.N;
                if (N >= 8) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("8명이 최대입니다.")),
                  );
                } else {
                  provider.add();
                }
              },
              child: const Icon(Icons.add),
            ),
            ElevatedButton(
              onPressed: () {
                provider.createGraph();
              },
              child: const Text('다시 만들기'),
            ),
            ElevatedButton(
              onPressed: () {
                var N = provider.N;
                if (N <= 2) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("2명이 최소입니다.")),
                  );
                } else {
                  provider.remove();
                }
              },
              child: const Icon(Icons.remove),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            widget.callback.call();
          },
          child: const Text('START'),
        ),
      ],
    );

    ;
  }
}
