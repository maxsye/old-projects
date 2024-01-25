import 'package:flutter/material.dart';

import '../models/location.dart';

import './image_banner.dart';
import './text_section.dart';


class LocationDetail extends StatelessWidget {
  final int _locationID;

  LocationDetail(this._locationID);

  @override
  Widget build(BuildContext context) {

    final location = Location.fetchByID(_locationID);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(location.name),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start, //y-axis
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ImageBanner(location.imagePath),
            //cascade('..') takes a given item and lets you run a function against it, or make an assignment
          ]..addAll(textSections(location))),
          //addAll appends a list onto an existing list
    );
  }

  List<Widget> textSections(Location location) {
    return location.facts.map((fact) => TextSection(fact.title,fact.text)).toList();
    //.map transforms a list of type x into a list of type y
    //.map iterates each fact in the facts list, for each fact execute a single statement 
    //TextSection(fact.title,fact.text), that statement is going to return what's going to 
    //be in the new list, returning a TextSection in this case
    //.toList() converts something that's iterable to an actual list type
  }
}