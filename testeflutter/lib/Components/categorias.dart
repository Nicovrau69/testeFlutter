// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../providers/categorias_providers.dart';
import './form_category.dart';
import '../models/category.dart';

//Cadastro de categorias
class Categorias extends ConsumerStatefulWidget {
  const Categorias({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return CategoriasState();
  }
}

//Lista de categorias
class CategoriasState extends ConsumerState<Categorias> {
  final DropValue = ValueNotifier('');

  List<Category> category = [
    Category(
      id: 'C1',
      title: 'Lazer',
    ),
    Category(
      id: 'C2',
      title: 'Comida',
    ),
  ];

  //adiciona a categoria
  addCategory(String ide, String title) async {
    final newCategory = Category(
      id: ide,
      title: title,
    );
    final box = Hive.box<Category>('category');
    await box.add(newCategory);
    box.values.forEach((element) {
      print(element.id);
    });
    ref.invalidate(categoriasProvider);
    Navigator.of(context).pop(); //fecha teclado após clicar em adicionar
  }

  //abre o form do cadastro de categoria
  _openCategoryFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return FormCategory(
          (p0, p1) async => await addCategory(p0, p1),
        );
      },
    );
  }

  final TextController = TextEditingController();
  int? categoriaIndex;
  IconData buttonIcon = Icons.add;

  @override
  Widget build(BuildContext context) {
    //mostra lista das categorias
    return Scaffold(
      appBar: AppBar(
          title: const Text('Categorias')), //titulo que aparece na app bar
      body: SizedBox(
        height: 750, // tamanho do container aonde tem a lista de categorias
        child: Consumer(builder: (context, teste, _) {
          return teste.watch(categoriasProvider).when(
                data: (data) {
                  return ListView.builder(
                    itemCount: data.length, //pega o tamanho da lista
                    itemBuilder: (ctx, index) {
                      return Card(
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                'ID: ${data[index].id}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.cyan,
                                ),
                              ),
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    data[index].title,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]),
                            IconButton(
                                onPressed: () {
                                  //data[index].;
                                  //setState(() {});
                                },
                                icon: const Icon(Icons.delete)),
                            IconButton(
                                onPressed: () {}, icon: const Icon(Icons.edit)),
                          ],
                        ),
                      );
                    },
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (error, stackTrace) => Text(error.toString()),
              );
        }),
      ),
      //botão para mostrar o form de cadastro das categorias
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            _openCategoryFormModal(context);
            setState(() {});
          }),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat, //localização do botão
    );
  }
}
