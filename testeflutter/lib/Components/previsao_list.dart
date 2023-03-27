import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:testeflutter/components/form_previsao.dart';
import 'package:testeflutter/models/previsao.dart';

import '../providers/previsao_provider.dart';

class PrevisaoList extends ConsumerStatefulWidget {
  const PrevisaoList({super.key});

  @override
  ConsumerState<PrevisaoList> createState() {
    return _PrevisaoListState();
  }
}

//mostra o texto abaixo da lista de previsoes
mostraTexto() {
  if (caixa.length == 0) {
    return const Text(
      'Não há previsoes cadastradas',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  } else {
    return const Text('');
  }
}

final box = Hive.box<Previsao>('previsao');

class _PrevisaoListState extends ConsumerState<PrevisaoList> {
  @override
  //constroe a lista de previsoes
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450, //tamanho do container
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              height: 200, //tamanho da sizedBox
              child: Consumer(
                builder: (context, ref, _) {
                  return ref.watch(previsaoProvider).when(
                        data: (data) {
                          return ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (ctx, index) {
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
                                      )),
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        'R\$${data[index].valor}', //mostra o valor da previsao no indice index
                                        style: const TextStyle(
                                            fontWeight:
                                                FontWeight.bold, //negrito
                                            fontSize: 20, //tamanho da fonte
                                            color: Colors.cyan),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          DateFormat('MMM y')
                                              .format(data[index].data)
                                              .toString(), //mostra a data no formato MMM y da previsao no indice index
                                          style: const TextStyle(
                                              fontSize: 16, //tamanho da fonte
                                              fontWeight:
                                                  FontWeight.bold //negrito
                                              ),
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          data[index].delete();
                                          ref.invalidate(previsaoProvider);
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.edit),
                                      color: Colors.green,
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        error: (error, stackTrace) => Text(error.toString()),
                        loading: () => const CircularProgressIndicator(),
                      );
                },
              ),
            ),
          ),
          mostraTexto()
        ],
      ),
    );
  }
}
