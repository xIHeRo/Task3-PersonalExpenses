import 'package:flutter/material.dart';
import 'package:personal_expenses/models/Transactions.dart';
import '../models/Transactions.dart';
import 'package:intl/intl.dart';
import './char_bar.dart';

class Chart extends StatelessWidget {
  // it is a list that he accepts from the the user using a constructor
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);
  //$$$$$$$$$$$$ M4 fahm get grouped $$$$$$$$$
  // Always Replace object by dynamix in List of maps
  List<Map<String, dynamic>> get groupedTransactionValues {
//it gives us a list of 7 elements that start from 0'
// which will generate each element with index being 0 1 2 3
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalsum = 0.00;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalsum += recentTransactions[i].amount;
        }
      }

//DateFormat.E it gives shortcut for the begging of the day
//$$$$$$$$$$$$$$ meen deh ?$$$$$$$$$$$$$
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalsum,
      };
    }).reversed.toList();
  }

  // $$$$$$$$$$$$ 3mlnaha azay $$$$$$$$$$$$$$$$$$$$$$
  double get totalSpending {
    //0.0 is the starting value and we will return a value that returns to be
    // added to the 0.0 for every element in transacrion values
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(15),
      //instead of using a container for padding we can use a widget callled padding
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // $$$$$$ eh deeh awl satr ?$$$$$$$$$$$$$$$$$$$$
          children: groupedTransactionValues.map((data) {
            return Flexible(
              // We force the child to use available space
              fit: FlexFit.tight,
              child: CharBar(
                data['day'],
                data['amount'],
                totalSpending == 0.0
                    ? 0.0
                    : (data['amount'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
