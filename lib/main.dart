import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';


void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  TextEditingController _inputController = TextEditingController();
  double firstNumber = 0;
  double secondNumber = 0;
  String currentOperation = '';
  double result = 0;

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _onNumberClick(String value) {
    setState(() {
      _inputController.text += value;
    });
  }

  void _onOperationClick(String operation) {
    setState(() {
      firstNumber = double.parse(_inputController.text);
      _inputController.text = '';
      currentOperation = operation;
    });
  }

  void _calculateResult() {
  setState(() {
    String expression = _inputController.text;
    expression = expression.replaceAll('×', '*').replaceAll('÷', '/');
    Parser p = Parser();
    Expression exp = p.parse(expression);
    ContextModel cm = ContextModel();
    try {
      result = exp.evaluate(EvaluationType.REAL, cm);
      _inputController.text = result.toString();
    } catch (e) {
      _inputController.text = 'Error';
    }
    currentOperation = '';
  });
}


  void _clearAll() {
    setState(() {
      _inputController.text = '';
      firstNumber = 0;
      secondNumber = 0;
      currentOperation = '';
      result = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _inputController.text,
                style: TextStyle(fontSize: 40),
              ),
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                buildButtonRow(['7', '8', '9', '÷']),
                buildButtonRow(['4', '5', '6', '×']),
                buildButtonRow(['1', '2', '3', '-']),
                buildButtonRow(['0', '.', '=', '+']),
              ],
            ),
          ),
          SizedBox(height: 8),
          _buildClearButton(),
        ],
      ),
    );
  }

  Widget buildButtonRow(List<String> labels) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: labels.map((label) {
          if (label != '=') {
            return Expanded(
              child: ElevatedButton(
                onPressed: () => _onNumberClick(label),
                child: Text(
                  label,
                  style: TextStyle(fontSize: 24),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
              ),
            );
          } else {
            return Expanded(
              child: ElevatedButton(
                onPressed: _calculateResult,
                child: Text(
                  label,
                  style: TextStyle(fontSize: 24),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  primary: Colors.green,
                ),
              ),
            );
          }
        }).toList(),
      ),
    );
  }

  Widget _buildClearButton() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _clearAll,
        child: Text(
          'C',
          style: TextStyle(fontSize: 24),
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          primary: Colors.red,
        ),
      ),
    );
  }
}
