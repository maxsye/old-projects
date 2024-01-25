//Program structure


//the let keyword means you are declaring a variable
let x = 1;

//var is similar to let, mostly does the same thing as let, used in pre-2015 JavaScript
var z = 3;

//const means the variable cannot be changed ever
const two = 2;

console.log(Math.max(2, 4)); // → 4
console.log(Math.min(2, 4) + 100); // → 102

//statements are executed from top to bottom

if (1 + 1 == 2) console.log("It's true"); // → It's true

//if statements

let theNumber = Number(prompt("Pick a number"));
if (!Number.isNaN(theNumber)) {
    console.log("Your number is the square root of " + theNumber * theNumber);
} else {
    console.log("Hey. Why didn't you give me a number?");
}

//while loop

let number = 0;
while (number <= 12) {
    console.log(number);
    number = number + 2;
}

//do loop: same as a while loop except that the body will execute at least once
//and starts testing whether it should stop after first execution

let yourName;
do {
    yourName = prompt("Who are you?");
} while (!yourName);
console.log(yourName);

//indentations are helpful but not required in javascript

//for loop
let result = 1;
for (let counter = 0; counter < 10; counter = counter + 1) {
    result = result * 2;
}
console.log(result);

//infinite for loop since there is no terminating condition
//for (let current = 20; ; current = current + 1) {}

//break has the effect of immediately jumping out of the enclosing loop

//switch statement
switch (prompt("What is the weather like?")) {
    case "rainy":
        console.log("Remember to bring an umbrella.");
        break;
    case "sunny":
        console.log("Dress lightly."); case "cloudy":
        console.log("Go outside.");
        break;
    default:
        console.log("Unknown weather type!");
        break;
}

//Use /* */ for block comments

