import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = '';
  String result = '';

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        input = '';
        result = '';
      } else if (buttonText == '=') {
        try {
          result = _calculateResult();
          input = result; // Set the input to the calculated result for further operations
        } catch (e) {
          result = 'Error';
        }
      } else {
        input += buttonText;
      }
    });
  }

  String _calculateResult() {
    try {
      List<String> operators = ['+', '-', '*', '/'];

      for (String operator in operators) {
        List<String> operands = input.split(operator);

        if (operands.length == 2) {
          double operand1 = double.parse(operands[0]);
          double operand2 = double.parse(operands[1]);

          switch (operator) {
            case '+':
              return (operand1 + operand2).toString();
            case '-':
              return (operand1 - operand2).toString();
            case '*':
              return (operand1 * operand2).toString();
            case '/':
              if (operand2 != 0) {
                return (operand1 / operand2).toString();
              } else {
                throw Exception("Division by zero");
              }
          }
        }
      }

      // Return the input as it is if no valid calculation is found
      return input;
    } catch (e) {
      return 'Error';
    }
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: InkWell(
        onTap: () {
          _onButtonPressed(buttonText);
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator App'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              color: Colors.grey.shade200,
              alignment: Alignment.bottomRight,
              child: Text(
                input,
                style: TextStyle(fontSize: 32),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        _buildButton('7'),
                        _buildButton('8'),
                        _buildButton('9'),
                        _buildButton('/'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        _buildButton('4'),
                        _buildButton('5'),
                        _buildButton('6'),
                        _buildButton('*'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        _buildButton('1'),
                        _buildButton('2'),
                        _buildButton('3'),
                        _buildButton('-'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        _buildButton('C'),
                        _buildButton('0'),
                        _buildButton('='),
                        _buildButton('+'),
                      ],
                    ),
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

