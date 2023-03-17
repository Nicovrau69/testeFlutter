import 'package:flutter/material.dart';
import '../models/category.dart';

//Form que aparece ao clicar em cadastrar transação

class TransactionForm extends StatefulWidget {
  final void Function(String, double, String, String) onSubmit;
  final List<Category> cat;
  const TransactionForm(this.onSubmit, this.cat, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();
  final observacaoController = TextEditingController();

  String? opcao;

  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;
    final observacao = observacaoController.text;
    final catiguria = opcao;

    if (title.isEmpty || value <= 0) {
      return;
    }
    widget.onSubmit(title, value, observacao, catiguria!);
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
            SizedBox(
              width: 200,
              child: DropdownButton(
                isExpanded: true,
                items: widget.cat.map((op) {
                  return DropdownMenuItem(
                    value: op.title,
                    child: Text(op.title),
                  );
                }).toList(),
                onChanged: (String? v) {
                  setState(() {
                    opcao = v;
                  });
                },
                value: opcao,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
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
        ));
  }
}
