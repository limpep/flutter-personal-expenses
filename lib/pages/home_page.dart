import 'package:flutter/material.dart';
import 'package:personalexpensesapp/components/chart.dart';
import 'package:personalexpensesapp/components/new_transaction.dart';
import 'package:personalexpensesapp/components/transaction_list.dart';

import '../model/transaction.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _userTransactions = [
//    Transaction(
//        id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
//    Transaction(
//        id: 't2',
//        title: 'Weekly Groceries',
//        amount: 16.53,
//        date: DateTime.now()),
  ];

  List<Transaction> get _recentTransaction {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime txDateTime) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: txDateTime,
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.00),
                topRight: Radius.circular(10.0))),
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(addTransaction: _addNewTransaction),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Chart(
              recentTransactions: _recentTransaction,
            ),
            TransactionList(
                transaction: _userTransactions,
                removeTransaction: _deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
