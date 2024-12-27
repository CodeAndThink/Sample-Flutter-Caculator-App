class Operation {
  String operationString = "0";
  String operationResult = "0";
  String calculationDateTime = DateTime.now().toIso8601String();

  Operation(String operation, String result, String dateTime) {
    operationString = operation;
    operationResult = result;
    calculationDateTime = dateTime;
  }

  Map<String, dynamic> toJson() {
    return {
      'operationString': operationString,
      'operationResult': operationResult,
      'calculationDateTime': calculationDateTime
    };
  }

    factory Operation.fromJson(Map<String, dynamic> json) {
    return Operation(
      json['operationString'] ?? '',
      json['operationResult'] ?? '',
      json['calculationDateTime'] ?? '',
    );
  }
}
