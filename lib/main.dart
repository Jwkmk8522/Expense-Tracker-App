import 'package:expense_app/Models/transaction.dart';
import 'package:expense_app/Themes/dark_theme.dart';
import 'package:expense_app/Widgets.dart/chart.dart';
import 'package:expense_app/Widgets.dart/new_transaction.dart';
import 'package:expense_app/Widgets.dart/transactions_list.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense App',
      debugShowCheckedModeBanner: false,
      theme: customDarkTheme,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> transactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'Shoes',
    //   amount: 943434343434343434.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Clothes',
    //   amount: 1.203,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transaction> get _recentTransactions {
    return transactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addTransaction(String text, double amount, DateTime selectedDate) {
    final tx = Transaction(
        id: DateTime.now().toString(),
        title: text,
        amount: amount,
        date: selectedDate);
    setState(() {
      transactions.add(tx);
    });
  }

  void bottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return NewTransaction(tx: _addTransaction);
      },
    );
  }

  void deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((txw) => txw.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Expense App'),
        actions: [
          IconButton(
              onPressed: () {
                bottomSheet(context);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Chart(recentTransactions: _recentTransactions),
          const SizedBox(height: 10),
          TransactionsList(transactions, deleteTransaction),
          FloatingActionButton(
            onPressed: () => bottomSheet(context),
            child: const Icon(Icons.add),
          ),
        ]),
      ),
    );
  }
}
