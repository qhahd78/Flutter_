import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CandWidget extends StatefulWidget {
  // void callback 은 candWidget 을 사용하는
  // 부모 위젯에서 지정한 onTap을 전달해준다.
  VoidCallback tap;
  String text;
  int index;
  double width;
  bool answerState;

  CandWidget({this.tap, this.index, this.text, this.answerState});
  _CandWidgetState createState() => _CandWidgetState();
}

class _CandWidgetState extends State<CandWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width * 0.8,
      height: widget.width * 0.1,
      padding: EdgeInsets.fromLTRB(
        widget.width * 0.048,
        widget.width * 0.024,
        widget.width * 0.048,
        widget.width * 0.024,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.deepPurple[200]),
        color: widget.answerState ? Colors.deepPurple[200] : Colors.white,
      ),
      child: InkWell(
        child: Text(
          widget.text,
          style: TextStyle(
            fontSize: widget.width * 0.035,
            color: widget.answerState ? Colors.white : Colors.black,
          ),
        ),
        onTap: () {
          setState(() {
            widget.tap();
            widget.answerState = !widget.answerState;
          });
        },
      ),
    );
  }
}
