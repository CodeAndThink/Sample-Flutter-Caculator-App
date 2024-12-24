import 'package:caculator_app/model/model/operation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DataManager {
  final _storage = const FlutterSecureStorage();
  static final shared = DataManager();

  Future<void> saveUserData(Operation data) async {
    await _storage.write(key: "operationData", value: data.operationString);
    await _storage.write(
        key: "operationResultData", value: data.operationResult);
  }

  Future<Operation> getUserData() async {
    final operationData = await _storage.read(key: "operationData");
    final operationResultData = await _storage.read(key: "operationResultData");
    return Operation(operationData ?? "0", operationResultData ?? "0");
  }
}
