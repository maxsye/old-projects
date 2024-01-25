/**
 * Every widget can be used as a screen
 * Screen, page, and route are commonly used to describe these widgets
 */
/**
 * GridView
 * GridView's gridDelegate parameter takes care of the structure of the grid
 * maxCrossAxisExtent is just the max width
 */
/**
 * Inkwell
 * Inkwell is basically a GestureDetector that fires off a ripple effect
 */
/**
 * Navigator is a class that helps you navigate between screens
 * It needs to be connected to the context - Navigator.of(context)
 * Navigator.of(context).push takes a MaterialPageRoute()/CupertinoPageRoute()
 * The route has 4 parameters
 * builder - which widget should be built
 * fullscreenDialog - to control the default animation or a different animation
 * we can ignore the other 2 for now
 * To pass data between screens,  and create constructors make attributes for the 
 * classes
 */
/**
 * Another way to navigate is by using named routes, good for bigger apps
 * In MaterialApp, routes takes a map (dictionary) of String to Function
 * that returns a widget
 * Convention to pass routes starting with '/'
 * We now do Navigator.of(context).pushNamed, not .push
 * To pass data by using this way, in the pushNamed method, this method takes
 * an arguments parameter, so we can pass data to the new screen loaded
 * In this case, we pass a map
 * In the new screen, we store the data in a variable as 
 * routeArgument = ModalRoute.of(context).settings.arguments as Map<String, String>
 * A good practice is to have a static const variable that stores the route name
 * because typos can easily happen and your whole app can break and it's hard
 * to fix
 * Then, access the route name by doing CategoryScreenName.routeName
 */
/**
 * .where((element) {}).toList() is a condition to got through a list and 
 * run a function on each element
 * we return true if we want to keep it, and then convert all those elements
 * that meet the condition into a list
 * 
 * ClipRRect forces the child widget into a certain form
 * BorderRadius.only() allows us to only set the radius of certain corners
 * Postioned allows us to position the child widget in an absolute coordinate space
 * 
 * switch allows us to combine multiple if statements into one statement
 */
/**
 * onGenerateRoute allows us to build a screen in case we reference a route that
 * we did not declare in the routes table (route: etc)
 * Ex. onGenerateRoute: (settings) {
 * return MaterialPageRoute(
 * builder: (_) => ExerciseMainScreen(), settings: settings);}
 * 
 * onUnknownRoute is reached when flutter fails to build a screen with all other
 * measures, basically the last resort
 * Like a 404 fallback for the web
 * Ex. onUnknownRoute: (settings) {
 * return MaterialPageRoute(
 * builder: (_) => ExerciseMainScreen(), settings: settings);}
 * 
 * To add a navigation screen that pops up under the appBar do DefaultTabController
 * body: TabBarView allows us the navigate to the actual screen the user wants
 * 
 * Navigator.of(context).pop(); can take any parameter
 * 
 * Navigator.of(context).pushNamed returns a Future when the user goes back from that screen
 * The Future returned lets know you the page that you pushed to is not displayed anymore
 * Adding .then((result) => {} allows you to get that result from Navigator.of(context).pop(x)
 * When pushNamed is paired with pop, when you pop and pass a parameter, .then allows you to get that result
 * Futures are objects that allow you to specify a function that should execute once
 * they're done with a certain operation
 * 
 * context cannot be used inside initState
 * if you need to use context, do didChangeDependencies
 */
/**
 * SwitchListTile is a list tile with a switch and text
 */