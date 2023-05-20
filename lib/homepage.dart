import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _operation = "";
  double num1 = 0;
  double num2 = 0;
  String result = "0";
  String finalResult = "0";
  String operators = "";
  List<String> history = [];

  void clearAll() {
    num1 = 0;
    num2 = 0;
    result = "0";
    finalResult = "0";
    operators = "";
    _operation = "";
  }

  void onDigitPress(String text) {
    if (text == "+" || text == "-" || text == "*" || text == "/") {
      if (num1 == 0) {
        num1 = double.parse(result);
      } else {
        num2 = double.parse(result);
        evaluateExpression();
        num1 = double.parse(result);
      }
      result = "0";
      finalResult = "0";
      operators = text;
      _operation += operators;
    } else if (text == ".") {
      if (!result.contains(".")) {
        result += ".";
      }
      finalResult = result;
      _operation += ".";
    } else if (text == "=") {
      num2 = double.parse(result);
      evaluateExpression();
      result = finalResult;
      _operation = finalResult;
    } else if (text == "CLEAR") {
      clearAll();
    } else {
      if (result == "0") {
        result = text;
      } else {
        result += text;
      }
      finalResult = result;
      _operation += text;
    }

    setState(() {});
  }

  void evaluateExpression() {
    if (operators == "+") {
      finalResult = (num1 + num2).toString();
      history.insert(0, '$_operation = $finalResult');
    }
    if (operators == "-") {
      finalResult = (num1 - num2).toString();
      history.insert(0, '$_operation = $finalResult');
    }
    if (operators == "*") {
      finalResult = (num1 * num2).toString();
      history.insert(0, '$_operation = $finalResult');
    }
    if (operators == "/") {
      finalResult = (num1 / num2).toString();
      history.insert(0, '$_operation = $finalResult');
    }
    result = finalResult;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Kalkulator'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.calculate), text: "Kalkulator"),
              Tab(icon: Icon(Icons.history), text: "Historia"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            calculatorView(),
            historyView(),
          ],
        ),
      ),
    );
  }

  Widget calculatorView() {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20.0),
                alignment: Alignment.bottomRight,
                child: Text(
                  _operation,
                  style: TextStyle(
                    fontSize: constraints.maxWidth * 0.1,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            buildButtonRow(["7", "8", "9", "/"], constraints),
            buildButtonRow(["4", "5", "6", "*"], constraints),
            buildButtonRow(["1", "2", "3", "-"], constraints),
            buildButtonRow([".", "0", "00", "+"], constraints),
            buildClearAndEqualsButtonRow(["CLEAR", "="], constraints),
            SizedBox(height: 20),  // Adding a little space at the bottom
          ],
        ),
      );
    });
  }

  Widget historyView() {
    return ListView.builder(
      itemCount: history.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(
            history[index],
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  Widget buildButtonRow(List<String> buttonTexts, BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttonTexts.map((buttonText) => buildCustomButton(buttonText, constraints)).toList(),
    );
  }

  Widget buildClearAndEqualsButtonRow(List<String> buttonTexts, BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttonTexts.map((buttonText) => buildClearOrEqualsButton(buttonText, constraints)).toList(),
    );
  }

  Widget buildCustomButton(String text, BoxConstraints constraints) {
    return Container(
      height: constraints.maxWidth * 0.2,
      width: constraints.maxWidth * 0.2,
      margin: EdgeInsets.all(5.0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
        ),
        onPressed: () => onDigitPress(text),
        child: Text(
          text,
          style: TextStyle(
            fontSize: constraints.maxWidth * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }


  Widget buildClearOrEqualsButton(String text, BoxConstraints constraints) {
    return Container(
      height: constraints.maxWidth * 0.2,
      width: constraints.maxWidth * 0.45,
      margin: EdgeInsets.all(5.0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
        ),
        onPressed: () => onDigitPress(text),
        child: Text(
          text,
          style: TextStyle(
            fontSize: constraints.maxWidth * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
