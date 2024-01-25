//Data structures: objects and array


//Arrays
let x = "this"
let listOfNumbers = [2, 3, 5, 7, 11];
console.log(listOfNumbers[2]); // → 5
console.log(listOfNumbers.length); // → 5

//typeof
let doh = "Doh";
console.log(typeof doh.toUpperCase); // → function 
console.log(doh.toUpperCase()); // → DOH

//Manipulating array using push and pop (stack)
let sequence = [1, 2, 3];
sequence.push(4);
sequence.push(5);
console.log(sequence); // → [1, 2, 3, 4, 5] 
console.log(sequence.pop()); // → 5 
console.log(sequence); // → [1, 2, 3, 4]

//Objects
let day1 = {
    squirrel: false,
    events: ["work", "touched tree", "pizza", "running"]
};
console.log(day1.squirrel); // → false 
console.log(day1.wolf); // → undefined
day1.wolf = false; //can assign a value to a property (attribute variable) or create a new property
console.log(day1.wolf); // → false

//Deleting a property
let anObject = { left: 1, right: 2 };
console.log(anObject.left); // → 1
delete anObject.left;
console.log(anObject.left); // → undefined
console.log("left" in anObject); // → false
console.log("right" in anObject); // → true
//Setting a property to undefined means that object still has the property, just without a value
//Delete means the property is no longer present and in function will return false

//Finding the keys (attribute variable names) of an object
console.log(Object.keys({ x: 0, y: 0, z: 2 })); // → ["x", "y", "z"]

//Copying properties of one object into another
let objectA = { a: 1, b: 2 };
Object.assign(objectA, { b: 3, c: 4 });
console.log(objectA); // → {a: 1, b: 3, c: 4}

//Arrays are a kind of object for storing sequences of things
//Numbers, string, and booleans are immutable (cannot be changed)
//However, you can change object properties

let object1 = { value: 10 };
let object2 = object1;
let object3 = { value: 10 };
console.log(object1 == object2); // → true
console.log(object1 == object3); // → false
object1.value = 15; console.log(object2.value); // → 15 
console.log(object3.value); // → 10

//Using const when creating objects
const score = { visitors: 0, home: 0 };
// This is okay
score.visitors = 1;
// This isn't allowed: score = {visitors: 1, home: 1};
//You can change property values but not the whole object memory location

//Curly braces mean you are declaring an object

//For loops and for each loops
let JOURNAL = [1, 2, 3, 4, 5];
for (let i = 0; i < JOURNAL.length; i++) {
    let entry = JOURNAL[i];
    // Do something with entry
}

for (let entry of JOURNAL) {
    console.log(entry);
}


//More array functions
JOURNAL.shift(); //removes first element of array and returns it
JOURNAL.unshift(1); //inserts the parameter at the start of the list
console.log([1, 2, 3, 2, 1].indexOf(2)); // → 1
console.log([1, 2, 3, 2, 1].lastIndexOf(2)); // → 3
//.slice is like substring in java, start index in inclusive, end index is exclusive
//If only one parameter is present, slice will take all elements after start index
console.log([0, 1, 2, 3, 4].slice(2, 4)); // → [2, 3]
console.log([0, 1, 2, 3, 4].slice(2));// → [2, 3, 4]
let another = [2, 3];
console.log(JOURNAL.concat(another)); // → [1, 2, 3, 4, 5, 2, 3]
//If you pass concat an argument that is not an array, the value will be added as if it were a one-element array


//String functions

console.log("coconuts".slice(4, 7)); // → nut
console.log("coconut".indexOf("u")); // → 5
//A string's indexOf can search for a string containing more than one character
//Whereas the array's indexOf can only search for a single element
console.log("one two three".indexOf("ee")); // → 11
//Trim removes whitespace
console.log(" okay \n ".trim()); // → okay
//padStart adds zeroes in front of the string until string is a certain length
console.log(String(6).padStart(3, "0")); // → 006
//split and join functions
let sentence = "Birds specialize in stomping";
let words = sentence.split(" ");
console.log(words); // → ["Birds", "specialize", "in", "stomping"] 
console.log(words.join(". ")); // → Birds. specialize. in. stomping
console.log("a".repeat(3)); // → aaa
let string = "abc";
console.log(string.length); // → 3  
console.log(string[1]); // → b

//To allow function to accept any number of arguments do ... in front of parameter
function max(...numbers) {
    let result = -Infinity;
    for (let number of numbers) {
        if (number > result) result = number;
    }
    return result;
}
console.log(max(4, 1, 9, -2)); // → 9
//You can also call a function with an array of arguments by using ...
//This is known as spreading the array into the function call, passing elements as separate arguments
let numbers = [5, 1, 7];
console.log(max(...numbers)); // → 7


//The Math object provides a namespace so that all these functions and values do not take up potential variable names
//The more names taken, the more likely you are to overwrite it
//Math.floor(num), Math.random(). Math.ceil(num), Math.abs(num), Math.round(num) are useful functions

//To create variables for a function being passed an array, we can do this
function phi([n00, n01, n10, n11]) {
    return (n11 * n00 - n10 * n01) /
        Math.sqrt((n10 + n11) * (n00 + n01) * (n01 + n11) * (n00 + n10));
}
//instead of 
function phi1(table) {
    return (table[3] * table[0] - table[2] * table[1]) /
        Math.sqrt((table[2] + table[3]) * (table[0] + table[1]) * (table[1] + table[3]) * (table[0] + table[2]));
}


//JSON
//Objects and arrays are stored in the computer's memory as sequences of bits holding the 
//addresses of their contents, not the actual content

//If you want to save data in a file or send it to another computer, you have to convert these
//memory addresses to a description that can be stored or sent

//We can serialize the data, converted the data into a flat description called JSON (JavaScript Object Notation)

//JSON is similar to JavaScript's way to creating arrays and objects, with some caveats
//All property names have to be surrounded by double quotes
//Only simple data expressions are allowed - no functions calls, variables, or anything with computation
//Comments are not allowed in JSON

//Sample JSON entry
//{
//    "squirrel": false,
//    "events": ["work", "touched tree", "pizza", "running"]
//}

//Use JSON.stringify and JSON.parse to convert data to and from this format

let string2 = JSON.stringify({squirrel: false, events: ["weekend"]});
console.log(string2); // → {"squirrel":false,"events":["weekend"]} 
console.log(JSON.parse(string2).events); // → ["weekend"]

