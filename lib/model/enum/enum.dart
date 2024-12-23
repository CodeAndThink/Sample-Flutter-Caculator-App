enum Operation {
  add,
  subtract,
  multiply,
  divide,
  equal,
  reset,
  negation,
  persentage,
  delete,
  dot
}

String operationToDisplaySymbol(Operation operation) {
  switch (operation) {
    case Operation.add:
      return '+';
    case Operation.subtract:
      return '-';
    case Operation.multiply:
      return '×';
    case Operation.divide:
      return '÷';
    case Operation.equal:
      return '=';
    case Operation.reset:
      return 'C';
    case Operation.negation:
      return 'assets/icons/add_of_minus_icon.svg';
    case Operation.persentage:
      return '%';
    case Operation.delete:
      return 'assets/icons/delete.svg';
    case Operation.dot:
      return '.';
    default:
      return '';
  }
}

String operationToText(Operation operation) {
  switch (operation) {
    case Operation.add:
      return '+';
    case Operation.subtract:
      return '-';
    case Operation.multiply:
      return 'x';
    case Operation.divide:
      return '÷';
    case Operation.persentage:
      return '%';
    case Operation.dot:
      return '.';
    default:
      return '';
  }
}

enum GlobalAssets {
  moonIcon,
  sunIcon,
}

String getGlobaleAssets(GlobalAssets asset) {
  switch (asset) {
    case GlobalAssets.moonIcon:
      return 'assets/icons/moon.svg';
    case GlobalAssets.sunIcon:
      return 'assets/icons/sun.svg';
    default:
      return '';
  }
}