import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Transaction.dart';

class MyApp extends StatefulWidget {
  // StatefulWidget has internal "state"
  String name;
  int age;

  MyApp({required this.name, required this.age});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement build
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _contentController = TextEditingController();
  final _amountController = TextEditingController();

  // defines state
  // String? _content;
  // double? _amount;

  Transaction _transaction = Transaction(content: '', amount: 0.0);
  List<Transaction> _transactions = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    DateTime now = new DateTime.now();
    DateTime someDate = new DateTime(2000, 5, 2);
    return MaterialApp(
        title: "This is a StatefulWidget",
        home: Scaffold(
            key: _scaffoldKey,
            body: SafeArea(
              minimum: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  TextField(
                      decoration: InputDecoration(labelText: 'Content'),
                      controller: _contentController,
                      onChanged: (text) {
                        setState(() {
                          _transaction.content = text;
                        });
                      }),
                  TextField(
                      decoration: InputDecoration(labelText: 'Amount(money)'),
                      controller: _amountController,
                      onChanged: (text) {
                        setState(() {
                          _transaction.amount = double.tryParse(text) ?? 0;
                        });
                      }),
                  FlatButton(
                    child: Text('Insert Transaction'),
                    color: Colors.pinkAccent,
                    textColor: Colors.white,
                    onPressed: () {
                      // print('You pressed this button');
                      // Display to UI?
                      setState(() {
                        _transactions.add(_transaction);
                        _contentController.text = '';
                        _amountController.text = '';
                      });
                      _scaffoldKey.currentState?.showSnackBar(SnackBar(
                        content:
                            Text("Content = ${_transaction.content}, Amount"),
                        duration: Duration(seconds: 3),
                      ));
                    },
                  ),
                ],
              ),
            )));
  }
}
