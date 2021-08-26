import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addtx;

  NewTransaction(this.addtx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titlecontroller = TextEditingController();

  final amountcontroller = TextEditingController();

  DateTime selectedDate = DateTime.now();

  void submitdata() {
    final enteredtitle = titlecontroller.text;
    final enteredamount = double.parse(amountcontroller.text);

    if (enteredtitle.isEmpty || enteredamount <= 0 || selectedDate == null) {
      return;
    }
    widget.addtx(titlecontroller.text, double.parse(amountcontroller.text),
        selectedDate);

    Navigator.of(context).pop();
  }

  void presentdatepicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime(2022))
        .then((pickeddate) {
      if (pickeddate == null) {
        return;
      }
      setState(() {
        selectedDate = pickeddate;
      });
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
            children: [
              TextField(
                controller: titlecontroller,
                decoration: InputDecoration(labelText: 'TITLE'),
                keyboardType: TextInputType.text,
                onSubmitted: (_) => submitdata(),
              ),
              TextField(
                controller: amountcontroller,
                decoration: InputDecoration(labelText: 'AMOUNT'),
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitdata(),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(selectedDate == null
                            ? 'No Date Selected'
                            : DateFormat.yMMMd().format(selectedDate))),
                    FlatButton(
                        onPressed: presentdatepicker,
                        textColor: Colors.blue,
                        child: Text(
                          'CHOOSE DATE',
                          style: TextStyle(fontSize: 15),
                        ))
                  ],
                ),
              ),
              RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: submitdata,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'ADD TRANSACTION',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
