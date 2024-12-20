import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  bool isDarkMode = false;

  void changeTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }

  String evaluateExpression(String expr) {
    // Thay thế các toán tử để chuẩn bị xử lý
    expr = expr.replaceAll('×', '*').replaceAll('÷', '/');

    // Tách biểu thức thành số và toán tử
    final regex = RegExp(r'(\d+(\.\d+)?|[\+\-\*\/])');
    final tokens =
        regex.allMatches(expr).map((match) => match.group(0)!).toList();

    // Xử lý nhân/chia trước
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

    // Xử lý cộng/trừ
    double result = double.parse(stack[0]);
    for (int i = 1; i < stack.length; i += 2) {
      double value = double.parse(stack[i + 1]);
      result = stack[i] == '+' ? result + value : result - value;
    }

    return result.toString();
  }
}
