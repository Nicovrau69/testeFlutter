import 'dart:math';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:flutter/material.dart';

import '../models/category.dart';

//form que aparece ao clicar em adicionar previsao

class PrevisaoForm extends StatefulWidget {
  final void Function(double, DateTime, String) onSubmit;
  final List<Category> cat;
  const PrevisaoForm(this.onSubmit, this.cat, {super.key});
  @override
  State<PrevisaoForm> createState() => _PrevisaoFormState();
}

class _PrevisaoFormState extends State<PrevisaoForm> {
  final valorController = TextEditingController();
  DateTime data = DateTime.now();
  String? opcao;

  submitForm() {
    final valor =
        double.tryParse(valorController.text) ?? Random().nextDouble() * 300;
    final date = data;
    final categoria = opcao;
    widget.onSubmit(valor, date, categoria!);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              controller: valorController,
              onSubmitted: (_) => submitForm(),
              decoration: const InputDecoration(labelText: 'Valor'),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(
                width: 200,
                child: DropdownButton(
                  isExpanded: true,
                  items: widget.cat.map((e) {
                    return DropdownMenuItem(
                        value: e.title, child: Text(e.title));
                  }).toList(),
                  hint: const Text("Selecione a categoria: "),
                  onChanged: (String? v) {
                    setState(() {
                      opcao = v;
                    });
                  },
                )),
            IconButton(
                onPressed: () {
                  showMonthPicker(context: context, initialDate: DateTime.now())
                      .then((value) {
                    if (value != null) {
                      setState(() {
                        data = value;
                      });
                    }
                  });
                },
                icon: const Icon(
                  Icons.calendar_month,
                )),
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancelar')),
                TextButton(
                    onPressed: () {
                      submitForm();
                      Navigator.pop(context);
                    },
                    child: const Text('Adicionar'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
