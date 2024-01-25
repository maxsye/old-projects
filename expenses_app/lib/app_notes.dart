//use the top of debug console for the most useful part of error message
//if need more rigorous debug, you can start debugging (F5)
//when debugging, you can open up dart devtools by typing it

//devtools displays the widget tree

//Select Widget Mode is that when you click on it, the widget lights up

//Debug Paint adds helper lines in UI to help you understand why it 
//is structured the way it is structured

//Paint Baselines adds baselines of text into the UI

//Performance Overlay helps you understand the performance, however most 
//emulators have worse performance than actual phones

//Repaint Rainbow borders indicate what was repainted, the more something
//is repainted, the more color around that thing is changed
//used to see what is changed

//most important tools are debug console and dartdevTools
//------------------------------------------------------------------------------------
//https://flutter.dev/docs/development/ui/widgets/styling
//is a good website to learn about all the what widgets exist, how to configure it,
//what properties does it have, what does it do, etc.

//Most Important Widgets

//App/Page Setup
//MaterialApp/CupertinoApp - sets up overrarching app, behind the scenes work
//Scaffold/CupertinoPageScaffold - sets up the rest of the page in the app

//Layout
//Container - wrapper around other widgets to get a certain styling
//Column - position items horizontally, items sit below each other, takes all the
//vertical space it can get
//Row - position items vertically, items sit beside each other,

//Row/Column children
//Flexible - how much space children widget consumes 
//Expanded - expands child to fill entire space of row/column

//Content Containers
//Stack - items positioned within each other
//Card - prestyled container widget, some shadow, padding, etc.

//Repeat Elements
//ListView - Column that is scrollable
//GridView - combination of Columns and Rows but is scrollable
//ListTile - default styling and default layout setup

//Content Types
//Text - presents text
//Image - presents an image
//Icon - presents an icon

//User Input
//TextField - where a user can enter something
//RaisedButton/FlatButton/IconButton - creates a button
//GestureDetector - detects gestures, register broad variety of taps
//InkWell - gives ripple effect when tapped
//------------------------------------------------------------------------------------
//Container
//Takes exactly one child widget
//Rich (styled) aligment & styling options
//Flexible width (e.g child width, available with, ...)
//Perfect for custom styling & alignment

//Column/Row
//Takes multiple (unlimited) child
//Alignment but no styling options
//Always takes full available height(column)/row(width)
//Must-use if widgets sit next to/above each other

//Combine these two widgets together
//Wrap column/row with Container to add styling
//Have a column/row of Containers
//See them as crucial building blocks that can be mixed and matched
//MainAxisSize class is very useful, default is MainAxisSize.max but can set
//it to min

//However, they don't automatically add scrolling functionality
//Column tries to squeeze all the widgets into itself
//Add SingleChildScrollView on the home or child parameter
//Sometimes, soft keyboard pushes the page up a bit, leading to exceeded page
//boundaries
//Flutter tries to always scroll the input into view, and therefore, it insets
//the page by the height of that text field so that the text input can never be
//below the soft keyboard, so that's why height of text field is always added
//as a padding above the soft keyboard, and that's the problem
//The height is added but since the page can't scroll away, there's a problem
//So, we wrap the column in a SingleChildScrollView
//-------------------------------------------------------------------------------------
//ListView
//There is another widget to ensure that there is a scrollable row/column
//Instead of Column, just use ListView()
//ListView() is a widget that has an unlimited height, unlike a Column, which takes
//all the height it can get on the screen

//There are two ways of building it
//It can be Listview(children: [])
//Like a SingleChildScrollView(child: Column(etc))
//Don't use for very long lists

//Or ListView.builder()
//Only renders what's visible, what's not needed is not rendered
//Approach to use for very long lists or lists where you don't know how many items
//will be on it
//This way requires an itemBuilder argument, itemBuilder takes a function that
//gives a context and an integer that is the index of the item we're building
//-------------------------------------------------------------------------------------
//TextField
//To make sure they only enter numbers, do keyboardType: TextInputType.number
//On iOS, this might not allow for decimal places, use TextInputType.numberWithOptions(decimal: true)

//Actions
//In appBar, we can add a list of widgets for the actions parameter
//In this case, we do IconButton() in the list of widgets in the action parameter
//We can also add floatingActionButton argument of the Scaffold
//-------------------------------------------------------------------------------------
//showModalBottomSheet() is a function provided by Flutter
//context and buildercontext in newTransaction.dart is provided by the app

//ThemeData
//This class takes a parameter primarySwatch and primaryColor
//Difference is that primaryColor is a single color while primarySwatch generates multiple shades
//of that color
//Also takes an accentColor parameter that is the sceond theme color
//-------------------------------------------------------------------------------------
//Flexible and Expanded
//Inside of a Column or a Row, every item is just as big as it needs to be or what you tell it to be
//Flexible has a parameter fit that takes FlexFit.loose or FlexFit.tight
//FlexFit.loose means that child of this flexible item should keeps it's size, it's the default 
//and rarely needs to be defined specifically

//FlexFit.tight, the child is forced to fit the available space
//If two children have FlexFit.tight they split the remaining available space

//Say you want one child to have twice the space of the other one
//For that you add another argument called flex, flex by default is set to 1
//However, if you set flex to 2, that child takes up double of the remaaining space
//Say there's three children, two with flex 1, and one with flex 2
//The one with flex 2 takes 2/4 of the space and each of the other children take 1/4 each
//Flex is respective with the other children as well

//Say there's a scenario of one child with FlexFit.tight and flex 2 and another with FlexFit.loose and flex 1
//The first child takes 2/3 of the row and fills the entire thing
//The second child takes 1/3 of the row but doesn't necessarily takes the whole thing and might leave some
//white space

//Expanded widget is just Flexible with fit: FlexFit.tight, it is preconfigured
//----------------------------------------------------------------------------------------
//Summary
//Composed UI from built-in and custom widgets
//Styled and configured through arguments
//Styling and layout options are very different
//Often, there's more than one Widget or option to get the job done
//Define a global theme for colors and text to then tap into it from anywhere in the app
//Built-in widgets use theme settings automatically
//Lifting stateless to stateful is often needed
//Pass function references and data around
//Adjusted the UI to my logic
//-----------------------------------------------------------------------------------