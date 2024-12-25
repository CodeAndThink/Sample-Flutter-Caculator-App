import 'package:caculator_app/manager/data_manager.dart';
import 'package:caculator_app/manager/setting_manager.dart';
import 'package:caculator_app/model/enum/enum.dart';
import 'package:caculator_app/utils/converse_number.dart';
import 'package:flutter/material.dart';
import 'package:caculator_app/model/model/operation.dart' as operation_model;

class HomeViewModel extends ChangeNotifier {
  //MARK: Properties

  bool isDarkMode = false;

  String _operationString = "0";
  String get operationString => _operationString;

  String _operationResult = "0";
  String get operationResult => _operationResult;

  String _error = "";
  String get error => _error;

  late SettingManager _settingManager;
  late DataManager _dataManager;

  //MARK: Constructor

  HomeViewModel(SettingManager settingManager, DataManager dataManager) {
    _settingManager = settingManager;
    _dataManager = dataManager;
    _initialTheme();
    _initialData();
  }

  //MARK: Puclic Methods

  //Theme Logic
  void changeTheme() async {
    isDarkMode = !isDarkMode;
    await _settingManager.saveUserThemeMode(isDarkMode);
    notifyListeners();
  }

  //Insert Operator If Missing
  List<String> insertOperatorIfMissing(List<String> tokens) {
    List<String> result = [];

    for (int i = 0; i < tokens.length; i++) {
      result.add(tokens[i]);

      if (i < tokens.length - 1) {
        final current = tokens[i];
        final next = tokens[i + 1];
        if (RegExp(r'^-?\d+(\.\d+)?$').hasMatch(current) &&
            RegExp(r'^-?\d+(\.\d+)?$').hasMatch(next)) {
          result.add('+');
        }
      }
    }

    return result;
  }

  //Calculator Logic
  String evaluateExpression(String expr) {
    expr =
        expr.replaceAll('×', '*').replaceAll('÷', '/').replaceAll('%', '/100');

    final regex = RegExp(r'(-?\d+(\.\d+)?|[\+\-\*\/])');
    List<String> tokens =
        regex.allMatches(expr).map((match) => match.group(0)!).toList();

    tokens = insertOperatorIfMissing(tokens);

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

  //Delete Action
  void deleteAction() {
    if (_operationString.length > 1) {
      _operationString =
          _operationString.substring(0, _operationString.length - 1);
    } else {
      _operationString = '0';
    }
    notifyListeners();
  }

  //Negate Action
  void negateAction() {
    if (_operationString[0] == '-') {
      _operationString = _operationString.substring(1);
    } else {
      _operationString = '-$_operationString';
    }
    notifyListeners();
  }

  //Insert Action
  void insertOperationAction(String operationChar) {
    if (_operationString == '0') {
      if (operationChar != operationToDisplaySymbol(Operation.dot)) {
        _operationString = operationChar;
      } else {
        _operationString += operationChar;
      }
    } else {
      _operationString += operationChar;
    }
    notifyListeners();
  }

  //Reset Action
  void resetAction() {
    _operationString = "0";
    _operationResult = "0";
    notifyListeners();
  }

  //Equal Action
  void equalAction() {
    _operationString = _operationResult;
    notifyListeners();
  }

  //Calculation Action
  void calculationAction() {
    _operationResult = "0";
    try {
      final result = evaluateExpression(_operationString);
      _operationResult = ConverseNumber.converseToDefaultNumber(result);
      _changeData();
    } catch (e) {
      _setError(e.toString());
      _operationResult = _operationString;
    }
    notifyListeners();
  }

  //MARK: Private Methods

  //Set Error
  void _setError(String message) {
    _error = message;
    notifyListeners();
  }

  //Theme Mode Initialization
  void _initialTheme() async {
    isDarkMode = await _settingManager.getUserThemeMode();
    notifyListeners();
  }

  //Data Inlitialization
  void _initialData() async {
    final lastOperation = await _dataManager.getUserData();
    _operationResult = lastOperation.operationResult;
    _operationString = lastOperation.operationString;
    notifyListeners();
  }

  //Data Logic
  void _changeData() async {
    await _dataManager.saveUserData(
        operation_model.Operation(_operationString, _operationResult));
    notifyListeners();
  }
}
