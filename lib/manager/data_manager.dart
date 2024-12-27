import 'dart:convert';

import 'package:caculator_app/model/model/operation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DataManager {
  final _storage = const FlutterSecureStorage();
  static final shared = DataManager();

  Future<void> saveHistoryOperation(Operation operation) async {
    List<Operation> lastHistory = await getHistoryOperations();
    lastHistory.add(operation);
    final operationsJson =
        jsonEncode(lastHistory.map((e) => e.toJson()).toList());
    await _storage.write(key: "operationHistory", value: operationsJson);
  }

  Future<void> saveHistoryOperations(List<Operation> operations) async {
    final operationsJson =
        jsonEncode(operations.map((e) => e.toJson()).toList());
    await _storage.write(key: "operationHistory", value: operationsJson);
  }

  Future<List<Operation>> getHistoryOperations() async {
    final operationsJson = await _storage.read(key: "operationHistory");
    if (operationsJson == null) {
      return [Operation("0", "0")];
    }
    final List<dynamic> operationsList = jsonDecode(operationsJson);
    return operationsList.map((e) => Operation.fromJson(e)).toList();
  }
}
