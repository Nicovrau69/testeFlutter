import 'package:testeflutter/Components/graph.dart';
import 'package:testeflutter/Components/previsao_gastos.dart';
import './categorias.dart';
import 'package:flutter/material.dart';

//Menu que aparece lateralmente

class MenuLateral extends StatelessWidget {
  const MenuLateral({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(
            height: 120, //tamanho do header do menu
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.cyan, //cor do header do menu
              ),
              child: Text(
                'Menu', //texto do header do menu
              ),
            ),
          ),
          //Menu grafico de pizza
          ListTile(
            //lista de itens que aparecem no menu
            leading: const Icon(Icons.pie_chart),
            title: const Text('Gráfico de pizza'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const Graph())); //muda a tela para a graph
            },
          ),
          //Menu categorias
          ListTile(
            leading: const Icon(Icons.account_tree),
            title: const Text('Categorias'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const Categorias())); //muda de tela para a de categorias
            },
          ),
          ListTile(
            leading: const Icon(Icons.savings),
            title: const Text('Previsão de gastos'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PrevisaoGastos(),
                  ));
            },
          ),
          //Menu informações do aplicativo
          const SizedBox(
            height: 80, //tamanho do popup das informações do app
            child: AboutListTile(
              //informações sobre o aplicativo
              icon: Icon(Icons.info),
              applicationName: 'Gerenciador financeiro',
              applicationVersion: '0.0.7', //versão do app
              applicationLegalese: 'Todos direitos reservados a Datachamp',
              //informações sobre o aplicativo
              child: Text('Sobre o app'),
            ),
          ),
        ],
      ),
    );
  }
}
