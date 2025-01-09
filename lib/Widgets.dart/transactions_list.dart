import 'package:expense_app/Models/transaction.dart';
import 'package:expense_app/Utilities/show_delete_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTran;

  TransactionsList(this.transaction, this.deleteTran);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: transaction.isEmpty
          ? Column(
              children: [
                Text(
                  'No transactions to show',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 40),
                SizedBox(
                    height: 200,
                    child: Image.asset('assets/images/waiting.png'))
              ],
            )
          : ListView.builder(
              itemCount: transaction.length,
              itemBuilder: (context, index) {
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: ListTile(
                    leading: Container(
                      width: 100,
                      height: 50,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).colorScheme.onSecondary,
                            width: 4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: FittedBox(
                        child: Text(
                            '\$${transaction[index].amount.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.bodyLarge),
                      ),
                    ),
                    title: Text(
                      transaction[index].title,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    subtitle: Text(
                        // tx.date.toString(),
                        DateFormat.yMMMMd().format(transaction[index].date)),
                    trailing: IconButton(
                      onPressed: () async {
                        final delete = await showdeletedialog(context);
                        if (delete) {
                          deleteTran(transaction[index].id);
                        }
                      },
                      icon: const Icon(Icons.delete),
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
