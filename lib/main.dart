import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Color(0xFF1F1F1F),
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String output = "";
  String _expression = "";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        output = "";
        _expression = "";
        num1 = 0.0;
        num2 = 0.0;
        operand = "";
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "*" ||
          buttonText == "/") {
        if (output.isNotEmpty) {
          if (operand != "") {
            num2 = double.parse(output);
            calculateResult();
            operand = buttonText;
            _expression = output + " $buttonText";
            output = "";
          } else {
            num1 = double.parse(output);
            operand = buttonText;
            _expression += " $buttonText";
            output = "";
          }
        }
      } else if (buttonText == "=") {
        if (operand != "" && output.isNotEmpty) {
          num2 = double.parse(output);
          calculateResult();
          _expression += " =";
          output = num1.toString();
          num1 = 0.0;
          num2 = 0.0;
          operand = "";
        }
      } else {
        output += buttonText;
        _expression += buttonText;
      }
    });
  }

  void calculateResult() {
    switch (operand) {
      case "+":
        output = (num1 + num2).toString();
        break;
      case "-":
        output = (num1 - num2).toString();
        break;
      case "*":
        output = (num1 * num2).toString();
        break;
      case "/":
        if (num2 != 0) {
          output = (num1 / num2).toString();
        } else {
          output = "Error";
        }
        break;
      default:
        break;
    }
    _expression += " ${num2.toString()}";
  }

  Widget buildButton(String buttonText, Color buttonColor) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: ElevatedButton(
          onPressed: () => buttonPressed(buttonText),
          style: ElevatedButton.styleFrom(
            primary: buttonColor,
            padding: EdgeInsets.all(24.0),
          ),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 90.0),
            child: Text(
              _expression,
              style: TextStyle(fontSize: 24.0, color: Colors.white),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              output,
              style: TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Color(0xFF1F1F1F),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      buildButton("7", Color(0xFF292929)),
                      buildButton("8", Color(0xFF292929)),
                      buildButton("9", Color(0xFF292929)),
                      buildButton("/", Colors.orange),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      buildButton("4", Color(0xFF292929)),
                      buildButton("5", Color(0xFF292929)),
                      buildButton("6", Color(0xFF292929)),
                      buildButton("*", Colors.orange),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      buildButton("1", Color(0xFF292929)),
                      buildButton("2", Color(0xFF292929)),
                      buildButton("3", Color(0xFF292929)),
                      buildButton("-", Colors.orange),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      buildButton(".", Color(0xFF292929)),
                      buildButton("0", Color(0xFF292929)),
                      buildButton("00", Color(0xFF292929)),
                      buildButton("+", Colors.orange),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      buildButton("C", Color(0xFF292929)),
                      buildButton("=", Colors.blue),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

