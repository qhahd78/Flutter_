import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/model_quiz.dart';
import 'package:flutter_app/widget/widget_candidate.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

//더미 데이터를 QuizScreen 으로 넘겨주기 위해
// QuizScreen 클래스 형성.
// ignore: must_be_immutable
class QuizScreen extends StatefulWidget {
  List<Quiz> quizs;
  // 생성자를 통해 이전 화면으로부터 퀴즈 데이터 넘겨받기 .
  QuizScreen({this.quizs});
  @override
  //상태 관리 선언
  _QuizScreenState createState() => _QuizScreenState();
}

// _QuizScreenState 에는 세 가지 상태 정보 필요.
class _QuizScreenState extends State<QuizScreen> {
  // 첫째로 각 퀴즈별 사용자의 정답을 담아놓을 _answers 리스트.
  // 초기값은 -1 (3문제라서 3개 )
  List<int> _answers = [-1, -1, -1];

  // 둘째로 퀴즈 하나에 대해 각 선택지 중 어떤게 선택 되었는지
  // True or False 로 기록하는 리스트. 초기값은 false 고
  // 선택지가 4개니까 4개 .
  List<bool> _answerState = [false, false, false, false];
  // 셋째로 현재 어떤 문제를 보고 있는지.
  int _currentIndex = 0;
  SwiperController _controller = SwiperController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepPurple[200],
        body: Center(
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.deepPurple[200]),
              ),
              width: width * 0.85,
              height: height * 0.5,
              child: Swiper(
                controller: _controller,
                physics: NeverScrollableScrollPhysics(),
                loop: false,
                itemCount: widget.quizs.length,
                // ignore: non_constant_identifier_names
                itemBuilder: (BuildContext, int index) {
                  return _buildQuizCard(widget.quizs[index], width, height);
                },
              )),
        ),
      ),
    );
  }

// 카드 만들기 !!!
  Widget _buildQuizCard(Quiz quiz, double width, double height) {
    return Container(
      decoration: BoxDecoration(
        //박스 둥글게 설정
        borderRadius: BorderRadius.circular(20),
        //보더 색깔 하얀색으로 설정.
        border: Border.all(color: Colors.white),
        color: Colors.white,
      ),

      //컨테이너의 자식요소(child)
      child: Column(
        // 열의 세로축. 축을 가운데로 잡겠다.
        crossAxisAlignment: CrossAxisAlignment.center,
        // 컨테이너 추가
        children: <Widget>[
          Container(
            //패딩 추가
            padding: EdgeInsets.fromLTRB(0, width * 0.024, 0, width * 0.024),
            // 텍스트 스타일 추가
            child: Text(
              'Q' + (_currentIndex + 1).toString() + '.',
              style: TextStyle(
                fontSize: width * 0.06,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // 본문? 내용들 들어가는 COntainer 추가
          Container(
            width: width * 0.08,
            padding: EdgeInsets.only(top: width * 0.012),
            child: AutoSizeText(
              // 자동으로 글씨가 너무 길면 줄여준다. text 대신 들어감.
              //text 글씨 들어감.
              quiz.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                fontSize: width * 0.048,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Column(
            children: _buildCandidates(width, quiz),
          ),
          Container(
            padding: EdgeInsets.all(width * 0.024),
            child: Center(
              child: ButtonTheme(
                minWidth: width * 0.5,
                height: height * 0.05,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: RaisedButton(
                  child: _currentIndex == widget.quizs.length - 1
                      ? Text('결과보기')
                      : Text('다음문제'),
                  textColor: Colors.white,
                  color: Colors.deepPurple[200],
                  onPressed: _answers[_currentIndex] == -1
                      ? null
                      : () {
                          if (_currentIndex == widget.quizs.length - 1) {
                          } else {
                            _answerState = [false, false, false, false];
                            _currentIndex += 1;
                            _controller.next();
                          }
                        },
                ),
              ),
            ),
          )
        ],
      ),
    );
  } // 이후 배치할 위젯들을 아래부터 나오게 한다.

// 여기부터 오류 . 다시 해보기 !!!!!
  List<Widget> _buildCandidates(double width, Quiz quiz) {
    List<Widget> _children = [];
    for (int i = 0; i < 4; i++) {
      _children.add(
        CandWidget(
          index: i,
          text: quiz.candidates[i],
          width: width,
          answerState: _answerState[i],
          tap: () {
            setState(() {
              for (int j = 0; j < 4; j++) {
                if (j == i) {
                  _answerState[j] = true;
                  _answers[_currentIndex] = j;
                } else {
                  _answerState[j] = false;
                }
              }
            });
          },
        ),
      );
      _children.add(
        Padding(
          padding: EdgeInsets.all(width * 0.024),
        ),
      );
    }
    return _children;
  }
}

// ㅂㄴ복문을 통해 전체 선택지를 확인, 현재의 선택지는 true.
// 현재 선택지가 아니면 false
