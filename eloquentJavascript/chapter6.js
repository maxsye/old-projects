//The Secret Life of Objects


//Encapsulation
//Divide programs into smaller pieces and make each piece responsible for managing itself
//Common to put underscore at the start of private property names

//Methods are functions that are part of an object


function speak(line) {
    console.log(`The ${this.type} rabbit says '${line}'`);
}

let whiteRabbit = { type: "white", speak }; let hungryRabbit = { type: "hungry", speak };
whiteRabbit.speak("Oh my ears and whiskers, " + "how late it's getting!");
// → The white rabbit says 'Oh my ears and whiskers, how
// late it's getting!'

hungryRabbit.speak("I could use a carrot right now."); // → The hungry rabbit says 'I could use a carrot right now.'

//"this" is an extra parameter passed in a different way
//you can also use function.call(object, parameter, etc)
//the first parameter takes an object
speak.call(hungryRabbit, "Burp!");


//Prototypes
let empty = {};
console.log(empty.toString); // → function toString()...{} 
console.log(empty.toString()); // → [object Object]

//Most objects also have a prototype, an object that is a fallback source of properties
//When an object gets a request for a property is does not have, its prototype will be searched,
//then the prototype's prototype and so on

//The prototype of the empty object is the great ancestral prototype, Object.prototype
console.log(Object.getPrototypeOf({}) == Object.prototype); // → true 
console.log(Object.getPrototypeOf(Object.prototype)); // → null

//Functions derive from Function.prototype
//Arrays derive from Array.prototype
console.log(Object.getPrototypeOf(Math.max) == Function.prototype); // → true 
console.log(Object.getPrototypeOf([]) == Array.prototype); // → true

//You can use Object.create to create an object with a specific prototype

let protoRabbit = {
    speak(line) {
        console.log(`The ${this.type} rabbit says '${line}'`);
    }
};
let killerRabbit = Object.create(protoRabbit);
killerRabbit.type = "killer";
killerRabbit.speak("Hi!");
// → The killer rabbit says 'Hi!'

//The property of speak(line) is a shorthand way of defining a method
//The protoRabbit acts as a container for the properties shared by all rabbits
//The individual rabbit object contains properties that apply only to itself


//Classes
//JavaScript's prototype system can be interpreted as an informal take on classes
//Prototypes are useful for defining properties for which all instances share the same value

//To create an instance of a given class, you have to make an object that derives from the prototype
//but also that, itself, has the properties than instances of the class should have

//Constructor function
function makeRabbit(type) {
    let rabbit = Object.create(protoRabbit); 
    rabbit.type = type;
    return rabbit;
}

//if you put the keyword new in front of a function call, the function is treated as a constructor
//the prototype object used when constructing objects is found by taking to prototype property of the constructor function
function Rabbit(type) {
    this.type = type;
}
Rabbit.prototype.speak = function (line) {
    console.log(`The ${this.type} rabbit says '${line}'`);
};
let weirdRabbit = new Rabbit("weird");
//Constructors and all functions automatically get a property named prototype which by default holds a plain, empty object
//You can overwrite it with a new object or you can add properties to the existing object
//Common convention is to capitalize names of constructor functions

//Distinction between the way a prototype is associated with a constructor (through constructorName.prototype)
//and the way objects have a prototype (Object.getPrototypeOf)
console.log(Object.getPrototypeOf(Rabbit) == Function.prototype); // → true 
console.log(Object.getPrototypeOf(weirdRabbit) == Rabbit.prototype); // → true

//Class Notation
//Javascript classes are constructor functions with a prototype property
//Better notation
class Rabbit2 {
    constructor(type) {
        this.type = type;
    }
    speak(line) {
        console.log(`The ${this.type} rabbit says '${line}'`);
    }
}
let killerRabbit2 = new Rabbit("killer");
let blackRabbit = new Rabbit("black");

//class can be used both in statements
let object = new class { getWord() { return "hello"; } };
console.log(object.getWord()); // → hello

