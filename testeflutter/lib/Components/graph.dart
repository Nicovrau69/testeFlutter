import 'package:flutter/material.dart';

class Graph extends StatelessWidget {
  const Graph({super.key});

  //tla dos graficos
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gráficos'), //titulo que aparece na appbar
      ),
    );
  }
}
