# Why Objects


#### The world as it is today

Let us look at how the world exists without objects.

John and Kavita are two people who are writing some code.


John wants to calculate the area of a square. So he writes this fancy function.

```javascript
var areaOfSquare=function(square) {
  return square.length * square.length;
};

exports.areaOfSquare=areaOfSquare;
```

You can see that his function expects an object that has the length property in it. John being kind, shares his code by exporting his function.


Kavita comes along, finds that this is exactly what she needs and uses his function.

```javascript
let square={length:10};
console.log(areaOfSquare(square));

let tile={lenght:20};
console.log(areaOfSquare(tile));
```

Kavita is excited and runs her code, only to find that while the first square's area is calculated correctly, the second square, indicated by the variable tile, produces `NaN`.

```javascript
100
NaN
```

Observe closely and you will find that Kavita made a spelling mistake in the definition of tile and used `lenght` instead of `length`

She complains to John about this problem. But being more than just someone who complains, she comes up with a solution.

She writes the following function.

```javascript
var createSquare=function(length) {
  return {length:length};
}

exports.createSquare=createSquare;
```

This is beautiful! It works! Kavita is happy. For now. After a while, she discovers something interesting. She was writing some code and something strange happened. Here's what she wrote.


```javascript
var tile=createSquare(20);
var chocolate=createSquare(10);

var squares=[tile,chocolate];

console.log("The area of tile is",areaOfSquare(squares));
```

Observe this very closely. The `areaOfSquare` function expects an object whose `length` property is defined. `squares` is a list who has a `length` property.

Kavita wanted to pass `tile` to `areaOfSquare`, but she mistakenly passed `squares`. This worked because `squares` is a list and has the property length. Now this is a problem, because any object that has the property `length` can be passed to areaOfSquare and will be calculated. As long as that property is a number, the result will even seem sensible.

John and Kavita realise that one of the problems of functions is that when they operate on data, they expect the data to come from the outside. This is not safe. Anybody can pass anything.

Instead, what if there were a way where the data and the functions that operated on it stayed together. Even better, what if that function knew how to get the data it needed instead of relying on people to pass it the data.


#### We are in a bind!

Now that Kavita and John are in a [bind](https://www.merriam-webster.com/dictionary/bind), let us briefly take a detour to understand some aspects of Javascript.


[Function.prototype.bind](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_objects/Function/bind) is a function that can do very useful things. Assuming that you understand the concept of `this` in Javascript, bind is very easy to understand.

Consider this function:

```javascript
const areaOfSquare=function() {
  return this.length * this.length;
}
```

This function doesn't expect any input. Instead, it relies on the `this` object. It expects the `this` object to have the property length defined on it.

If we just call it, then it will try to use the length defined in a global object or where you are calling it from:

```javascript
var length=10;
console.log(areaOfSquare());
```

produces:

```javascript
100
```

This "`magic`" returns a valid value, in this case `100` because length has been defined on the global object. `areaOfSquare` tries to figure out what `this` means and uses the global object as `this`.

However, we can do something interesting with bind here.

```javascript
var tile={length:10};
var areaOfTile=areaOfSquare.bind(tile);

console.log(areaOfTile());
```

produces:

```javascript
100
```

This also works magically! How? The answer lies with bind. Bind ties the function `areaOfSquare` to the object `tile`. Bind then returns a new function, which in this case is assigned to `areaOfTile`. When `areaOfTile` is called, `this` refers to `tile` as it has been bound.

So, `bind` simply binds a function to a given object and when the function is called, all references to `this` in that function, will now point to the object.

Re-read this before you proceed.

#### Getting out of the bind

Kavita and John are still not sure how to fix the problem of a method expecting its arguments to have the property `length`. Having discovered `bind` however, they decide to try something.

```javascript
let tile=createSquare(10);
let areaOfTile=areaOfSquare.bind(tile);

console.log(areaOfTile());
```

produces

```javascript
100
```

Yay! This works. Or does it? Let us see.

Kavita can still bind a list to `areaOfSquare`.

```javascript
let numbers=[1,2,3];

let areaOfNumbers=areaOfSquare.bind(numbers);
console.log(areaOfNumbers());
```

produces

```javascript
9
```

Nothing prevents us from doing this. Which means, the behaviour `areaOfSquare` still doesn't have anything to do with a square. It simply works on a property called `length`.

This problem simply can't be solved unless we somehow ensure that the function `areaOfSquare` knows only about a square.
