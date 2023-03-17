import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:testeflutter/models/category.dart';

//Form de cadastro de categorias

class FormCategory extends StatefulWidget {
  final Future<void> Function(String, String) onSubmit;

  const FormCategory(this.onSubmit, {super.key});

  @override
  State<FormCategory> createState() => _FormCategoryState();
}

class _FormCategoryState extends State<FormCategory> {
  final box = Hive.box<Category>('category');
  final titleController = TextEditingController();
  final idController = TextEditingController();

  //envia formulario das categorias
  _submitForm() async {
    final titulo = titleController.text;
    final id = idController.text;

    if (titulo.isEmpty || id.isEmpty) {
      //obriga o usuário a adicionar os dois componentes
      return;
    }
    await widget.onSubmit(titulo, id);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            //texto que aparece no campo para preencher o titulo
            TextField(
              controller: idController,
              onSubmitted: (_) async => await _submitForm(),
              decoration: const InputDecoration(
                labelText: 'Titulo',
              ),
            ),
            //texto que aparece no campo para preencher o id
            TextField(
              controller: titleController,
              onSubmitted: (_) => _submitForm(),
              decoration: const InputDecoration(
                labelText: 'Id',
              ),
            ),
            //botão que aparece para adicionar
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancelar',
                        style: TextStyle(color: Colors.cyan))),
                TextButton(
                    onPressed: _submitForm,
                    child: const Text('Nova categoria',
                        style: TextStyle(color: Colors.cyan))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
