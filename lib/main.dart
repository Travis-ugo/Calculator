import 'package:flutter/material.dart';

void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Container(
          margin: EdgeInsets.only(left: 8),
          child: Text('Calculator'),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(child: buildResult()),
          Expanded(
            flex: 2,
            child: buildButtons(),
          ),
        ],
      )),
    );
  }
}

Widget buildResult() => Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '0',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
            ),
          ),
          SizedBox(height: 24),
          Text(
            '0',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );

Widget buildButtons() => Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(32),
        ),
      ),
      child: Column(
        children: <Widget>[
          buildButtonRow('AC', '<x', '', '/'),
          buildButtonRow('7', '8', '9', 'x'),
          buildButtonRow('4', '5', '6', '-'),
          buildButtonRow('1', '2', '3', '+'),
          buildButtonRow('0', '.', '', '='),
        ],
      ),
    );

Widget buildButtonRow(
  String first,
  String second,
  String third,
  String fourth,
) {
  final row = [first, second, third, fourth];
  return Expanded(
    child: Row(
      children: row
          .map(
            (text) => ButtonWidget(
              text: text,
              onClicked: () => print(text),
              onClickedLong: () => print(text),
            ),
          )
          .toList(),
    ),
  );
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  final VoidCallback onClickedLong;

  const ButtonWidget({
    Key key,
    @required this.text,
    @required this.onClicked,
    @required this.onClickedLong,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = getTextColor(text);
    final double fontSize = Utils.isOperator(text, hasEquals: true) ? 26 : 22;
    final style = TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
    );
    return Expanded(
      child: Container(
        height: double.infinity,
        margin: EdgeInsets.all(6),
        child: ElevatedButton(
          onPressed: onClicked,
          onLongPress: onClickedLong,
          child: text == '<x'
              ? Icon(
                  Icons.backspace_outlined,
                  color: color,
                )
              : Text(text, style: style),
          style: ElevatedButton.styleFrom(
              primary: MyColors.background3,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              )),
        ),
      ),
    );
  }
}

Color getTextColor(String buttonText) {
  switch (buttonText) {
    case '+':
    case '-':
    case 'x':
    case '/':
    case '=':
      return MyColors.operators;
    case 'AC':
    case '<x':
      return MyColors.delete;
    default:
      return MyColors.numbers;
  }
}

class Utils {
  static bool isOperator(String buttonText, {bool hasEquals = false}) {
    final operators = ['+', '-', '+', 'x', '.']..addAll(hasEquals ? ['='] : []);
    return operators.contains(buttonText);
  }
}

class MyColors {
  static final Color background1 = Color(0xff22252d);
  static final Color background2 = Color(0xff292d36);
  static final Color background3 = Color(0xff272b33);
  static final Color operators = Color(0xfff57b7b);
  static final Color delete = Color(0xff26f4ce);
  static final Color numbers = Color(0xffffffff);
}
