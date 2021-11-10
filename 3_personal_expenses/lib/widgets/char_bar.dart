import 'package:flutter/material.dart';

class CharBar extends StatelessWidget {
  final String label;
  final double SpendingAmount;
  final double SpendingPctOfTotal;

  CharBar(
    this.label,
    this.SpendingAmount,
    this.SpendingPctOfTotal,
  );
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Wrapping fitted box in container to fix the problem of
        //huge numbers that makes the bar goes down
        Container(
          height: 20,
          child: FittedBox(
            //it shrinks the text or whatever inside it to the ccertain place
            // to take the ((spended amount)) and to approimate it to Interger values
            child: Text('\$${SpendingAmount.toStringAsFixed(0)}'),
          ),
        ),
        // just to leave a small space
        SizedBox(
          height: 4,
        ),
        Container(
          //The Box that will hold the Bar
          height: 75,
          width: 35,
          child:
              //Stack widget allows you to  place elements above eaach other
              // 3D dimentions which means overlapping over each other
              Stack(
            children: [
              //$$$$$$$$$$$$$$$4 Meen dol ? $$$$$$$$$$$$$$
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.pink, width: 2),
                  color: Color.fromRGBO(210, 230, 230, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              // it allows us to create a box that is sized
              // as a fraction of another value ( to 1)
              //from the parent (60)
              FractionallySizedBox(
                heightFactor: SpendingPctOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
// just to leave a small space
        SizedBox(
          height: 4,
        ),
        Text(label),
      ],
    );
  }
}
