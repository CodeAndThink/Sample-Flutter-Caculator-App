import 'package:caculator_app/manager/data_manager.dart';
import 'package:caculator_app/model/model/operation.dart';
import 'package:flutter/material.dart';

class HistoryViewModel extends ChangeNotifier {
  List<Operation> _historyOperation = [];
  List<Operation> get historyOperation => _historyOperation;

  late DataManager _dataManager;

  HistoryViewModel(DataManager dataManager) {
    _dataManager = dataManager;
    _initialData();
  }

  //Data Inlitialization
  void _initialData() async {
    _historyOperation = await _dataManager.getHistoryOperations();
    notifyListeners();
  }
}
