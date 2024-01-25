import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String text;
  final Function showsDatePicker;

  AdaptiveFlatButton(this.text, this.showsDatePicker);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
                        ? CupertinoButton(
                            child: Text(
                              text,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: showsDatePicker,
                          )
                        : FlatButton(
                            textColor: Theme.of(context).primaryColor,
                            child: Text(
                              text,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            onPressed: showsDatePicker,
                          );
  }
}