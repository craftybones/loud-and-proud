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
