import 'package:flutter/material.dart';

import '../../components/editor.dart';
import '../../models/transferencia.dart';

class FormularioTransferencia extends StatefulWidget {
  const FormularioTransferencia({super.key});

//create a tranference object

  @override
  State<StatefulWidget> createState() {
    return _FormularioTransferenciaState();
  }
}

class _FormularioTransferenciaState extends State<FormularioTransferencia> {
  final TextEditingController _controladorNumeroConta = TextEditingController();
  final TextEditingController _controladorValor = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criando tranferencia'),
      ),
      body: SingleChildScrollView(
        child: Column(
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
      ),
    );
  }

  void _criaTransferencia(BuildContext context) {
    final int? numeroConta = int.tryParse(_controladorNumeroConta.text);
    final double? valorTotal = double.tryParse(_controladorValor.text);
    if (numeroConta != null && valorTotal != null) {
      final tranferenciaCraida = Transferecia(valorTotal, numeroConta);
      Navigator.pop(context, tranferenciaCraida);
    }
  }
}
