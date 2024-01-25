//Functions

const square = function (x) {
    return x * x;
};

console.log(square(12)); // → 144

const power = function (base, exponent) {
    let result = 1;
    for (let count = 0; count < exponent; count++) {
        result *= base;
    }
    return result;
};

//For variables declared outside of any function or block,
//the scope is the whole program
//These variables are called global

//Variables created inside a function are known as local
//and can only be referenced inside the function

//Declaring a variable by doing var x = 2 allows x to be global

//Local variables override global variables with the same name

//Can also declare a function this way

function squareNum(x) {
    return x * x;
}

//Can also declare this way
const powerNum = (base, exponent) => {
    let result = 1;
    for (let count = 0; count < exponent; count++) {
        result *= base;
    }
    return result;
};

//These two lines are equivalent, other than having different function names
const square1 = (x) => { return x * x; };
const square2 = x => x * x;

//If you have no parameters
const horn = () => {
    console.log("Toot");
};

//In Javascript, if you pass too many arguments to a function, the extra ones are ignored
//If you pass too few, the missing parameters are assigned the value of undefined
//Downside if that you'll accidentally pass the wrong number of arguments and no error will show
//Upside is function can be called with many arguments 
function minus(a, b) {
    if (b === undefined) return -a;
    else return a - b;
}
console.log(minus(10)); // → -10 
console.log(minus(10, 5)); // → 5

//To create a default value for a parameter for a function when a value is not provided
function powerDefault(base, exponent = 2) {
    let result = 1;
    for (let count = 0; count < exponent; count++) {
        result *= base;
    }
    return result;
}
console.log(power(4)); // → 16 
console.log(power(2, 6)); // → 64


//this function below returns an anonymous function which returns local

function wrapValue(n) {
    let local = n;
    return () => local; //could be rewritten as return local;
}

let wrap1 = wrapValue(1);
let wrap2 = wrapValue(2);
console.log(wrap1()); // → 1
console.log(wrap2()); // → 2

//Local variables are created anew when instantiated
//Different calls can't trample on one another's local variables
//A function that references other functions is called a closure

function multiplier(factor) {
    return number => number * factor; //returns a function that takes a parameter named number
}
let twice = multiplier(2);
console.log(twice(5)); // → 10
console.log(multiplier(3)); // → [Function]


//Recursion, a function calling itself
//Functions are divided into two categories, those called for their side effects and those called for return value
//Side effect is something like printing a line
//Pure function is a value producing function that doesn't rely on side effects and doesn't have side effects


//Summary
// Define f to hold a function value
const f = function (a) {
    console.log(a + 2);
};
// Declare g to be a function
function g(a, b) {
    return a * b * 3.5;
}
// A less verbose function value
let h = a => a % 3;