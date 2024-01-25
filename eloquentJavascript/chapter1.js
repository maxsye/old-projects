//Values, types, and operators

//Semicolons are not needed as Javascript has semicolon insertion
//However, for simplicity's sake, many developers simply pretend semicolon insertion doesn't exist

//Three special values in JS that are considered numbers but don't behave like numbers
console.log(Infinity); // → Infinity 
console.log(-Infinity); // → -Infinity 
console.log(NaN); //stands for "not a number", returned in cases such as 0 / 0

console.log(`This is using a template literal to concatenate a string and number (${100 / 2})`);
//The template literal must be inside the backtick marks (`) not quotation marks (") or (')

console.log(typeof 4.5); // → number 
console.log(typeof "x"); // → string
console.log(- (10 - 2)); // → -8

console.log(3 > 2); // → true 
console.log(3 < 2); // → false

//Upper case letters are always less than lowercase ones, "Z" < "a"
console.log("Aardvark" < "Zoroaster") // → true

//Only one value in Javascript that is not equal to itself
console.log(NaN == NaN); // → false

//&& stands for and, || stands for or, ! stands for not
//|| has lowest precedence, then &&, then comparison operators (>, ==, <), then the rest

//? and : are called ternary operators
console.log(true ? 1 : 2); // → 1
console.log(false ? 1 : 2); // → 2

//Empty values and null and undefined, the difference in meaning doesn't matter most of the time
console.log(null);
console.log(undefined);

//Javascript has automatic type conversion which is really useful
console.log(8 * null) // → 0
console.log("5" - 1) // → 4
console.log("5" + 1) // → 51 
console.log("five" * 2) // → NaN
console.log(false == 0) // → true
console.log(null == undefined); // → true
console.log(null == 0); // → false

//Since expressions like false == 0 and "" == false are true because of type conversion, to test
//if a value to precisely equal to another value use ===
console.log(false === 0); // → false

// || will convert the value on their left side to boolean type, if this conversion 
//is false, then it will return the value on the right
console.log(null || "user") // → user
console.log("Agnes" || "user") // → Agnes

// && will convert the value on their left side to boolean type, if this conversion 
//is false, then it will return the value on the left
console.log(null && "user") // → null