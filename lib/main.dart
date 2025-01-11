import 'package:expense_app/Models/transaction.dart';
import 'package:expense_app/Themes/dark_theme.dart';
import 'package:expense_app/Widgets.dart/chart.dart';
import 'package:expense_app/Widgets.dart/new_transaction.dart';
import 'package:expense_app/Widgets.dart/transactions_list.dart';
import 'package:flutter/material.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //   [
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown,
  //   ],
  // );

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
  bool _showChart = false;

  final List<Transaction> transactions = [
    Transaction(
      id: 't1',
      title: 'Shoes',
      amount: 943434343434343434.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't1',
      title: 'Shoes',
      amount: 943434343434343434.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't1',
      title: 'Shoes',
      amount: 943434343434343434.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't1',
      title: 'Shoes',
      amount: 943434343434343434.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Clothes',
      amount: 1.203,
      date: DateTime.now(),
    ),
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

  void deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((txw) => txw.id == id);
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

  List<Widget> _buildLandScapeContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txList) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Show Chart"),
          Switch(
            value: _showChart,
            onChanged: (val) {
              return setState(() {
                _showChart = val;
              });
            },
          ),
        ],
      ),
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: Chart(recentTransactions: _recentTransactions),
            )
          : txList
    ];
  }

  List<Widget> _buildPortraitContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txList) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.32,
        child: Chart(recentTransactions: _recentTransactions),
      ),
      txList
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLanscapeMode = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      centerTitle: true,
      title: const Text('Expense App'),
      actions: [
        IconButton(
            onPressed: () {
              bottomSheet(context);
            },
            icon: const Icon(Icons.add))
      ],
    );

    final txList = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.68,
      child: TransactionsList(transactions, deleteTransaction),
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (isLanscapeMode)
              ..._buildLandScapeContent(mediaQuery, appBar, txList),
            if (!isLanscapeMode)
              ..._buildPortraitContent(mediaQuery, appBar, txList),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => bottomSheet(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
