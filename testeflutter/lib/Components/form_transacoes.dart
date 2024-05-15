import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import '../models/category.dart';

//Form que aparece ao clicar em cadastrar transação

class TransactionForm extends StatefulWidget {
  final void Function(String, double, String, String, DateTime) onSubmit;
  final List<Category> cat;
  const TransactionForm(this.onSubmit, this.cat, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();
  final observacaoController = TextEditingController();

  var transactionFormKey = GlobalKey<_TransactionFormState>();

  DateTime datas = DateTime.now();

  String? opcao;

  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;
    final observacao = observacaoController.text;
    final catiguria = opcao;
    final data = datas;

    if (title.isEmpty || value <= 0) {
      return;
    }
    widget.onSubmit(title, value, observacao, catiguria!, data);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(children: <Widget>[
            //text field para preencher o titulo da transacao
            TextField(
              controller: titleController,
              onSubmitted: (_) => _submitForm(),
              decoration: const InputDecoration(
                labelText: 'Título',
              ),
            ),
            //text field para preencher o valor da transacao
            TextField(
                controller: valueController,
                keyboardType: const TextInputType.numberWithOptions(
                    decimal:
                        true), //faz com que o teclado de valor seja numerico
                onSubmitted: (_) => _submitForm(),
                decoration: const InputDecoration(
                  labelText: 'Valor (R\$)',
                )),

            //text field para preencher a observação da transacao
            TextField(
              controller: observacaoController,
              onSubmitted: (_) => _submitForm(),
              decoration: const InputDecoration(
                labelText: 'Observação (Opcional)',
              ),
            ),
            // DateTimeField(
            //     onDateSelected: (date) {
            //       datas = date;
            //       setState(() {});
            //     },
            //     selectedDate: datas),
            //sizedbox que contem o dropdown menu de categorias
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
                hint: const Text('Selecione a categoria: '),
                onChanged: (String? v) {
                  setState(() {
                    opcao = v;
                  });
                },
                value: opcao,
              ),
            ),

            //linha que aparece os botoes de cancelar form e de nova transacao
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
