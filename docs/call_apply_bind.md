### The many ways of function-ing

Javascript offers many ways of [invoking](http://www.dictionary.com/browse/invoke) a function. The most common way of course is to simply say its name and it shall show up. Just like a genie. But, sometimes, this common way doesn't work, because well, we have an uncommon situation.

Here are some situations:
* Not knowing how many arguments are passed into a function
* Needing to invoke a function with a different calling context(`this`)
* Needing a bound reference to a function that operates on a specific object

If you don't understand the above, that's alright. Let us try and understand the various ways of invoking functions in Javascript.

----
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

Of course this will work with more than one argument too.

```javascript
// A function that evaluates if a person is within a specified age range
var isAgeBetween=function(lowerLimit,upperLimit) {
  return lowerLimit<=this.age && this.age<=upperLimit;
}

// Two people
var john={age:15};
var kavita={age:21};

// Are they teenagers?
var isJohnATeenager=isAgeBetween.call(john,13,19);
var isKavitaATeenager=isAgeBetween.call(kavita,13,19);

console.log("John is a teenager:",isJohnATeenager);
console.log("Kavita is a teenager:",isKavitaATeenager);
```

As you can see, `call` can work when the function being called accepts more than one argument as well.

----

#### `apply`

If you understood `call` above, then `apply` is going to be incredibly easy.

Its signature is:

> _function.apply(thisArg, [argsArray])_

You will see that the only difference in this function signature is that `apply` accepts only two arguments. If you remember, `call` accepts any number of arguments.

You will also see that the first argument is a `thisArg`.

In fact, the only difference is that `apply` expects an array of arguments. That is it. The rest of it is exactly the same.

Let us use a previous example.

```javascript
// Simple function to calculate the area of a square
var area=function() {
  return this.length * this.length;
}

// Different kinds of squares
var tile={length:10};
var chocolate={length:5};

// areas of different kinds of squares
var areaOfTile=area.apply(tile);
var areaOfChocolate=area.apply(chocolate)

console.log("Area of tile is",areaOfTile);
console.log("Area of chocolate is",areaOfChocolate);
```
produces

```javascript
Area of tile is 100
Area of chocolate is 25
```

This works *exactly* as `call`. No differences when the function takes no arguments. Let us now try the second example from `call` but with `apply` instead.

```javascript
// Function to tell if a person is older than a given age
var isOlderThan=function(age) {
  return this.age>age;
}

// Two people
var john={age:15}; // John lives in a country where the voting age is 18
var kavita={age:21}; // Kavita lives in a country where the voting age is 20

// Are they of voting age?
var isJohnOfVotingAge=isOlderThan.apply(john,18);
var isKavitaOfVotingAge=isOlderThan.apply(kavita,20);

console.log("Is John eligible to vote:",isJohnOfVotingAge);
console.log("Is Kavita eligible to vote:",isKavitaOfVotingAge);
```

If you try running this, you will see something like this:

```javascript
TypeError: CreateListFromArrayLike called on non-object
```

What is happening here? Remember, `apply` expects an _**array**_ of arguments.

All we have to do is change the lines where we apply the function to read as follows:

```javascript
var isJohnOfVotingAge=isOlderThan.apply(john,[18]);
var isKavitaOfVotingAge=isOlderThan.apply(kavita,[20]);
```
and everything will work as expected. We have now used `apply` by passing `18` and `20` inserted into arrays.

All this is very fine, but does `apply` *really* have a use case beyond what is shown?

Turns out it does.


#### A good usage of `apply`

Consider a series of tests on `isOdd`

```javascript
const testEvenPositiveNumbers=function() {
  assert.equal(false,isOdd(2))
}

const testEvenPositiveNumbers=function() {
  assert.equal(true,isOdd(1))
}

const testEvenNegativeNumbers=function() {
  assert.equal(false,isOdd(-2))
}

const testEvenNegativeNumbers=function() {
  assert.equal(true,isOdd(-1))
}

const testZero=function() {
  assert.equal(true,isOdd(0))
}
```

This is fine, but it is too involved. All the functions are simply asserting against different expectations and arguments.

What if we write a generic function that can test anything?

```javascript
const testAnything=function(msg,expectation,fnName,argument) {
  console.log(msg);
  assert.equal(expectation,fnName(argument));
}

var tests=[
  {msg:"even positive numbers",expectation:false,fnName:isOdd,argument:2},
  {msg:"odd positive numbers",expectation:true,fnName:isOdd,argument:1},
  {msg:"even negative numbers",expectation:false,fnName:isOdd,argument:-2},
  {msg:"odd positive numbers",expectation:true,fnName:isOdd,argument:-1},
  {msg:"zero",expectation:true,fnName:isOdd,argument:0}
];

tests.forEach(function(test){
  testAnything(test.msg,test.expectation,test.fnName,test.argument);
});
```

Wow! This is sweet! We have a function that we can now use to test any suite of tests for any function. Kind of. This above solution is somewhat nicer than what we had before. We will a runtime report of what is happening because of the console logs. It is also much shorter.

But the function name is `testAnything`. Is this really true? Can this really test anything?

What if instead of `isOdd`, we had the function `greaterOf` which returns the greater of two numbers?

Our `testAnything` won't work. It expects all functions to have only one argument. This is an unrealistic and limiting expectation. Clearly `testAnything` isn't yet capable of testing anything.

So what would we need to be able to test anything. We would need some manner to call a function with any number of arguments. We just learned `call` and `apply`. Maybe we can use one of those.

Which one though? Will `call` work? Let us see.

```javascript
const testAnything=function(msg,expectation,fnName,arg1,arg2) {
  console.log(msg);
  let actual=fnName.call(arg1,arg2);
  assert.equal(expectation,fnName(argument));
}
```

This won't work, will it? What if we have 3 arguments instead of 2? What about 5? The problem with `call` is that it requires us to know exactly how many arguments to call when we *write* the function. However, in this case, we need a manner to apply a variable number of arguments at *runtime*.

Well, what about `apply`? Maybe it will work, but before we try that, we also have one more thing to take care of. Our `testAnything` also currently accepts a fixed number of arguments. We need it to accept a variable number of arguments.

Read about [how this is done](varargs) if you don't know it already.

Let us see.
```javascript
const testAnything=function(msg,expectation,fnName,) {
  console.log(msg);
  let actual=fnName.call(arg1,arg2);
  assert.equal(expectation,fnName(argument));
}
```
