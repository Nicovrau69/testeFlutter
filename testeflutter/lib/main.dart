// ignore_for_file: avoid_print
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:testeflutter/Components/form_transacoes.dart';
import 'package:testeflutter/Components/transactions_list.dart';
import 'package:testeflutter/models/category.dart';
import 'package:testeflutter/models/previsao.dart';
import 'package:testeflutter/providers/transactions_providers.dart';
import './models/transaction.dart';
import './Components/menu.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocuntDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocuntDirectory.path); //inicializa o hive
  Hive.registerAdapter(CategoryAdapter());
  var box = await Hive.openBox<Category>('category'); //abre a box de categorias
  Hive.registerAdapter(TransactionAdapter());
  var boxT =
      await Hive.openBox<Transaction>('transaction'); //abre o box de transações
  Hive.registerAdapter(PrevisaoAdapter());
  var boxe = await Hive.openBox<Previsao>('previsao');

  runApp(const ProviderScope(child: Financeiro()));
}

class Financeiro extends StatelessWidget {
  const Financeiro({super.key});

  //função para mostrar a homepage do aplicativo
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: GlobalKey(), //TODO mudar isso
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.cyan,
        secondaryHeaderColor: Colors.cyanAccent,
      ),
    );
  }
}

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return HomePageState();
  }
}

var cat = Hive.box<Category>('category');

class HomePageState extends ConsumerState<HomePage> {
  final caixa = Hive.box<Transaction>('transaction');

  //função de adição de transação
  addTransactions(
      String title, double value, String observacao, String categoria) async {
    final newTransaction = Transaction(
      id: Random().nextInt(99999).toString(), //gera um valor aleatório de id
      title: title,
      value: value,
      observacao: observacao,
      date: DateTime.now(), //seta horário atual como date
      catiguria: categoria,
    );
    await caixa.add(newTransaction);
    ref.invalidate(transactionProvider);
    if (context.mounted) {
      Navigator.of(context).pop(); //fecha o teclado após clicar em add
    }
  }

  //abre o form para adição de transação
  openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(
          (p0, p1, p2, p3) async => await addTransactions(p0, p1, p2, p3),
          cat.values.toList(),
        ); //retorna o form de transação
      },
    );
  }

  //design da homepage
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesas pessoais'),
        actions: [
          IconButton(
            //botão ao lado do menu para adição de transação
            icon: const Icon(Icons.add),
            onPressed: () => openTransactionFormModal(
                context), //quando apertado abrir form de transação
          )
        ],
      ),
      drawer: const MenuLateral(), //chama o menu lateral
      body: SingleChildScrollView(
        // possibilita a scrollagem da homepage
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TransactionList(),
          ],
        ),
      ),

      //botão inferior central para adicição de transação
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add), //muda o icone do botão para o de adição
        onPressed: () => openTransactionFormModal(
            context), //quando pressionado abrir form de transação
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .endFloat, //posição do botão (atualmente canto direito inferior)
    );
  }
}