//overriding derived properties
Rabbit.prototype.teeth = "small"; //adding a private instance variable to Rabbit class named teeth
console.log(killerRabbit2.teeth); // → small
killerRabbit2.teeth = "long, sharp, and bloody";
console.log(killerRabbit2.teeth); // → long, sharp, and bloody 
console.log(blackRabbit.teeth); // → small 
console.log(Rabbit.prototype.teeth); // → small

//calling toString() on an array is similar to calling .join(",") on the array



//Maps
let ages = {
    Boris: 39,
    Liang: 22,
    Júlia: 62
};
console.log(`Júlia is ${ages["Júlia"]}`);
// → Júlia is 62
console.log("Is Jack's age known?", "Jack" in ages); // → Is Jack's age known? false
console.log("Is toString's age known?", "toString" in ages); // → Is toString's age known? true

//Object.keys and hasOwnProperty both ignore the object's prototype's attributes
console.log({ x: 1 }.hasOwnProperty("x")); // → true
console.log({ x: 1 }.hasOwnProperty("toString")); // → false



Rabbit.prototype.toString = function () {
    return `a ${this.type} rabbit`;
};
console.log(String(blackRabbit)); // → a black rabbit

//Symbols
//Property names can also be symbols, values created with the Symbol function
let sym = Symbol("name")
console.log(sym == Symbol("name")); // → false
Rabbit.prototype[sym] = 55;
console.log(blackRabbit[sym]); // → 55

const toStringSymbol = Symbol("toString");
Array.prototype[toStringSymbol] = function () {
    return `${this.length} cm of blue yarn`;
};
console.log([1, 2].toString()); // → 1,2
console.log([1, 2][toStringSymbol]()); // → 2 cm of blue yarn

//Can also set a symbol equal to an expression by doing what is shown below
let stringObject = {
    [toStringSymbol]() { return "a jute rope"; }
};

//Getters, setters, and static
class Temperature {
    constructor(celsius) {
        this.celsius = celsius;
    }
    get fahrenheit() {
        return this.celsius * 1.8 + 32;
    }
    set fahrenheit(value) {
        this.celsius = (value - 32) / 1.8;
    }
    static fromFahrenheit(value) {
        return new Temperature((value - 32) / 1.8);
    }
}

//Inheritance and iterator interface
class Matrix {
    constructor(width, height, element = (x, y) => undefined) {
        this.width = width; this.height = height; this.content = [];
        for (let y = 0; y < height; y++) {
            for (let x = 0; x < width; x++) {
                this.content[y * width + x] = element(x, y);
            }
        }
    }
    get(x, y) {
        return this.content[y * this.width + x];
    }
    set(x, y, value) {
        this.content[y * this.width + x] = value;
    }
}

class MatrixIterator {
    constructor(matrix) {
        this.x = 0;
        this.y = 0; this.matrix = matrix;
    }
    next() {
        if (this.y == this.matrix.height) return { done: true };
        let value = {
            x: this.x, y: this.y,
            value: this.matrix.get(this.x, this.y)
        };
        109
        this.x++;
        if (this.x == this.matrix.width) {
            this.x = 0;
            this.y++;
        }
        return { value, done: false };
    }
}

//The superclass
class SymmetricMatrix extends Matrix {
    constructor(size, element = (x, y) => undefined) {
        super(size, size, (x, y) => {
            if (x < y) return element(y, x);
            else return element(x, y);
        });
    }
    set(x, y, value) {
        super.set(x, y, value); if (x != y) {
            super.set(y, x, value);
        }
    }
}

//Instanceof
console.log(new SymmetricMatrix(2) instanceof SymmetricMatrix); // → true
console.log(new SymmetricMatrix(2) instanceof Matrix); // → true
console.log(new Matrix(2, 2) instanceof SymmetricMatrix); // → false
console.log([1] instanceof Array); // → true
//typeof returns the type, instanceof returns a boolean
