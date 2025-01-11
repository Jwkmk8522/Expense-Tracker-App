import 'package:expense_app/Models/transaction.dart';
import 'package:expense_app/Utilities/show_delete_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    super.key,
    required this.transaction,
    required this.deleteTran,
  });

  final Transaction transaction;
  final Function deleteTran;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: ListTile(
        leading: Container(
          width: 100,
          height: 50,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).colorScheme.onSecondary, width: 4),
            borderRadius: BorderRadius.circular(10),
          ),
          child: FittedBox(
            child: Text('\$${transaction.amount.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.bodyLarge),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        subtitle: Text(
            // tx.date.toString(),
            DateFormat.yMMMMd().format(transaction.date)),
        trailing: MediaQuery.of(context).size.width > 450
            ? TextButton.icon(
                icon: const Icon(Icons.delete),
                label: const Text("Delete"),
                // Applies to ripple effect and text/icon color
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.error,
                ),
                onPressed: () async {
                  final delete = await showdeletedialog(context);
                  if (delete) {
                    deleteTran(transaction.id);
                  }
                },
              )
            : IconButton(
                onPressed: () async {
                  final delete = await showdeletedialog(context);
                  if (delete) {
                    deleteTran(transaction.id);
                  }
                },
                icon: const Icon(Icons.delete),
                color: Theme.of(context).colorScheme.error,
              ),
      ),
    );
  }
}
