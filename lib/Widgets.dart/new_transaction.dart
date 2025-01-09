import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  NewTransaction({super.key, required this.tx});
  final Function tx;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final textController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _selectedDate;

  void _addTransaction(BuildContext context) {
    if (amountController.text.isEmpty) {
      return;
    }
    final enteredText = textController.text;

    final enteredAmount = double.parse(amountController.text);

    if (enteredText.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.tx(enteredText, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  Future<void> presentDatePicker() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: textController,
              onSubmitted: (_) => _addTransaction(context),
              decoration: const InputDecoration(
                labelText: 'Text',
              ),
            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _addTransaction(context),
              decoration: const InputDecoration(
                labelText: 'Amount',
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(_selectedDate == null
                    ? 'No Date Chosen!'
                    : 'Date : ${DateFormat.yMMMd().format(_selectedDate!)},'),
                TextButton(
                  onPressed: presentDatePicker,
                  child: Text(
                    'Choose Date',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () => _addTransaction(context),
              child: const Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
