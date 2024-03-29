// ignore_for_file: sized_box_for_whitespace, avoid_print, prefer_is_empty
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:random_string_generator/random_string_generator.dart';
import 'package:testeflutter/main.dart';
import '../models/category.dart';
import '../models/transaction.dart';
import '../providers/transactions_providers.dart';
import './form_transacoes.dart';

class TransactionList extends ConsumerStatefulWidget {
  const TransactionList({super.key});

  @override
  ConsumerState<TransactionList> createState() {
    return TransactionListState();
  }
}

var box = Hive.box<Category>('category');
var caixa = Hive.box<Transaction>('transaction');

class TransactionListState extends ConsumerState<TransactionList> {
  DateTimeRange? selectedDate;
  String? stringObservacao;
  String? valueDropdown;

  openTransactionFormModal(BuildContext context, String id) {
    final existingTrans = caixa.values
        .toList()
        .where((element) => element.id == id)
        .toList()
        .cast<Transaction>();
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(
            (p0, p1, p2, p3, p4) async =>
                await editTransaction(existingTrans, p0, p1, p2, p3),
            cat.values.toList()); //retorna o form de transação
      },
    );
  }

  //mostra texto com o total de transações e o valor total das somas delas
  mostraTextoTransacoes() {
    double totalSum = 0;
    final list = ref.watch(transactionProvider2);
    for (double value in list.map((e) => e.value)) {
      totalSum += value;
    }
    if (list.length == 0) {
      //texto que aparece quando não possui nenhuma transação cadastrada
      return const Text(
        'Não há transações cadastradas!',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      );
    } else if (list.length == 1) {
      //texto que aparece quando possui apenas uma transação cadastrada
      return Text(
          '${list.length} transação foi encontrada, com valor de R\$$totalSum',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center);
    } else if (list.length > 0) {
      //texto que aparece quando há mais de uma transação cadastrada
      return Text(
        '${list.length} transações foram encontradas, totalizando $totalSum',
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      );
    }
    ref.invalidate(transactionProvider2);
  }

  editTransaction(List<Transaction> teste, String title, double value,
      String observacao, String catiguria) {
    teste[0].title = title;
    teste[0].observacao = observacao;
    teste[0].value = value;
    // teste[0].catiguria = catiguria;
    teste[0].save();
    ref.invalidate(transactionProvider2);
    Navigator.pop(context);
  }

  //gera um nome aleatorio de 20 caracteres
  var generator = RandomStringGenerator(fixedLength: 20, hasSymbols: false);

  //transforma lista de transações em csv
  transformInCSV(listaCSV) async {
    List<List<String>> data = listaCSV;

    String csvData = const ListToCsvConverter().convert(data);
    final String directory = (await getApplicationSupportDirectory())
        .path; //pega path do arquivo onde a aplicação está
    final path =
        '$directory\\csv-${generator.generate()}.csv'; //cria um arquivo .csv com nome aleatório no diretorio informado
    print(path); //mostra aonde o arquivo foi colocado
    final File file = File(path);
    await file.writeAsString(csvData);

    return file;
  }

  @override
  Widget build(BuildContext context) {
    //parte gráfica transações feitas
    final listaCsv = <List<String>>[];
    listaCsv.add([
      'data',
      'valor',
      'categoria',
      'observação',
    ]);
    return Container(
      height:
          450, //tamanho do container que a lista de transações está inserida
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              height: 200,
              child: Consumer(
                builder: (context, ref, _) {
                  final list = ref.watch(transactionProvider2);
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final item = list[index];
                      listaCsv.add([
                        item.date.toString(),
                        item.value.toString(),
                        item.catiguria,
                        item.observacao,
                      ]);
                      return Card(
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                'R\$ ${item.value.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.cyan,
                                ),
                              ),
                            ),
                            //parte gráfica cadastro de transação
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  item.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  DateFormat('d MMM y  h:mm').format(item
                                      .date), //mostra date em dia, mes e ano
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                Text('Categoria: ${item.catiguria}'),
                                TextButton(
                                  child: const Text(
                                    'Mais infos',
                                    style: TextStyle(color: Colors.cyan),
                                    textAlign: TextAlign.end,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            title:
                                                const Text('Mais informações'),
                                            alignment: Alignment.center,
                                            content: SizedBox(
                                              width: double.infinity,
                                              height: 100,
                                              child: Column(
                                                children: [
                                                  Text('Valor: ${item.value}'),
                                                  Text(
                                                      'Observação: ${item.observacao}'),
                                                  Text('ID: ${item.id}'),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                item.delete();
                                ref.invalidate(transactionProvider2);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                openTransactionFormModal(context, item.id);
                              },
                              icon: const Icon(Icons.edit),
                              color: Colors.green,
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: list.length,
                  );
                },
              ),
            ),
          ),
          mostraTextoTransacoes(),
          IconButton(
            alignment: Alignment.bottomLeft,
            onPressed: (() async {
              await transformInCSV(listaCsv);
            }),
            icon: const Icon(Icons.import_export),
          )
        ],
      ),
    );
  }
}
