import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:testeflutter/models/previsao.dart';

class PrevisaoForm extends StatefulWidget {
  final void Function(double, DateTime) onSubmit;
  const PrevisaoForm(this.onSubmit, {super.key});

  @override
  State<PrevisaoForm> createState() => _PrevisaoFormState();
}

final caixa = Hive.box<Previsao>('previsao');

class _PrevisaoFormState extends State<PrevisaoForm> {
  final valueControler = TextEditingController();
  var mesAtual = DateTime.now().month;

  DateTime? opcao;

  _submitForm() {
    final value = double.tryParse(valueControler.text) ?? 0.0;
    final mes = opcao;

    if (value < 0) {
      return;
    }
    widget.onSubmit(value, mes!);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: <Widget>[
          TextField(
            controller: valueControler,
            onSubmitted: (_) => _submitForm(),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(labelText: 'Valor'),
          ),
          SizedBox(
              width: 200,
              child: IconButton(
                  onPressed: () {
                    showMonthPicker(
                      context: context,
                      initialDate: DateTime.now(),
                    ).then((date) {
                      if (date != null) {
                        setState(() {
                          opcao = date;
                        });
                      }
                    });
                  },
                  icon: const Icon(Icons.calendar_month))),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(color: Colors.cyan),
                  )),
              TextButton(
                  onPressed: () {
                    _submitForm;
                  },
                  child: const Text(
                    'Nova previsão',
                    style: TextStyle(color: Colors.cyan),
                  )),
            ],
          )
        ]),
      ),
    );
  }
}
