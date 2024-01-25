//Responsive vs Adaptive

//Responsive
//Adjusting the layout based on portrait mode or landscape mode or small/big device sizes

//Adaptive
//Adapting your user interface to different operating systems
//Certain look on Android and certain look on iOS
//For Android, you want to material-design look and styles, it is the default operating system Flutter targets
//In Android, you want Android animations and route transitions and Android fonts
//For iOS, you want a Cupertino look/styles, iOS animations/route transitions, and iOS fonts

//if Platform.isIOS might come in handy
//------------------------------------------------------------------------------------------------------------
////Setting device orientation
//Must import package:flutter/services.dart
//Then, in void main, do SystemChrome.setPrefferedOrientations([
//DeviceOrientation.portraitUp,
//DeviceOrientation.portraitDown,
//])
//-----------------------------------------------------------------------------------
//Keyboard
//Flutter allows us to know how much space the soft keyboard takes up
//MediaQuery.of(context).viewInsets gives us information about anything
//in our view
//By adding .bottom to the end tells us how much space is occupied by the
//keyboard
//----------------------------------------------------------------------------------
//Adaptive
//For some widgets, flutter allows you to add .adaptive to the end of the class
//Ex. Switch.adaptive(...), and it automatically adjusts the look of the widget
//By importing 'dart:io' we can check for the platform by doing
//Platform.isIOS or Platform.isAndroid, this returns a boolean
//----------------------------------------------------------------------------------
//SafeArea
//By wrapping bodies with SafeArea(), it makes sure everything is positioned within
//the reserved areas on the screen
//----------------------------------------------------------------------------------
//Summary
//To build responsive user interfaces, MediaQuery is really helpful
//.adaptive is helpful to create adaptive user interfaces
//----------------------------------------------------------------------------------
