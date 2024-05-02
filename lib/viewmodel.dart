import 'package:flutter/cupertino.dart';
import 'dart:math';

class ViewModel extends ChangeNotifier{

  int N = 2;
  int X = 10;

  var animationStart = false;
  //late var countNum = 0;

  //int get count => countNum;

  var animationController;

   var goalTextList = List<String>.filled(2, "빈 칸", growable: true);

 /* late var goalTextList = List<String>.filled(
      N,
      "빈 칸",
      growable: true);
*/
  void createGoalTextList(){
    goalTextList = List<String>.filled(N, "빈 칸", growable: true);
  }



  void add(){
    //countNum++;
    N++;
    createGraph();
    goalTextList.add("빈 칸");
    //notifyListeners();
  }

  void remove(){
    //countNum --;
    N--;
    createGraph();
    goalTextList.removeAt(N);
    //notifyListeners();
  }

  late var roadList = List<List>.filled(
      N,
      List<int>.filled(1, 0, growable: true),
      growable: true);


  late var twoDList = List<List>.generate(
      N, (i) => List<dynamic>.generate(
      X, (index) => 0, growable: false), growable: false);

  get list => twoDList;

  void createGraph(){
    print("@@  ViewModel  $N $X  ");

    print("@@  ${twoDList}");
    print('@@  clear graph');
    twoDList = List<List>.generate(
        N, (i) => List<dynamic>.generate(
        X, (index) => 0, growable: false), growable: false);
    print("!! twoDList  ${twoDList}");

    roadList = List<List>.generate(
        N,
        (i) => List<int>.filled(1, 0, growable: true),
        growable: true);
    print("!! roadList ${roadList}");

    if(N==2){
      for(var i = 1; i<X; i++){
        var random = Random().nextInt(100) < 35 ? true : false;
        if(random){
          print("twoDList[0][$i]  twoDList[1][$i]");
          twoDList[0][i] = 1;
          twoDList[1][i] = -1;
        }
      }

    }else{
      for(var i = 1; i<X; i++){
        // [0] 0




        if( twoDList[2][i]!=0){
          print("break");
          break;
        }

        var random = Random().nextInt(100) < 35 ? true : false;
        if(N <=3){
          random = Random().nextInt(100) < 30 ? true : false;
        }
        if(random){
          print("twoDList[0][$i]  twoDList[1][$i]");
          twoDList[0][i] = 1;
          twoDList[1][i] = -1;
        }

      }

      for(var i = 1; i<X; i++){
        // [4] N-1
        if( twoDList[N-2][i]!=0){
          print("break");
          break;
        }

        var random = Random().nextInt(100) < 35 ? true : false;
        if(N <=3){
          random = Random().nextInt(100) < 70 ? true : false;
        }

        if(random){
          print("twoDList[4][$i]  twoDList[3][${i}]");
          twoDList[N-1][i] = -1;
          twoDList[N-2][i] = 1;
        }
      }

      for(var j = 1; j<X; j++){
        for(var i = 1; i<twoDList.length-2; i++){
          print("$i");
          // [1] .. [3]  1 ~ N-2
          if(twoDList[i-1][j]!=0 && twoDList[i+1][j]!=0){
            print("break");
            break;
          }


          var random = Random().nextInt(100) < 40 ? true : false;

          if(random && twoDList[i][j]==0 && twoDList[i+1][j]==0){
            print("twoDList[$i][$j]   twoDList[${i+1}][$j]");
            twoDList[i][j] = 1;
            twoDList[i+1][j] = -1;
          }

        }
      }
      print("@@ viewmodel ${twoDList}");

    }





    createRoadList();
    notifyListeners();
  }


  void createRoadList() {
    for(var i=0; i<N; i++){
      var x = i;
      var y = 0;

      for(var j=0; j<X; j++){
        if(twoDList[x][y] == 0){
          if(j != 0){
            roadList[i].add(0);
          }
        }else{
          roadList[i].add(twoDList[x][y]);
          roadList[i].add(0);
          if(twoDList[x][y] == 1){
            x++;
          }else{
            x--;
          }
        }
        y++;

      }


    }
  }








}