import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:testeflutter/Components/chart.dart';
import 'package:testeflutter/Components/form_transacoes.dart';
import 'package:testeflutter/Components/transactions_list.dart';
import 'package:testeflutter/models/category.dart';
import './models/transaction.dart';
import './Components/menu.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocuntDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocuntDirectory.path); //inicializa o hive
  Hive.registerAdapter(CategoryAdapter());
  var box = await Hive.openBox<Category>('category'); //abre a box

  runApp(const ProviderScope(child: Financeiro()));
}

class Financeiro extends StatelessWidget {
  const Financeiro({super.key});

  //mostra a homepage do aplicativo
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.cyan,
        secondaryHeaderColor: Colors.cyanAccent,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// dados teste
class _HomePageState extends State<HomePage> {
  final List<Transaction> transactions = [
    Transaction(
        id: 'T1',
        title: 'Novo tenis de corrida',
        value: 310.76,
        observacao: 'Tenis comprado para a maratona',
        date: DateTime.now().subtract(Duration(days: 20))),
    Transaction(
      id: 'T2',
      title: 'Conta de luz',
      value: 211.30,
      observacao: 'Conta de luz referente ao mes de Janeiro',
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
  ];
  //transações dos ultimos 7 dias
  List<Transaction> get _recentTransactions {
    return transactions.where((tr) {
      return tr.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  //função de adição de transação
  addTransactions(String title, double value, String observacao) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(), //gera um valor aleatório de id
      title: title,
      value: value,
      observacao: observacao,
      date: DateTime.now(), //seta horário atual como date
    );

    setState(() {
      (transactions.add(newTransaction)); //mostra a lista nova na homepage
    });

    Navigator.of(context).pop(); //fecha o teclado após clicar em add
  }

  //abre o form para adição de transação
  openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(addTransactions); //retorna o form de transação
      },
    );
  }

  //design da homepage
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas pessoais'),
        actions: [
          IconButton(
            //botão ao lado do menu para adição de transação
            icon: Icon(Icons.add),
            onPressed: () => openTransactionFormModal(
                context), //quando apertado abrir form de transação
          )
        ],
      ),
      drawer: MenuLateral(), //chama o menu lateral
      body: SingleChildScrollView(
        // possibilita a scrollagem da homepage
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTransactions),
            TransactionList(transactions),
          ],
        ),
      ),
      //botão inferior central para adicição de transação
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add), //muda o icone do botão para o de adição
        onPressed: () => openTransactionFormModal(
            context), //quando pressionado abrir form de transação
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat, //posição do botão
    );
  }
}
