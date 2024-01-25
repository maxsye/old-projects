/**
 * Problem with passing data
 * 
 * State: the data (which may change) your app uses to render the UI
 * 
 * When a child needs some data, we have to pass data through the constructors
 * of widgets, leading to very long chains of arguments
 * 
 * We pass data through widgets which don't need it just so they can pass it to the
 * child widget
 * 
 * This also impacts the application's performance, since whenever the data
 * updates, many widget trees need to be rebuilt when only a small child
 * widget needs to be rebuilt
 * You only want to rebuild the widget that actually needs to be changed
 * 
 * In applications in general, it's always about managing the data and the UI
 * The UI reflects the data
 * State is data which affects the UI, and the data which might change
 */
/**
 * To solve the problem above
 * 
 * The Provider Package and Pattern allows us to have a global, central data provider
 * which you attach to any widget in the app, often attached to main.dart
 * All of child widgets can listen to the provider, adding a Listener with of(context)
 * build() of only the child widget changes when the Listener is activated
 * 
 * Can have multiple data providers in the app and can have multiple listeners
 */
/**
 * Provider is a data model, but bigger than the small data models in the models folder
 * We want to manage the list of all products, so we will create a different folder
 * called providers
 */
/**
 * "with" keyword is a mix-in, is like extending another class
 * Core difference is that you merge some properties or some methods but don't turn
 * the class into an instance of the inherited class
 * Like inheritance lite
 * 
 * extends means there is a strong connection between the two classes
 * classes can only inherit from one parent in Dart
 * 
 * with allows you to get all the properties and methods of the class you mix
 * with means there is less of a connection between the two classes
 * you can add as many mixins as you want
 * 
 */
/**
 * An alternative to ChangeNotifierProvider is ChangeNotifierProvider.value(value: ProviderClass())
 * ChangeNotifierProvider(builder: (context) => ProviderName())
 * We should use this way when we provide the data on single list or grid items
 * ChangeNotifierProvider automatically cleans up the data when not needed, which is good
 * 
 * To listen, we do Provider.of<Product>(context);
 * Or we can use Consumer<Product> which is equivalent to Provider of
 * Shrinks the amount of widget that needs to be rebuilt
 */
/**
 * Widget local state should affect only a widget on its own
 * Don't use provider for a provided class if you only want to change how
 * something is displayed inside of a widget
 */
/**
 * PopupMenuButton is a menu which opens up as an overlay
 */
/**
 * MultiProvider() allows multiple providers to be attached to a widget
 */
/**
 * Flutter allows us to easily do the swipe to remove functionality
 * Wrap the widget to be removed with Dismissible
 * Dismissible requires a key to prevent stateful widgets from taking
 * each other's states
 * A ValueKey works well in this case
 * background parameter takes the thing to be displayed when swiping
 * By doing direction: DismissDirection.endToStart, the removing only
 * works when swiping from right to left
 */
/**
 * Summary for state management
 * 
 * State management makes sure that app doesn't rebuild wen only something
 * small needs to change
 * ChangeNotifierProvider.value() provides the provided values, most likely objects
 * To listen to changes in the provided values, do Provider.of<Type>(context)
 * or use Consumer.of<Type>(context) for a localized change as opposed to
 * a widget-wide change
 * 
 * You can set listen: false when you only want to get data one time or
 * dispatch an action and not interested in the resulting changes
 * 
 * Use provider patterns for providing values that affect the whole application
 * or multiple widgets
 * 
 * Use stateful widgets if you only have state that affects a widget or two only
 */
//-------------------------------------------------------------------------
/**
 * User input
 * 
 * Scaffold.of(context) establishes a connection to the nearest Scaffold widget
 * .showSnackBar is an info pop up
 * 
 * showDialog() allows us to do the alert which pops up in situations like
 * confirming a deletion
 * showDialog has a builder parameter, AlertDialog is used most often
 */
/**
 * CircleAvatar's backgroundImage parameter takes a provider that yields an image
 * Instead of Image.network, use NetworkImage
 * Instead of Image.asset, use AssetImage
 */
//-------------------------------------------------------------------------
/**
 * Server Section Topics
 * Storing data & http
 * Sending http requests (store + fetch data)
 * Showing loading progress
 * Handling errors
 */
/**
 * Storing Data
 * 
 * On Device Storage
 * - will be destroyed when app is refreshed if not attached to something like SQLLite
 * - only available in your App for your user
 * - works offline
 * 
 * Web Server
 * - available for all users across different devices
 * - data persists across app restarts or reinstallments
 * - internet connection required
 */
/**
 * Connecting Flutter to a Database (on a server)
 * 
 * You don't directly connect your app to a database because it 
 * technically complex and insecure
 * 
 * You connect your app to a web server which then connects to the database
 * Then the database gives info to the web server and then web server
 * gives info to the app
 * 
 * Flutter/Dart cannot be used to create a web server, so we will use a free
 * service called Firebase which gives us a web server and an attached database
 */
/**
 * Http Requests
 * 
 * The server you're talking to decides which types of requests it's able to handle
 * The most common web server is a (REST) API for front end applications
 * The convention for sending requests is http endpoint (URL) + http verb = action
 * The most common request is the GET request to get data to be displayed (fetch data)
 * POST requests is to store/append data to the database
 * PATCH requests is to update data
 * PUT requests is to replace data
 * DELETE request is to delete data
 * Check the database's docs for other requests
 */
/**
 * Future is a core class in dart which builds an object which gives us a method (then method)
 * that allows us to define a function in the future once this action is done
 */
/** 
 * Futures and asynchronous code
 * 
 * asynchronous code is code that runs and might take a bit longer but doesn't stop
 * other code from continuing
 * result of the asynchronous code will be available in the future but not immediately
 * var result = 1 + 1; is available immediately
 * however, http.post(...) is not available immediately
 * once async function is done, flutter executes the .then() method
 * 
 * flutter has a Future class to handle this
 * say you have this small program
 * void main() {
 *  var myFuture = Future(() {
 *    return 'Hello';
 *  });
 *  print('This runs first');
 *  myFuture.then((result) => print ('---')).catchError((error) {});
 *  print('This runs before future');
 * }
 * 
 * myFuture.then() to register a function to be executed when the above is completed
 * 
 * say we have more lines of synchronous code
 * flutter will run all those lines of code and then check if the future is done
 * if future is done, then flutter calls the .then() function
 * even if the future is already done, dart doesn't care, it still continues with
 * all the other code
 * 
 * .then() always returns a new future
 * you can add another .then() to the initial .then(), concept is called chaining
 * 
 * you can catch an error by doing .catchError((error) {})
 * catchError also returns a future
 * 
 * Future: an object which waits for asynchronous operation to complete
 * and then (possibly) resolves some data
 * Asynchronous: code that isn't executed immediately but runs sometime
 * in the future. Other code continues execution. In other words, code that
 * executes whilst other code doesn't wait for it to finish
 * 
 * There is a more concise and readable syntax instead of .then() and .catchError()
 * Syntax is called async and await, can handle in a more elegant way
 * They work in exactly the same way
 */