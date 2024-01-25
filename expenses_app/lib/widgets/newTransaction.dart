import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './adaptive_flat_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() {
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  @override
  void initState() {
    //print('initState');
    super.initState();
  }

  @override
  void didUpdateWidget(NewTransaction oldWidget) {
    //print('didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    //print('dispose');
    super.dispose();
  }

  void _submitTransaction() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return; //if any of these statements are true, return stops the function
      //execution
    }

    widget.addNewTransaction(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019, 6, 1),
      lastDate: DateTime(2020, 6, 1),
    ).then((inputData) {
      if (inputData == null) {
        return;
      }
      setState(
        () {
          _selectedDate = inputData;
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                controller: _titleController,
                onSubmitted: (_) => _submitTransaction(),
                decoration: InputDecoration(
                  labelText: 'Title', //tell us what should be in the text field
                ),
              ),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitTransaction(),
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Date Chosen'
                            : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                      ),
                    ),
                    AdaptiveFlatButton(
                      'Choose Date',
                      _showDatePicker,
                    ),
                  ],
                ),
                height: 70,
              ),
              RaisedButton(
                child: Text('Add Transaction'),
                onPressed: _submitTransaction,
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//_addNewTransaction is a private method in a private class in a different file
//So, you can't access it directly
//We must pass a pointer

//To convert titleController to String, since addNewTransaction() expects a String
//for title, we do titleController.Text
//To convert amountController to double, since addNewTransaction() expects a String
//for amount, we do double.parse(amountController.text), but be careful, if it's not a double
//there will an error and app will stop running

//To pass onSubmitted parameter in the TextField for title, we have to do something special
//A function that is void and has no parameters can't be a function that is void and has a parameter that is a
//String, textField automatically passes us a String for convenience
//So, we take the String by doing (_) and it is best practice to name a parameter that you won't use as "_"

//We (_) => submitTransaction() because we must pass an actual function
//However, if if you just need to pass the pointer, do onPressed: submitTransaction

//To prevent the text fields from being lost when clicking into something else, we change NewTransaction
//to a StatefulWidget
//Internally, there's one important change, addTransaction function is still a property
//To receive some data for outside, we need to accept it through the constructor of the widget
//The problem is that I want to use this function from inside the state(_NewTransactionState) object and not
//the widget(NewTransaction), these are two different classes
//Flutter establishes the connection and gives us a special property inside the state class, the refactoring
//adds this automatically
//widget.addNewTransaction(
//      titleController.text,
//      double.parse(amountController.text),
//    );
//By using widget.etc, we can access the class's properties even though we are in a different class
//After the user submits their data, we want to close to modal sheet
//We use Navigator.of(context).pop(), it closes the top-most screen

//showDatePicker function is provided by Flutter just like showModalBottomSheet
//It returns a variable of type Future<DateTime>
//Futures are classes that allow us to create objects in the future
//,then() allows us to provide a function once the Future resolves to a value
