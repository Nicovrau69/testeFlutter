// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:testeflutter/components/form_transacoes.dart';
import 'package:testeflutter/models/category.dart';
import 'package:testeflutter/models/previsao.dart';
import 'package:testeflutter/providers/transactions_providers.dart';
import 'package:testeflutter/screens/main/controller/login_cubit.dart';
import 'package:testeflutter/screens/main/screens/login_screen.dart';
import 'package:testeflutter/theme/theme_constants.dart';
import 'package:testeflutter/theme/theme_manager.dart';
import './models/transaction.dart';
import 'components/form_filter.dart';
import 'components/menu.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'components/transactions_list.dart';

class MeuBloc extends Cubit {
  MeuBloc() : super(0);

  void incrementar() => emit(state + 1);
}

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
  var boxe = await Hive.openBox<Previsao>('previsao'); //abre o box de previsoes

  runApp(BlocProvider(
      create: (context) => LoginCubit(), child: const Financeiro()));
}

ThemeManager _themeManager = ThemeManager();

class Financeiro extends StatefulWidget {
  const Financeiro({super.key});

  @override
  State<Financeiro> createState() => _FinanceiroState();
}

class _FinanceiroState extends State<Financeiro> {
  //função para mostrar a homepage do aplicativo

  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    _themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener() {
    if (mounted) {
      {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, //tira a faixa de debug que fica no topo
      home: const LoginScreen(),
      theme: lighTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,
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

var caixatemp = Hive.box<Previsao>('previsao');
var cat = Hive.box<Category>('category');

openFilterFormModal(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (_) {
        return Consumer(builder: (context, ref, _) {
          return FilterDialog((p0, p1, p2) async {
            ref
                .read(transactionProvider2.notifier)
                .search(p0, p1, p2); //manda os dados para a pagina do provider
          });
        });
      });
}

class HomePageState extends ConsumerState<HomePage> {
  final caixa = Hive.box<Transaction>('transaction');
  final observacaoController = TextEditingController();
  DateTime dataSelecionada = DateTime.now();
  TextEditingController dateController = TextEditingController();
  String? valueDropdown;

  @override
  initState() {
    super.initState();
  }

  //função de adição de transação
  addTransactions(String title, double value, String observacao,
      String categoria, DateTime data) async {
    final newTransaction = Transaction(
      id: caixa.keys.length.toString(), //gera um valor aleatório de id
      title: title,
      value: value,
      observacao: observacao,
      date: data,
      catiguria: categoria,
    );
    await caixa.add(newTransaction);
    ref.invalidate(transactionProvider2);
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
          (p0, p1, p2, p3, p4) async =>
              await addTransactions(p0, p1, p2, p3, p4),
          cat.values.toList(),
        ); //retorna o form de transação
      },
    );
  }

  final boxes = Hive.box<Previsao>('previsao');
  //design da homepage
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesas pessoais'),
        /*actions: [
          IconButton(
            //botão ao lado do menu para adição de transação
            icon: const Icon(Icons.add),
            onPressed: () => openTransactionFormModal(
                context), //quando apertado abrir form de transação
          )
        ],*/
        actions: [
          Switch(
              //switch que fica no canto para mudar o tema de claro para escuro e vice versa
              value: _themeManager.themeMode == ThemeMode.dark,
              activeColor: Colors.amber,
              activeTrackColor: Colors.blue,
              onChanged: (newValue) {
                setState(() {
                  _themeManager.toggleTheme(newValue);
                });
              })
        ],
      ),
      drawer: const MenuLateral(), //chama o menu lateral
      body: SingleChildScrollView(
        // possibilita a scrollagem da homepage
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton(
                onPressed: () => caixatemp.clear(),
                // openFilterFormModal(context),
                child: const Text(
                  'Filtros',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.cyan),
                )),
            const TransactionList(),
          ],
        ),
      ),
      //botão inferior central para adicição de transação
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add), //muda o icone do botão para o de adição
        onPressed: () {
          caixatemp.clear();
          openTransactionFormModal(context);
        }, //quando pressionado abrir form de transação
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .endFloat, //posição do botão (atualmente canto direito inferior)
    );
  }
}
