### The many ways of function-ing

Javascript offers many ways of [invoking](http://www.dictionary.com/browse/invoke) a function. The most common way of course is to simply say its name and it shall show up. Just like a genie. But, sometimes, this common way doesn't work, because well, we have an uncommon situation.

Here are some situations:
* Not knowing how many arguments are passed into a function
* Needing to invoke a function with a different calling context(`this`)
* Needing a bound reference to a function that operates on a specific object

If you don't understand the above, that's alright. Let us try and understand the various ways of invoking functions in Javascript.

#### `call`

The `call` function has the following syntax in Javascript.

> _function.call(thisArg, arg1, arg2, ...)_

Consider this example:
```javascript
// Simple function to calculate the area of a square
var area=function() {
  return this.length * this.length;
}

// Different kinds of squares
var tile={length:10};
var chocolate={length:5};

// areas of different kinds of squares
var areaOfTile=area.call(tile);
var areaOfChocolate=area.call(chocolate)

console.log("Area of tile is",areaOfTile);
console.log("Area of chocolate is",areaOfChocolate);
```

produces

```javascript
Area of tile is 100
Area of chocolate is 25
```

This is very straightforward. The function `area` is being called first with `tile` as the calling context and in the second case, `chocolate` as the calling context. In other words, the `this` argument in both calls are `tile` and `chocolate` respectively. In fact, that is all call does. It simply invokes the function with the calling context provided as the first argument.

What about other arguments? Let us see.

```javascript
// Function to tell if a person is older than a given age
var isOlderThan=function(age) {
  return this.age>age;
}

// Two people
var john={age:15}; // John lives in a country where the voting age is 18
var kavita={age:21}; // Kavita lives in a country where the voting age is 20

// Are they of voting age?
var isJohnOfVotingAge=isOlderThan.call(john,18);
var isKavitaOfVotingAge=isOlderThan.call(kavita,20);

console.log("Is John eligible to vote:",isJohnOfVotingAge);
console.log("Is Kavita eligible to vote:",isKavitaOfVotingAge);
```

produces

```javascript
Is John eligible to vote: false
Is Kavita eligible to vote: true
```

This should be quite easy to understand. The second argument to `call` are simply `18` and `20` in each case respectively. Rememeber, `isOlderThan` takes a single argument, unlike `area` in the previous example. So, we need to pass the age argument as a part of `call`. Otherwise, the function will receive `undefined` as the argument and will return the value accordingly.
