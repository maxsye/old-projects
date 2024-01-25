import 'package:flutter/material.dart';

import 'app.dart';
import './models/location.dart';
import './screens/image_banner.dart';

class Locations extends StatelessWidget {
  final List<Location> locations = Location.fetchAll();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Locations'),
      ),
      body: ListView(
        //ListView will render a full screen, a scrollable list of items
        //children: locations.map((location) => Text(location.imagePath)).toList(),
        children: locations
            .map((location) => GestureDetector(
                  child: Container(
                    child: ImageBanner(location.imagePath),
                    padding: const EdgeInsets.fromLTRB(0, 12.0, 0, 12),
                  ),

                  //child: Text(location.name),
                  onTap: () =>
                      _onLocationTap(context, location.id), //takes a function
                ))
            .toList(),
      ),
    );
  }

  void _onLocationTap(BuildContext context, int locationID) {
    //navigate to the new screen
    Navigator.pushNamed(context, LocationDetailRoute,
        arguments: {'id': locationID});
  }
}
//.map
//for item in the map, which is a (location), execute the following function which returns
//a widget that represents each item in the ListView
//in this case, we return a text widget and use location.name for text widget
//toList converts it back to a list

//GestureDetector
//parent type that can be used in any widget, can wrap anything in GestureDetector
//can pass on anonymous method

//Navigator.pushNamed
//Provided by material package, pushNamed is named route
//pass it the context and the name of the route
//optional parameter arguments takes a map type (dictionary)
