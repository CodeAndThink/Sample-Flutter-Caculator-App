import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  //MARK: Properties

  bool isDarkMode = false;

  //MARK: Puclic Methods

  //Theme Logic
  void changeTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }

  //Calculator Logic
  String evaluateExpression(String expr) {
    expr = expr.replaceAll('×', '*').replaceAll('÷', '/');

    final regex = RegExp(r'(\d+(\.\d+)?|[\+\-\*\/])');
    final tokens =
        regex.allMatches(expr).map((match) => match.group(0)!).toList();

    List<String> stack = [];
    for (int i = 0; i < tokens.length; i++) {
      if (tokens[i] == '*' || tokens[i] == '/') {
        double a = double.parse(stack.removeLast());
        double b = double.parse(tokens[++i]);
        stack.add(
            tokens[i - 1] == '*' ? (a * b).toString() : (a / b).toString());
      } else {
        stack.add(tokens[i]);
      }
    }

    double result = double.parse(stack[0]);
    for (int i = 1; i < stack.length; i += 2) {
      double value = double.parse(stack[i + 1]);
      result = stack[i] == '+' ? result + value : result - value;
    }

    return result.toString();
  }
}
