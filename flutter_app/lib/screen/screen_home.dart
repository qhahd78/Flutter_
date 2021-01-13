import 'package:flutter/material.dart';
import 'package:flutter_app/model/model_quiz.dart';
import 'package:flutter_app/screen/screen_quiz.dart';
import 'package:flutter/rendering.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 더미데이터 생성. api 호출할 영역인 homeScreenstate 내부에 .
  // 퀴즈 풀기 버튼을 눌렀을 때, 랜덤한 퀴즈 가져옴.
  //home 에서 quiz 로 넘어갈 때 quiz 데이터 넘겨줌.
  List<Quiz> quizs = [
    Quiz.fromMap({
      'title': 'test',
      'candidates': ['a', 'b', 'c', 'd'],
      'answer': 0
    }),
    Quiz.fromMap({
      'title': 'test',
      'candidates': ['a', 'b', 'c', 'd'],
      'answer': 0
    }),
    Quiz.fromMap({
      'title': 'test',
      'candidates': ['a', 'b', 'c', 'd'],
      'answer': 0
    }),
  ];
  @override
  Widget build(BuildContext context) {
    // 해당 기기의 여러 상태정보를 알 수 있다.
    Size screenSize = MediaQuery.of(context).size;
    // 너비와 높이가 고정값이 아닌 상대수치. flex 쓰는 거라고
    //생각하면 됨 .
    double width = screenSize.width;
    double height = screenSize.height;

    //SafeArea : 안전한 영역을 잡아주는 위젯(상 하단 영역 침범 x)
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('고양이 이름 맞추기'),
          backgroundColor: Colors.deepPurple[200],
          // 앱 바 좌측 버튼 삭제 (컨테이너 안에 아무것도 없음)
          leading: Container(),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Image.asset(
                'images/quiz.jpg',
                width: width * 0.8,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(width * 0.024),
            ),
            Text(
              '플러터 퀴즈 앱',
              style: TextStyle(
                fontSize: width * 0.065,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '퀴즈를 풀기 전 안내사항입니다. \n 꼼꼼히 읽고 퀴즈 풀기를 눌러주세요.',
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.all(width * 0.048),
            ),
            _buildStep(width, '1. 퀴즈 3개를 풀어보세요.'),
            _buildStep(width, '2. 잘 읽고 문제를 푼 뒤 \n 다음 버튼을 누르세요.'),
            _buildStep(width, '3. 옹이 봄이 문제니까 잘 풀어야 합니다.'),
            Padding(
              padding: EdgeInsets.all(width * 0.048),
            ),
            Container(
              padding: EdgeInsets.only(bottom: width * 0.036),
              child: Center(
                child: ButtonTheme(
                  minWidth: width * 0.8,
                  height: height * 0.05,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: RaisedButton(
                    child: Text(
                      '지금 퀴즈 풀기',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.deepPurple[200],
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizScreen(
                            quizs: quizs,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

//안내사항 출력 함수는 _HomeScreenState 클래스 내부에 생성.
  Widget _buildStep(double width, String title) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        width * 0.048,
        width * 0.024,
        width * 0.048,
        width * 0.024,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.check_box,
            size: width * 0.04,
          ),
          Padding(
            padding: EdgeInsets.only(right: width * 0.024),
          ),
          Text(title),
        ],
      ),
    );
  }
}
