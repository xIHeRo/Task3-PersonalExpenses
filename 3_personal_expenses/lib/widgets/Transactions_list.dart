// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import '../models/Transactions.dart';
import 'package:intl/intl.dart';
//.. to tells dart to go on level up and then go to models
//prefer_const_literals_to_create_immutables

/***************************  This for Card The appear having (Prdouct - Price - DATE)      ********************* */
class TransactionList extends StatelessWidget {
  final Function deleteTx;

  final List<Transaction> transactions;
  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return

        // Notice : There was an error which was that childern must be without [] here

/**
 * We cannot for example style a background color for Row or text 
 * but we can do this for container
 */

        //column with scroll view
        /** the problem is that it have infinte height not like the c
         * column that takes the whole height of the screen  so flutter doesnot 
         * consider its height --> give error as it is infinite
         * so when it is embedded in Container which is the parent of height 300
         * it takes 300 in its considration
        */
        Container(
      height: 450,
      // if Transactions.isEmpty true it will show the text + image
      // else it show the list in scroll view
      child: transactions.isEmpty
          ? Column(
              children: [
                Text(
                  'No Transactions Available, Add One Please..',
                  style: Theme.of(context).textTheme.headline6,
                ),
                //it is used to make a box as spacing between text and image
                SizedBox(
                  height: 20,
                ),
                // Image is Wrapped inside container
                // to speicfy its height

                Container(
                    height: 250,
                    child: Image.asset(
                      'assets/images/ponting.png',
                      fit: BoxFit.cover,
                    )),
              ],
            )
          : ListView.builder(
              // it recieves context ctx and its value is build context
              // it renders on each element appear in the screen
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  /**
                           * margin is a spacing around the border(from outside) use EdgeTnsets
                           * symmertric so that you can assing values Vertically and horitzonlty
                           *  */
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  //.*****************************************************************
                  child: ListTile(
                    /**
                     * (List tile) it is a widget that holds a list but in some formal way
                     *the (circle avatar) is a rounded widget that often hold images 
                     *(leading widget )the widget that comes first 
                     * but we will hold the (amount value) inside it
                     */
                    leading: CircleAvatar(
                      radius: 30,
                      /**We will add a padding which is like margin takes EdgeInsects
                           * it is the space around the content itself
                           */
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          //we inserted it in a fitbox as to hold numbers not to get down
                          child: Text('\$${transactions[index].amount}'),
                        ),
                      ),
                    ),
                    //.*****************************************************************
                    //after the circle we will write the name of the product itself
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    //.*****************************************************************
                    //subtitle is what comes down the title itself
                    subtitle: Text(
                      /**
                      * Dateformat comes from the intl package we installed in the yaml
                      *  We can use DateFormat('yyyy-MM-dd') -> 2021-11-5
                      * 'h:m' it gives us the hour and minutes
                      * press space inside to find different forms but DateFomate.()
                      */

                      DateFormat.yMMMd().format(transactions[index].date),
                      //.*****************************************************************
                    ),
                    //Note that we can use trailing so that we add something at the end of the list
                    trailing: IconButton(
                      icon: Icon(Icons.dangerous_rounded),
                      color: Colors.red,
                      onPressed: () => deleteTx(transactions[index].id),
                    ),
                  ),
                );
              },
//.*****************************************************************
// how many conunts should be built
              itemCount: transactions.length,
//.*****************************************************************
            ),
    );
  }
}
