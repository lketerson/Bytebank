class Transaction {
  final String name;
  final int account;
  final double ammount;

  Transaction(this.name, this.account, this.ammount);

  @override
  String toString() {
    return 'Transaction{name: $name \n account: $account \n Ammount: $ammount}';
  }
}
