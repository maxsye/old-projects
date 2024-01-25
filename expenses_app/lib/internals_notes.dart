//There are 3 trees in Flutter, the Widget Tree, the Element Tree, and the Render Tree
//The Widget tree is changed by you, and the other trees change based on the Widget Tree
//The Widget tree rebuilds frequently while the others don't
//The element tree links the Widget Tree (the code) and the Render Tree (what is actually displayed)
//When MediaQuery changes, like if the orientation changes, build is called for that thing that is 
//using the MediaQuery
//Calling build doesn't mean the whole app is rebuilt, only the changed parts
//----------------------------------------------------------------------------------------------
//Readability
//Should be able to maintain and change the code
//Others should be able to understand my code and be able to change it
//Using builder methods can improve readability, have each builder method return a widget, reduces
//build method size

//Performance
//Certain practices can improve app performance
//Missing possible improvements doesn't automatically result in slow app
//Always re-evaluate your code, explore new best practices


//Widget lifecycles
//Stateless widgets - constructor function to build()
//Stateful widgets - constructor function to initState() to build() to setState(), didUpdateWidget()
//to build(), dispose()
//This initState() method will be called automatically, the name is reserved
//didUpdateWidget() is in the state object which is triggered when the widget that belongs to that state
//was updated
//dispose() is executed when the widget is removed and not rebuilt
//These methods do not need to be explicitly added

//initState() is used for fetching some initial data you need before building
//the stateful widget

//didUpdateWidget() is used less often, but is used for refetching data due
//to a change in the stateful widget

//dispose() is gret for cleaning up data, ex. when a user leaves an app,
//you close up their data to prevent data leaks


//App lifecycle
//Inactive - App is inactive, no user input received
//Paused - App is not visible to user, running in background
//Resumed - App is visible and responding to user input
//Suspending - When app is about to be suspended (exited)

//To test this, we will add a mix in in _MyHomePageState class
//Bit like a class and extending one, but your class isn't based on mix in
//but rather you add methods and properties without fully inheriting the class
//We add WidgetsBindingObserver to the MyHomePage class
//This new class brings a method called void didChangeAppLifecycleState
//and we override it by doing 
//void didChangeAppLifecycleState(AppLifecycleState state) {
//  etc.
//}


/**
 * Context
 * Each widget has its own context attached to it
 * Meta information on the widget and its location in the widget tree
 * Contexts build a skeleton of the widget tree
 * Context is a communication channel for passing data between widgets
 * Really useful to flutter, it allows flutter to establish a direct
 * communication channel behind the scenes to exchange data between widgets
 */
/**
 * Inherited Widget
 * To manually pass down ThemeData and MediaQueryData would be cumbersome in
 * nested widgets
 * Flutter gives us a special widget, the InheritedWidget
 * You get a direct tunnel to InheritedWidget
 * MediaQuery.of(context).etc is an example of this
 */
/**
 * Keys
 * Since the state is attached to the elements tree instead of the widget tree,
 * things can go wrong sometimes
 * For example, if we have two stateful widgets in a list, one on top of the 
 * other, and we delete the first one, the second stateful widget will take
 * the state of the first widget, it will take its properties
 * This is because flutter checks the widget tree and the element tree and see
 * if they correspond
 * When widget 1 is deleted, widget 2 moves up to take its place, so when
 * flutter checks to see if the widget tree and element tree correspond for
 * widget 1, the widget is rendered, however widget 2 takes widget 1's state
 * Then, when flutter checks if the two trees correspond for the second widget,
 * the widget of widget 2 isn't there because it moved up, but the state of
 * widget 2 is still there
 * Since they don't correspond widget 2's state is deleted, causing an error
 * 
 * Therefore, we use key to identify the widget and its state
 * Unique key isn't good if the class rebuilds often
 * 
 * ListView with Stateful children scenario is where you need keys, only rarely
 * do you need keys
 * Flutter matches the trees through the type of the widget and it works 99% of
 * the time
 */
/**
 * Summary
 * A lot of behind the scene content covered
 * Should help you write more readable code, understand how things work
 * internally, and avoid bugs (ListView and Stateful combo)
 */