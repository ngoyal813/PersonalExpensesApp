import 'package:flutter/material.dart';
import 'transactions.dart';
import 'package:intl/intl.dart';

class txlist extends StatelessWidget {
  final List<Transactions> transactionlist;
  final Function deleteTx;
  txlist({required this.transactionlist, required this.deleteTx});

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
    return Container(
      height: mediaquery.size.height * 0.4,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: FittedBox(
                    child: Text(
                      '\$${transactionlist[index].amount}',
                    ),
                  ),
                ),
              ),
              title: Text(transactionlist[index].title),
              subtitle:
                  Text(DateFormat.yMMMd().format(transactionlist[index].date)),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                color: Colors.red,
                onPressed: () => deleteTx(transactionlist[index].id),
              ),
            ),
          );
        },
        itemCount: transactionlist.length,
      ),
    );
  }
}
