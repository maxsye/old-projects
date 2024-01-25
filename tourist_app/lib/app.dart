import 'package:flutter/material.dart';

import 'locations.dart';
import './style.dart';
import './screens/location_detail.dart';

const LocationsRoute =
    '/'; // '/' means inital route, base route, constant variables should be capitalized
const LocationDetailRoute = '/location_detail'; // location_detail route,

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: _routes(), //gives us a dynamic list of routes
      theme: _themeData(),
    );
  }

  RouteFactory _routes() {
    return (settings) {
      //returns a function with parameter settings
      final Map<String, dynamic> arguments = settings.arguments; //dictionary of String:var
      Widget screen;
      switch (settings.name) {
        case LocationsRoute: //if its LocationsRoute case
          screen = Locations(); //new instance of Locations Widget
          break;
        case LocationDetailRoute:
          screen = LocationDetail(arguments['id']); //dictionary arguments is in locations.dart
          break;
        default: //if none of cases match
        return null;
      }
      return MaterialPageRoute(builder: (BuildContext context) => screen);
    };
  }

  ThemeData _themeData () {
     return ThemeData(
          appBarTheme: AppBarTheme(
           textTheme: TextTheme(title: AppBarTextStyle),
          ),
          textTheme: TextTheme(
          title: TitleTextStyle,
          body1: Body1TextStyle,
        ),
      );
  }
}
//think about screen like a deck of cards, one card = one screen
//home card is base card
//when I tap on item that loads a new screen, a different card moves on top of the home card
//this is called a stack
//when they click back button, the top card slides off the deck
//when we define a series of screens, we're defining a list of routes
//a route is a basic URL that is a path to a page

//RouteFactory _routes()
//a route factory - chunk of data with routes
//get the arguments to whatever route was passed
//dynamic is type underlying all Dart objects
//use dynamic if object is not initialized
//screen is the final screen that will be returned based on name of the route
//switch function is just glorified if and else if statement, can have infinite else ifs
//switch function will keep on going through every case until it breaks or returns something
//_routes() expects a MaterialPageRoute to be returned
//MaterialPageRoute is basically a type of route
//mutiple types of routes, most popular is MaterialPageRoute
//builder is to pass a function that returns something, in this case, a screen