import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../providers/previsao_provider.dart';

//lista de previsoes

class PrevisaoList extends ConsumerStatefulWidget {
  const PrevisaoList({super.key});

  @override
  ConsumerState<PrevisaoList> createState() => _PrevisaoListState();
}

class _PrevisaoListState extends ConsumerState<PrevisaoList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          Expanded(
              child: SizedBox(
            height: 200,
            child: Consumer(builder: (context, ref, _) {
              final list = ref.watch(previsaoProvider);
              return ref.watch(previsaoProvider).when(
                    data: (data) {
                      return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (ctx, index) {
                            return Card(
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                      color: Theme.of(context).primaryColor,
                                      width: 2,
                                    )),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        DateFormat.MMMM()
                                            .format(data[index].data),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                          'Valor: ${data[index].valor.toString()}'),
                                      Text(
                                          'Categoria: ${data[index].categoria}')
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      data[index].delete();
                                      ref.invalidate(previsaoProvider);
                                    },
                                    icon: const Icon(Icons.delete),
                                    color: Colors.red,
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.edit),
                                    color: Colors.green,
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    error: (error, stackTrace) => Text(error.toString()),
                    loading: () => const CircularProgressIndicator(),
                  );
            }),
          ))
        ],
      ),
    );
  }
}
