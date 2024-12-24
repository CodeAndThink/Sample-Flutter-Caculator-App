class Operation {
  String operationString = "0";
  String operationResult = "0";

  Operation(String operation, String result) {
    operationString = operation;
    operationResult = result;
  }

  Map<String, dynamic> toJson() {
    return {
      'operationString': operationString,
      'operationResult': operationResult,
    };
  }

  factory Operation.fromJson(Map<String, dynamic> json) {
    return Operation(
      json['operationString'],
      json['operationResult'],
    );
  }
}
