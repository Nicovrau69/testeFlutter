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
  var categoryFormKey = GlobalKey<_FormCategoryState>();
  //envia formulario das categorias
  _submitForm() async {
    final id = box.keys.length.toString();
    final title = titleController.text;

    if (title.isEmpty) {
      //obriga o usuário a adicionar os dois componentes
      return;
    }
    await widget.onSubmit(id, title);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: categoryFormKey,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            //texto que aparece no campo para preencher o titulo
            TextFormField(
              controller: titleController,
              onFieldSubmitted: (_) async => await _submitForm(),
              decoration: const InputDecoration(
                labelText: 'Titulo',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Informe o titulo';
                }
              },
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
