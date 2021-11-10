//import 'package:flutter/foundation.dart';

// ignore_for_file: file_names

class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  /* -> We made a constructor so that we can pass
   * values to this class anytime
   * -> (requried) here is due to null safety it must 
   * be inserted before the word (this)
   * -> we added final because their values are constants during runtime 
   * */
  Transaction(
      {required this.id,
      required this.title,
      required this.amount,
      required this.date});
}
