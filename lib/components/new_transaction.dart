import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction({this.addTransaction});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void onSubmit() {
    final enteredTitle = titleController.text;
    var enteredAmount = 0.0;
    if (amountController.text.isNotEmpty) {
      enteredAmount = double.parse(amountController.text);
    }

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    widget.addTransaction(enteredTitle, enteredAmount);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(labelText: 'Title'),
            controller: titleController,
            onSubmitted: (_) => onSubmit(),
          ),
          TextField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(labelText: 'Amount'),
            controller: amountController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onSubmitted: (_) => onSubmit(),
          ),
          FlatButton(
            onPressed: onSubmit,
            color: Colors.lightBlue,
            child: Text('Add Transaction'),
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
