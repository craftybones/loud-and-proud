#### The magic of variable length arguments

Javascript lets us call function with any number of arguments. This seems powerful, but in order to make use of this ability, we need to know how many arguments have been passed and we need to be able to access them individually.

There are two ways to achieve this. One is to use the `arguments` object. The other is to use the `...` syntax. That isn't a spelling mistake. It is actually the [ellipsis](https://en.wikipedia.org/wiki/Ellipsis) operator.


#### Using `arguments`

Javascript has a special object called `arguments` available to you within all of your functions. This special object is automatically filled with all the values of the arguments that you passed. The `arguments` object is not an array.

Enough talking. Here is some magic
```javascript
const magic=function() {
  console.log("You entered",arguments.length,"arguments");
  for (var i = 0; i < arguments.length; i++) {
    console.log(i+1,arguments[i]);
  }
}

magic('a');
console.log("--");
magic("hello","world");
console.log("--");
magic(10,9,8);
```

produces

```javascript
You entered 1 arguments
1 'a'
--
You entered 2 arguments
1 'hello'
2 'world'
--
You entered 3 arguments
1 10
2 9
3 8
```

Wow! That really is some magic. This function knows everything about the arguments you passed! As you can see, this is useful. `arguments` has some other features that you can read about in detail [here](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/arguments).

The one important thing to note here is that the `arguments` object is not an `Array`. Therefore you may not do things with it like you can with arrays. No `map`, `filter` or `slice` for instance. The above link should detail this.

#### Using `...`
