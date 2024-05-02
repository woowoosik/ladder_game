
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ladder_game/goal_input_text.dart';
import 'package:provider/provider.dart';
import 'package:ladder_game/viewmodel.dart';
import 'package:ladder_game/button.dart';
import 'package:ladder_game/game_screen.dart';
import 'package:ladder_game/count.dart';
import 'color.dart';

class mainScreen extends StatefulWidget {
  @override
  State createState() => _mainScreen();
}

class _mainScreen extends State<mainScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  ValueNotifier<bool> visible = ValueNotifier<bool>(true);
  ValueNotifier<bool> restartBtn = ValueNotifier<bool>(false);
  ValueNotifier<bool> goalVisible = ValueNotifier<bool>(false);

  late var provider;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<ViewModel>(context);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (provider.animationStart) {
        animation();
      }
    });

    var k = MediaQuery.viewInsetsOf(context).bottom;

    var n = 0;
    if (provider.N <= 4) {
      n = provider.N;
    } else {
      n = 4;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 30),
            child: Stack(
              children: [
                GameScreen(),
                ValueListenableBuilder(
                  valueListenable: restartBtn,
                  builder: (ctx, bool value, child) {
                    return Visibility(
                      visible: restartBtn.value,
                      child: Container(
                        height: MediaQuery.sizeOf(context).height,
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              restartBtn.value = false;
                              visible.value = true;
                              goalVisible.value = false;
                              provider.createGraph();
                              provider.createGoalTextList();
                            });
                          },
                          child: Icon(Icons.restart_alt),
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 70
                  ),
                  child: ValueListenableBuilder(
                    valueListenable: visible,
                    builder: (ctx, bool value, child) {
                      return Visibility(
                        visible: visible.value,
                        child: Container(
                          color: BACKGOUND_COLOR_1,
                          height: MediaQuery.sizeOf(context).height * 0.7,
                          child: Column(
                            children: [
                              Count(),
                              const SizedBox(
                                height: 20,
                              ),
                              Button(
                                callback: () {
                                  if (k > 0.0) {
                                    provider.animationStart = true;
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  } else {
                                    animation();
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GoalInputText(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                ValueListenableBuilder(
                    valueListenable: goalVisible,
                    builder: (ctx, bool value, child) {
                      return Visibility(
                        visible: goalVisible.value,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.sizeOf(context).height * 0.83),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              for (var i = 0; i < provider.N; i++) ...[
                                SingleChildScrollView(
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: MediaQuery.sizeOf(context).width /
                                            provider.N,
                                    child: Text(
                                      '${(provider.goalTextList[i])}',
                                    ),
                                  ),
                                ),
                              ]
                            ],
                          ),
                        ),
                      );
                    }),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.9 + k,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void animation() {
    visible.value = false;
    provider.goalTextList = provider.goalTextList..shuffle();
    goalVisible.value = true;

    provider.animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        provider.animationStart = false;
        restartBtn.value = true;
      }
    });

    if (provider.animationController.isDismissed) {
      provider.animationController.forward();
    } else if (provider.animationController.isAnimating) {
      provider.animationController.reverse();
    } else {
      provider.animationController.reset();
    }
  }
}
