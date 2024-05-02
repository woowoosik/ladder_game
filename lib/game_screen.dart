import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ladder_game/color.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:provider/provider.dart';
import 'package:ladder_game/button.dart';
import 'package:ladder_game/viewmodel.dart';
import 'package:ladder_game/user.dart';

class GameScreen extends StatefulWidget {
  @override
  State createState() {
    return _gameScreen();
  }
}

class _gameScreen extends State<GameScreen> with TickerProviderStateMixin {
  var animationList = [];

  late AnimationController _controller;
  late Animation<Offset> _animation;

  late var x;
  late var y;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<ViewModel>(context, listen: false);
      provider.createGraph();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ViewModel>(context);
    var N = provider.N;
    var X = provider.X;
    print("11111111");
    var twoDList = provider.list;

    var userWidgetSize = 40;

    var width = MediaQuery.sizeOf(context).width / N;
    var height = MediaQuery.sizeOf(context).height * 0.8; //80.h;

    _controller.reset();

    animationList.clear();
    for (var i = 0; i < N; i++) {
      var x = 0.0;
      var y = 0.0;

      var h = (height - userWidgetSize) / X;

      print("!!!twoDList $i ${provider.twoDList[i]}");
      print("!!!roadList $i ${provider.roadList[i]}");

      _animation = TweenSequence(
        <TweenSequenceItem<Offset>>[
          for (var i in provider.roadList[i]) ...[
            TweenSequenceItem<Offset>(
              tween: Tween<Offset>(
                      begin: Offset(x, y),
                      end: Offset(i != 0 ? x = x + i * width : x,
                          i == 0 ? y = y + h : y))
                  .chain(CurveTween(curve: Curves.ease)),
              weight: 100.0,
            ),
          ]
        ],
      ).animate(_controller);

      animationList.add(_animation);
    }

   /* var bottom = 170;*/

    provider.animationController = _controller;

    return Container(
      color: Colors.white,
      //wrap CustomPaint with CanvasTouchDetector
      child: Stack(
        children: [
          CustomPaint(
            size: Size(
                MediaQuery.sizeOf(context).width,
                MediaQuery.sizeOf(context).height,),
              //  100.w,
               // 100.h /*- bottom*/),
            painter: GamePainter(X, N, twoDList, height),
            // foregroundPainter: UserPainter(X, N, twoDList, listenable: _animation2),
          ),

          for (var j = 0; j < N; j++) ...[
            Positioned(
              left: width * (j + 1) - width / 2 - (userWidgetSize / 2),
              top: userWidgetSize / 2,
              child: AnimatedBuilder(
                animation: animationList[j],
                builder: (context, child) => Transform.translate(
                  offset: Offset(
                      animationList[j].value.dx, animationList[j].value.dy),
                  child: User(num: j, size: userWidgetSize),
                ),
              ),
            ),
            // ),
          ]


        ],
      ),
    );
  }
}

class GamePainter extends CustomPainter {
  int X = 0;
  var list;

//  late int N = list.length;
  var N;

  var height;

  GamePainter(this.X, this.N, this.list, this.height);

  var topMargin = 50;
  var cnt = 0;

  @override
  void paint(Canvas canvas, Size size) {
    cnt++;

    // Paint 클래스는 어떤식으로 화면을 그릴지 정할 때 사용한다.
    Paint paint = Paint()
      // 색은 주황색
      ..color = LADDER_COLOR
      // 선의 끝은 각지게 표현
      ..strokeCap = StrokeCap.square
      // 선의 굵기는 8.0
      ..strokeWidth = 8.0;

    // 선을 그리지 위한 좌표값
    var width = size.width / N;
    var widthx = size.width / X;

    print(' X $X   N $N');

    var h = (height - topMargin) / X;

    for (var i = 1; i <= N; i++) {
      Offset p1 = Offset(width * i - width / 2, topMargin.toDouble());
      Offset p2 = Offset(width * i - width / 2, height);

      canvas.drawLine(p1, p2, paint);

      for (var j = 0; j < X; j++) {
        if (list[i - 1][j] == 1) {
          Offset x1 = Offset(width * i - width / 2, h * j + topMargin);
          Offset x2 = Offset(width * (i + 1) - width / 2, h * j + topMargin);

          canvas.drawLine(x1, x2, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant GamePainter data) {
    print("shouldREpaint  ${data.list}");
    return false;
  }
}
