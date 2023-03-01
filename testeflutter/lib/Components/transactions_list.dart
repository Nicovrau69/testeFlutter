// ignore_for_file: sized_box_for_whitespace
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> transactions;

  const TransactionList(this.transactions, {super.key});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    //parte gráfica transações feitas
    return Container(
      height: 300, //tamanho do container onde tem a lista de transaçoes
      child: ListView.builder(
          itemCount: widget.transactions.length, //quantidade de itens na lista
          itemBuilder: (ctx, index) {
            final tr = widget.transactions[index];
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
                      'R\$ ${tr.value.toStringAsFixed(2)}',
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
                        tr.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        DateFormat('d MMM y  h:mm')
                            .format(tr.date), //mostra date em dia, mes e ano
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      TextButton(
                        child: const Text(
                          'Mais infos',
                          textAlign: TextAlign.end,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(tr.title),
                              alignment: Alignment.center,
                              content: Column(
                                children: [
                                  Text(
                                    'Valor: ${tr.value}',
                                    textAlign: TextAlign.start,
                                  ),
                                  Text('Observações: ${tr.observacao}',
                                      textAlign: TextAlign.start),
                                  Text('ID: ${tr.id}')
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {});
                    },
                    icon: Icon(Icons.delete),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                ],
              ),
            );
          }),
    );
  }
}
