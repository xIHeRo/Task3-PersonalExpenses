import 'package:flutter/material.dart';
import './widgets/Transactions_list.dart';
import './widgets/chart.dart';
import './widgets/new_transactions.dart';
import 'models/Transactions.dart';
import 'package:intl/intl.dart';

import './models/Transactions.dart';

//prefer_const_literals_to_create_immutables
// ignore_for_file: prefer_const_constructors
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Title for the application
      title: 'Personal Expenses ',

      // Theme controls the whole app colors and identifications
      theme: ThemeData(
        //primary is the original while copy with is the secondary color
        primarySwatch: Colors.cyan,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepOrange)
            .copyWith(secondary: Colors.cyan),
        // Ajusting the App Font
        fontFamily: 'OpenSans',
        //*******************************************************************
        // Making a theme that will be called each time as a standard
        // ignore: deprecated_member_use
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
        //********************************************************************
        //Adjusting the AppBar Theme  (Font-size-theme)
        // Appbar changes with changing the text of whole app
        appBarTheme: AppBarTheme(
          // ignore: deprecated_member_use
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 5,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
        //********************************************************************
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
// list of Transaaction objects
  final List<Transaction> _userTransactions = [];

  // get is  dynamic property
  List<Transaction> get _recentTransactions {
    /** we used the method of (where) that allows you to run a function on
       * each element in the list and if that function returns true the item is 
       * kept in a newly returned list otherwise it is not included in the list  
       * so it takes each element as a parameter to a nonanymous function
       */
    return _userTransactions.where((tx) {
      /** Return True if it happens in tha last week
       * Return False if it happens in an older than the last week
       * isAfter that we will pass another time inside it &
       * if the first is after the second one then this trasnsaction will
       * be addded to recent transaction
       * 
       * so here it checks that tx.date is after today minus 7 days
       * (Previous week ) so all transaciton in this period will be loaded in 
       * Recent Transactions
       * */
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }) //as we do with map as a conversion
        .toList();
  }

  /**Funciton that will accept two arrguments txTitle and txAmount From textField remember :)
   * it will make a new object of the class Transaction (in models)
   * Storing the value that comes from the function in that object
   * Use setState to render the page 
   * Then add in a list called : _userTransaction.add(THEN ADD NEW OBJECT IN IT AS WE TALKED ON HIM ABOVE)
   */
  void _addNewTransactions(
      String txTitle, double txAmount, DateTime chosendate) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: chosendate,
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTx);
    });
  }

//$$$$$$$$$$ m4 fahmha $$$$$$$$$$$$$$$$$
  void _startAddNewTransaction(BuildContext ctx) {
    /**
     * funcition provided by flutter that needs 2 arguments    
     * the First value is for the context 
     * the second one is 
     * the value that returns is tthe widget you need to appear which is the
     * transacion
     */

    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransactions),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

// as we identified each transaction with an id which is the time it is created
  void _deleteTransacation(String id) {
    setState(() {
      //that will delete an element in a list when action occurs and recieves each element of the list

      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Personal Expenses',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          //it takes a list of widgets
          actions: [
            // it is a button added in the appbar and we select its shape through icon
            // Ink to make shadow boarder around it
            Ink(
              decoration: ShapeDecoration(
                color: Colors.lime,
                shape: CircleBorder(),
              ),
              child: IconButton(
                onPressed: () => _startAddNewTransaction(context),
                icon: Icon(
                  Icons.add_shopping_cart_sharp,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
        //which add some Scrobaillity to the column widget
        body: SingleChildScrollView(
          child: Column(
            //$$$$$$$$$$$$$$$$$$$$$$ azay w hya comment 48ala ? $$$$$$$$$$$$$
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Chart(_recentTransactions),
              TransactionList(_userTransactions, _deleteTransacation),
            ],
          ),
        ),
        //to set the location of floating action button
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        //to set the icon shape of the floating action button
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.playlist_add,
            color: Colors.yellow,
          ),
          onPressed: () => _startAddNewTransaction(context),
        ));
  }
}
