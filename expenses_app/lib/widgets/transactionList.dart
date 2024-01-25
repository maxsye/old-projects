import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: <Widget>[
                Text('No transactions added yet',
                    style: Theme.of(context).textTheme.title),
                SizedBox(
                  height: 20,
                ), //gives some spacing
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView(
            children: <Widget>[
              for (var i = 0; i < transactions.length; i++)
                TransactionItem(
                  ValueKey(transactions[i].id),
                  transactions[i],
                  deleteTransaction,
                ),
            ],
          );
  }
}

//'..' tells Dart o go up one level, out of the folder
//To get the title of the transaction to be treated as a title in terms of font size
//and more we do Theme.of(context).textTheme.title
//child: Image.asset(
//  'assets/images/waiting.png',
//  fit: BoxFit.cover,
//),
//BoxFit.cover fits the image
//We pass the height parameter as 200 because the image's height is the parent's
//height (Column) and Column takes as much height as it can get
//So, we wrap the image in a Container and pass height as 200
//ListTile is a preconfigured and styled widget that fits well into lists
