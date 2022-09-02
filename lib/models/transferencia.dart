class Transferecia {
  final double valorTotal;
  final int numeroConta;

  Transferecia(
    this.valorTotal,
    this.numeroConta,
  );

  @override
  String toString() {
    return 'Transferencia{:$valorTotal, numeroConta: $numeroConta';
  }
}
