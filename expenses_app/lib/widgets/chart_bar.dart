import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String weekday;
  final double amount;
  final double percentageOfTotal;

  ChartBar(this.weekday, this.amount, this.percentageOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: <Widget>[
          Container(
            child: FittedBox(
              child: Text('\$${amount.toStringAsFixed(0)}'),
            ),
            height: constraints.maxHeight * 0.15,
          ),
          SizedBox(height: constraints.maxHeight * 0.05),
          Container(
            height: constraints.maxHeight * 0.6,
            width: 10,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromRGBO(220, 220, 220, 1),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: percentageOfTotal,
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
          SizedBox(height: constraints.maxHeight * 0.05),
          Container(
            child: FittedBox(
              child: Text(weekday),
            ),
            height: constraints.maxHeight * 0.15,
          ),
        ],
      );
    });
  }
}

//amount.toStringAsFixed makes it so that there are no integers
//The Stack widget allows you to place elements on top of each other in a 3D space, not like a column,
//The objects overlap each other, first widget is the bottom-most widget

//FractionallySizedBox allows us to create a box as a fraction of another value

//To dynamically size the chart bars, we do LayoutBuilder
//We take two parameters in the following order (context, constraint)
//Constraints defines how a widget is rendered on a screen, all objects have constraints
//If not set, for some objects, there are constraints
//We can use the constraints parameter to dynamically determine height and width
