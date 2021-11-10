import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
//prefer_const_literals_to_create_immutables

/***************   THIS is for the TextField + Button         *************** */

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  //DateTime _selectedDate = DateTime.now();
  var _selectedDate;
  void _submitData() {
    if (amountController.text.isEmpty) {
      return;
    }

    // It is a must that we choose the type which the controller returns
    //we made double.parse as amountController is text
    // and it is sent to the funcion as a double so we need to convert it
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    //it stops the execution process if the user send empty elements
    if (enteredAmount <= 0 || enteredTitle.isEmpty || _selectedDate == null) {
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
    // it makes the screen of the bottom leave after the it is completed filled
    Navigator.of(context).pop();
  }

//********************** It is for Date Picker ********************* */
  void _presentDatePicker() {
    showDatePicker(
      //$$$$$$ Context y3ni eeeh ?? $$$$$$$$$$$$
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
      //waiting for future response from user
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      // to Render the page after picking up a date
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    print('...');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        // we entered Column widget inside the container so that we can easly make
        //Styling like padding and margin
        padding: EdgeInsets.all(8),
        child: Column(
          // to make the button in certain position
          //$$$$$$$$$$$$$$$$ Leh m4 bt2sr 3la el Text field $$$$$$$$$
          crossAxisAlignment: CrossAxisAlignment.end,
          //Press space inside textfield so that you see tons of properties
          children: [
            TextField(
              //this is for the label in the Textfield
              //which is the word writtern before you insert your own words
              decoration: InputDecoration(labelText: 'Title'),

              controller: titleController,
              onSubmitted: (_) => _submitData,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              //to accept numbers only
              keyboardType: TextInputType.number,

              //$$$$$$$$ leh yst5dm submitData() m4 submitData 7war el cosen ?? $$$$$$$$
              //$$$$$$$ Bt3ml eh Onsubmitted ? $$$$$$$$$$$$$$4
              onSubmitted: (_) => _submitData,
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No Date Chosen!'
                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                        //   backgroundColor: MaterialStateProperty.all(Colors.cyan),
                        //for changing the Text color of  Text button (NEW+Standard)
                        foregroundColor:
                            MaterialStateProperty.all(Colors.orange)),
                    // Theme.of(context).primaryColor,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: _presentDatePicker,
                  ),
                ],
              ),
            ),
            TextButton(
              child: Text('Add Transaction'),
              style: ButtonStyle(
                  //for changing the background color of  Text button (NEW+Standard)
                  backgroundColor: MaterialStateProperty.all(Colors.cyan),
                  //for changing the Text color of  Text button (NEW+Standard)
                  foregroundColor: MaterialStateProperty.all(Colors.black)),
              onPressed: _submitData,
            ),
          ],
        ),
      ),
    );
  }
}
