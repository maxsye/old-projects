class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  Transaction(this.id, this.title, this.amount, this.date);
}

//this doesn't extend stateless or stateful because
//transaction is just a blueprint for normal dart object
//don't want to use this as a widget that should be
//rendered

//DateTime is built into dart
//not a primitive like String, double, int, boolean
