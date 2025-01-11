import 'package:expense_app/Models/transaction.dart';
import 'package:expense_app/Widgets.dart/transaction_item.dart';

import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTran;

  TransactionsList(this.transaction, this.deleteTran);

  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  Text(
                    'No transactions to show',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  SizedBox(height: constraints.maxHeight * 0.1),
                  SizedBox(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset('assets/images/waiting.png'))
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: transaction.length,
            itemBuilder: (context, index) {
              return TransactionItem(
                  transaction: transaction[index], deleteTran: deleteTran);
            },
          );
  }
}
