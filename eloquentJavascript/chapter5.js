//Higher-Order Functions


//Abstraction
//Abstraction hides details and give us the ability to talk about problems at a higher (abstract) level
/*
Put 1 cup of dried peas per person into a container. Add water until the peas are well covered. 
Leave the peas in water for at least 12 hours. Take the peas out of the water and put them in 
a cooking pan. Add 4 cups of water per person. Cover the pan and keep the peas simmering for 
two hours. Take half an onion per person. Cut it into pieces with a knife. Add it to the peas. 
Take a stalk of celery per person. Cut it into pieces with a knife. Add it to the peas. Take 
a carrot per person. Cut it into pieces. With a knife! Add it to the peas. Cook for 10 more 
minutes.
*/

/*
Per person: 1 cup dried split peas, half a chopped onion, a stalk of celery, and a carrot.

Soak peas for 12 hours. Simmer for 2 hours in 4 cups of water (per person). Chop and add 
vegetables. Cook for 10 more minutes.
*/
//The more abstract instruction set is the second recipe
//Try to notice when you are working at too low a level of abstraction (recipe 1)



//Functions that operate on other functions by taking them as an argument or returning them
//are known as higher-order functions

//A function that creates new functions
function greaterThan(n) {
    return m => m > n;
}
let greaterThan10 = greaterThan(10);
console.log(greaterThan10(11)); // → true

//A function that changes other functions
function noisy(f) {
    return (...args) => {
        console.log("calling with", args);
        let result = f(...args);
        console.log("called with", args, ", returned", result); return result;
    };
}
noisy(Math.min)(3, 2, 1);
// → calling with [3, 2, 1]
// → called with [3, 2, 1] , returned 1

//A function that provides new types of control flow
function unless(test, then) {
    if (!test) then();
}
let repeat = (3, n => {
    unless(n % 2 == 1, () => {
        console.log(n, "is even");
    });
});
// → 0 is even 
// → 2 is even

//Built in forEach method, executes a function on each array element
["A", "B"].forEach(n => console.log(n));
// → A
// → B

//Higher order functions shine in data processing
function map(array, transform) {
    let mapped = [];
    for (let element of array) {
        mapped.push(transform(element));
    }
    return mapped;
}
//runs a function on each item of the array and returns the array

function filter(array, test) {
    let passed = [];
    for (let element of array) {
        if (test(element)) {
            passed.push(element);
        }
    }
    return passed;
}
//runs a function on each item of the array that returns a boolean and returns the new array

function reduce(array, combine, start) {
    let current = start;
    for (let element of array) {
        current = combine(current, element);
    }
    return current;
}
//builds a value by repeatedly taking a single element from the array and combining it in
//some way (a function) to the current value
console.log(reduce([1, 2, 3, 4], (a, b) => a + b, 0)); // → 10

//built-in reduce function
console.log([1, 2, 3, 4].reduce((a, b) => a + b)); // → 10

//higher order functions shine when you need to compose operations
let horseShoe = "🐴👟"; 
console.log(horseShoe.length); // → 4
console.log(horseShoe[0]); // → (Invalid half-character) 
console.log(horseShoe.charCodeAt(0)); // → 55357 (Code of the half-character) 
console.log(horseShoe.codePointAt(0)); // → 128052 (Actual code for horse emoji)
//The charCodeAt method gives you a code unit, not a full character code
