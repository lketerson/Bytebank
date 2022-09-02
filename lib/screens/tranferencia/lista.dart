//List os tranference cards info
import 'package:flutter/material.dart';

import '../../models/transferencia.dart';
import 'formulario.dart';

class ListaTransferencia extends StatefulWidget {
  final List<Transferecia> _listaTransferecias = [];

  ListaTransferencia({super.key});

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciaState();
  }
}

class ListaTransferenciaState extends State<ListaTransferencia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nubank da Deep web')),
      body: ListView.builder(
        itemCount: widget._listaTransferecias.length,
        itemBuilder: (
          context,
          index,
        ) {
          final tranferencia = widget._listaTransferecias[index];
          return ItemTransferencia(tranferencia);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const FormularioTransferencia();
              },
            ),
          ).then(
            (tranferenciaRecebida) => _atualiza(tranferenciaRecebida),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _atualiza(tranferenciaRecebida) {
    if (tranferenciaRecebida != null) {
      setState(
        () {
          widget._listaTransferecias.add(tranferenciaRecebida);
        },
      );
    }
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferecia _transferecia;
  const ItemTransferencia(
    this._transferecia, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.monetization_on),
        title: Text('Valor: ${_transferecia.valorTotal} R\$'),
        subtitle: Text('Conta: ${_transferecia.numeroConta}'),
        tileColor: Colors.purple,
        textColor: Colors.white,
      ),
    );
  }
}
