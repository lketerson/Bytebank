import 'package:flutter/material.dart';

void main() {
  runApp(const ByteBankApp());
}

class ByteBankApp extends StatelessWidget {
  const ByteBankApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListaTransferencia(),
      ),
    );
  }
}

//List os tranference cards info
class ListaTransferencia extends StatelessWidget {
  const ListaTransferencia({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista Transferencia'),
      ),
      body: Column(
        children: [
          ItemTransferencia(Transferecia(300.0, 4343)),
          ItemTransferencia(Transferecia(654.27, 2929))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final Future future = Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return FormularioTransferencia();
              },
            ),
          );
          future.then(
            (tranferenciaRecebida) {
              debugPrint('Chegou no then');
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

//Widget with fields to create a transference
class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorNumeroConta = TextEditingController();
  final TextEditingController _controladorValor = TextEditingController();
  FormularioTransferencia({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criando tranferencia'),
      ),
      body: Column(
        children: [
          Editor(
            controlador: _controladorNumeroConta,
            rotulo: 'Numero da Conta',
            dica: '0000',
            icone: Icons.account_balance,
          ),
          Editor(
            controlador: _controladorValor,
            rotulo: 'Valor',
            dica: '0.00',
            icone: Icons.monetization_on,
          ),
          ElevatedButton(
              onPressed: () => _criaTransferencia(context),
              child: const Text('Confirmar')),
        ],
      ),
    );
  }

//create a tranference object
  void _criaTransferencia(BuildContext context) {
    final int? numeroConta = int.tryParse(_controladorNumeroConta.text);
    final double? valorTotal = double.tryParse(_controladorValor.text);
    if (numeroConta != null && valorTotal != null) {
      final tranferenciaCraida = Transferecia(valorTotal, numeroConta);
      Navigator.pop(context, tranferenciaCraida);
    }
  }
}

//Create a new input field
class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData? icone;
  const Editor({
    required this.controlador,
    required this.rotulo,
    required this.dica,
    this.icone,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controlador,
        style: const TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
          icon: icone != null ? Icon(icone) : null,
          labelText: rotulo,
          hintText: dica,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

//Create a new card item for the transference
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

//Transference class
class Transferecia {
  final double valorTotal;
  final int numeroConta;

  Transferecia(this.valorTotal, this.numeroConta);

  @override
  String toString() {
    return 'Transferencia{:$valorTotal, numeroConta: $numeroConta';
  }
}
