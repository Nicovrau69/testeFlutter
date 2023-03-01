import 'package:flutter/material.dart';
import 'package:testeflutter/models/category.dart';
import 'categorias.dart';
//Form que aparece ao clicar em cadastrar transação

class TransactionForm extends StatefulWidget {
  final void Function(String, double, String) onSubmit;

  List<Categorias> test = [];

  TransactionForm(this.onSubmit, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();
  final observacaoController = TextEditingController();

  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;
    final observacao = observacaoController.text;

    if (title.isEmpty || value <= 0) {
      return;
    }
    widget.onSubmit(title, value, observacao);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: <Widget>[
          TextField(
            controller: titleController,
            onSubmitted: (_) => _submitForm(),
            decoration: const InputDecoration(
              labelText: 'Título',
            ),
          ),
          TextField(
              controller: valueController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitForm(),
              decoration: const InputDecoration(
                labelText: 'Valor (R\$)',
              )),
          TextField(
            controller: observacaoController,
            onSubmitted: (_) => _submitForm(),
            decoration: const InputDecoration(
              labelText: 'Observação (Opcional)',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: (const Text(
                    'Cancelar',
                    style: TextStyle(color: Colors.cyan),
                  ))),
              TextButton(
                  onPressed: _submitForm,
                  child: (const Text(
                    'Nova Transação',
                    style: TextStyle(color: Colors.cyan),
                  ))),
            ],
          )
        ]),
      ),
    );
  }
}
