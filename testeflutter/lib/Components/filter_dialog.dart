import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:testeflutter/models/category.dart';

//dialogo de filtro

class FilterDialog extends ConsumerStatefulWidget {
  final void Function(String?, DateTimeRange?, String?) onSubmit;
  const FilterDialog(this.onSubmit, {super.key});

  @override
  ConsumerState<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends ConsumerState<FilterDialog> {
  var observacaoController = TextEditingController();
  DateTimeRange? selecionado;
  String? valueDropdown;

  final box = Hive.box<Category>('category');

  //mostrar o calendario de range time
  void show() async {
    final DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2021, 1, 1),
      lastDate: DateTime(2029, 1, 1),
      currentDate: DateTime.now(),
      saveText: 'Salvar',
    );
    selecionado =
        result; //pega o valor selecionado e passa para a variavel selecionado
  }

  submitForm() {
    final observacaos = observacaoController.text;
    final selecionados = selecionado;
    final drop = valueDropdown;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              controller: observacaoController,
              decoration:
                  const InputDecoration(labelText: 'Pesquisar por observação'),
            ),
            DropdownButton(
              isExpanded: true,
              items: box.values.map((e) {
                return DropdownMenuItem(value: e.title, child: Text(e.title));
              }).toList(),
              onChanged: (String? v) {
                setState(() {
                  valueDropdown = v;
                });
              },
              value: valueDropdown,
            ),
            IconButton(onPressed: show, icon: const Icon(Icons.calendar_month)),

            //linha que contem os botoes de limpar filtros, cancelar e pesquisar
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        //transforma todos os valores em null
                        valueDropdown = null;
                        observacaoController = TextEditingController();
                        selecionado = null;
                      });
                    },
                    child: const Text('Limpar filtros')),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancelar')),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Pesquisar'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
