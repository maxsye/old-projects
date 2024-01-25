import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/newTransaction.dart';
import './models/transaction.dart';
import './widgets/transactionList.dart';
import './widgets/chart.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.grey[200],
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver{
  final List<Transaction> _transactions = [];

  var _showChart = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);  //whenever lifecycle state changes, go to observer
    super.initState();                          //and call the didChangeAppLifecycleState method
  }                           //We tell flutter that observer is this, this class itself

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    //print(state);
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  List<Transaction> get _recentTransactions {
    return _transactions.where(
      (transaction) {
        return transaction.date.isAfter(
          DateTime.now().subtract(
            Duration(days: 7),
          ),
        );
      },
    ).toList(); //the parameter must be true for item to be in list
  }

  void _addNewTransaction(String title, double amount, DateTime date) {
    final newTransaction = Transaction(
      DateTime.now().toString(),
      title,
      amount,
      date,
    );
    setState(() {
      _transactions.add(newTransaction);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((transaction) {
        return transaction.id == id;
      });
    });
  }

  void _startAddNewTransaction(BuildContext thisContext) {
    //shows the text input fields
    showModalBottomSheet(
      context: thisContext,
      builder: (buildercontext) {
        return GestureDetector(
          child: NewTransaction(_addNewTransaction),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  List<Widget> _buildLandscapeContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget transactionListWidget) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Show Chart', style: Theme.of(context).textTheme.title),
          Switch.adaptive(
            activeColor: Theme.of(context).accentColor,
            value: _showChart,
            onChanged: (val) {
              setState(() {
                _showChart = val;
              });
            },
          ),
        ],
      ),
      _showChart
          ? Container(
              width: double.infinity,
              child: Container(
                child: Chart(_recentTransactions),
              ),
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  .7,
            )
          : transactionListWidget
    ];
  }

  Widget _androidScaffold(AppBar appBar, SafeArea pageBody) {
    return Scaffold(
      appBar: appBar,
      body: pageBody,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS
          ? Container() //doesn't render anything
          : FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => _startAddNewTransaction(context),
            ),
    );
  }

  List<Widget> _buildPortraitContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget transactionListWidget) {
    return [
      Container(
          width: double.infinity,
          child: Container(
            child: Chart(_recentTransactions),
          ),
          height: (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) *
              .3),
      transactionListWidget
    ];
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text('Personal Expenses'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final _isLandscape = mediaQuery.orientation == Orientation.landscape;
    //recalculated for every build run
    final PreferredSizeWidget appBar = _buildAppBar();
    final transactionListWidget = Container(
      child: TransactionList(_transactions, _deleteTransaction),
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          .7,
    );
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (_isLandscape)
              ..._buildLandscapeContent(
                mediaQuery,
                appBar,
                transactionListWidget,
              ),
            if (!_isLandscape)
              ..._buildPortraitContent(
                //... is the spread operator, pulls elements out of list
                mediaQuery,
                appBar,
                transactionListWidget,
              ),
          ],
        ),
      ),
    );
    return _androidScaffold(appBar, pageBody);
  }
}

//card's size depends on child, and child depends on parent's size
//we are trying to change the small size of the default size
//of the rectangle it is wrapped in, how to do this, add a Container
//Container will now have a width of 100 device pixels, gives us the same
//size even on different devices

//main axis is top to bottom
//cross axis is from left to right

//DateTime.now() creates a current timestamp
//transactions.map() changes list of objects into a list of widgets
//map takes a function which gets executed on every element in the list

//transactions.map((transaction) {
//return Card(child: Text(transaction.title));

//transaction is the parameter, we pass a transaction to the functinon
//and it returns the card

//we want to position transaction.amount next to (transcation.title and
//transaction.date)
//transcation.title and transaction.date are on top of each other

//on any object you can call .toString() to make it a string
//styling in flutter is entirely passing arguments

//static properties are just like enums, just that
//it's not a number with a label but a more complex number with a label
//------------------------------------------------------------------------------------
//String interpolation

//Concantanaetion with '+' is perfectly fine, but Dart has a more concise way
//'\$' + transaction.amount.toString()
//Wrapping variable in {}, preceded by a '$'
//'\$${transaction.amount}', toString() is automatically called
//------------------------------------------------------------------------------------
//Nicely formatting date

//Achieved through extra help of package
//There's no built in feature neither in Dart nor in Flutter that would make
//it easy for us to format this date
//There is a third party package we can use
//Must define this dependency in pubspec.yaml in dependencies
//DateFormat().format is provided
//could do DateFormat('yyyy-MM-dd'),
//can put period after DateFormat to access special constructors
//Ex. DateFormat.specialconstructor().format(date)
//-----------------------------------------------------------------------------------------------------------------
//To create text input, use TextField()
//To decorate this TextField(), do TextField(decoration: InputDecoration(etc))
//The onChanged parameter executes for every keystroke
//The onEditingComplete parameter executes when user presses done, go, next, etc button
//The onSubmitted parameter executes only when the done button is pressed
//The onTap parameter executes whenever you tap into the text field
//To change variable when submit button is hit:
//String titleInput;
//String amountInput;
//...
//onChanged: (input) {
//titleInput = input;},
//...
//onChanged: (input) {
//amountInput = input;},

//Or, you can do the method shown in the code above with titleController
//and amountController and passing the controller parameter, and create
//only an onPressed for FlatButton instead of 2 TextFields
//----------------------------------------------------------------------------------------------------------------
//TransactionList is our list of transactions that should change
//However, change is triggered by the TextFields which reside in the main.dart file

//To work around this, the common denominator (the one widget in which we use them both, the MyHomePage) widget,
//We add two new widgets, one for the Card widget, one for the text input widget
//Advantage is that Scaffold and AppBar don't change in this MyHomePage Stateless widget, but others
//-------------------------------------------------------------------------------------
//To prevent the sheet from getting closed in showModalBottomSheet, we wrap the
//NewTransaction class with a GestureDetector on pass the onTap parameter as
//() {} so the tapping does nothing
//We also do behavior: HitTestBehavior.opaque, so that a tap on the modal sheet, you
//catch the tap event and prevent it from being handled by anything else

//textTheme: ThemeData.light().textTheme.copyWith(title: TextStyle(fontFamily: 'OpenSans', fontSize: 20.0,))

//We assgin a new text theme for the AppBar so that all text in the app bar gets the same theme
//We create a new Theme by doing ThemeData.light().textThteme (default text theme), and copy this with some
//new overriden values
