import 'package:flutter/material.dart';
import 'package:personal_expenses_app/chart.dart';
import './NewTransaction.dart';
import './transactions.dart';
import './txlist.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  final List<Transactions> transaction = [];

  List<Transactions> get _recentTransactions {
    return transaction.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void AddNewTransaction(
      String txtitle, double txamount, DateTime selectedDate) {
    final newtx = Transactions(
        title: txtitle,
        amount: txamount,
        id: DateTime.now().toString(),
        date: selectedDate);
    setState(() {
      transaction.add(newtx);
    });
  }

  void _deletetransactions(String id) {
    setState(() {
      return transaction.removeWhere((element) => element.id == id);
    });
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bctx) {
          return NewTransaction(AddNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      actions: <Widget>[
        IconButton(
            onPressed: () => startAddNewTransaction(context),
            icon: Icon(Icons.add)),
      ],
      title: Text('Personal Expenses App'),
    );
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: (Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                  height: (MediaQuery.of(context).size.height -
                          appbar.preferredSize.height) *
                      0.4,
                  child: Chart(_recentTransactions)),
              Container(
                height: (MediaQuery.of(context).size.height -
                        appbar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.6,
                child: txlist(
                  transactionlist: transaction,
                  deleteTx: _deletetransactions,
                ),
              )
            ])),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          startAddNewTransaction(context);
        },
      ),
    );
  }
}
