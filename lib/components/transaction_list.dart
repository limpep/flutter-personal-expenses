import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function removeTransaction;

  const TransactionList({this.transaction, this.removeTransaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transaction.length == 0
          ? Column(
              children: <Widget>[
                Text(
                  'No transaction added yet',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    title: Text(
                      transaction[index].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed: () =>
                            removeTransaction(transaction[index].id)),
                    subtitle: Text(
                      DateFormat('dd-MM-yyyy')
                          .add_jm()
                          .format(transaction[index].date),
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text('\$${transaction[index].amount}'),
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: transaction.length,
            ),
    );
  }
}
