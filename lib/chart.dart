import 'package:flutter/material.dart';
import 'package:personal_expenses_app/chartBar.dart';
import 'package:personal_expenses_app/transactions.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transactions> recent_transactions;
  Chart(this.recent_transactions);

  List<Map<String, dynamic>> get groupedTransactionsValues {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      var totalsum = 0.0;
      for (var i = 0; i < recent_transactions.length; i++) {
        if (recent_transactions[i].date.day == weekday.day &&
            recent_transactions[i].date.month == weekday.month &&
            recent_transactions[i].date.year == weekday.year) {
          totalsum += recent_transactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': totalsum
      };
    });
  }

  double get totalspending {
    return groupedTransactionsValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionsValues.map((e) {
            return Flexible(
              fit: FlexFit.tight,
              child: chartBar(
                  e['day'],
                  e['amount'],
                  totalspending == 0
                      ? 0
                      : (e["amount"] as double) / totalspending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
