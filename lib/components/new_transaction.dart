import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction({this.addTransaction});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _onSubmit() {
    if (_amountController.text.isEmpty) {
      return;
    }

    final enteredTitle = _titleController.text;
    var enteredAmount = 0.0;
    final enteredDate = _selectedDate;

    if (_amountController.text.isNotEmpty) {
      enteredAmount = double.parse(_amountController.text);
    }

    if (enteredTitle.isEmpty || enteredAmount <= 0 || enteredDate == null) {
      return;
    }

    widget.addTransaction(enteredTitle, enteredAmount, enteredDate);
    Navigator.pop(context);
  }

  void _presentDatePicker() async {
    var picker = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime.now());

    if (picker == null) {
      return;
    }
    setState(() {
      _selectedDate = picker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _onSubmit(),
            ),
            TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _onSubmit(),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No Date Chosen!'
                          : DateFormat('dd-MM-yyyy')
                              .add_jm()
                              .format(_selectedDate),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  FlatButton(
                    textColor: Colors.lightBlueAccent,
                    onPressed: _presentDatePicker,
                    child: Text('Choose a date'),
                  )
                ],
              ),
            ),
            FlatButton(
              onPressed: _onSubmit,
              color: Colors.lightBlue,
              child: Text('Add Transaction'),
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
