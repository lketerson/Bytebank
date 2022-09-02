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
      appBar: AppBar(title: const Text('Lista Transferencia')),
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
          final Future future = Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const FormularioTransferencia();
              },
            ),
          );
          future.then(
            (tranferenciaRecebida) {
              if (tranferenciaRecebida != null) {
                setState(() {
                  widget._listaTransferecias.add(tranferenciaRecebida);
                });
              }
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
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
        title: Text(_transferecia.valorTotal.toString()),
        subtitle: Text(_transferecia.numeroConta.toString()),
      ),
    );
  }
}
