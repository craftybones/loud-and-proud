> _But `this` is preposterous!<br/>Yes, it is._

#### What is `this`?

`this` is a reference to some object. What does that mean? It means that `this` is not something that has an intrinsic value.

Consider
```javascript
let a=5;
```

`a=5` in the above example tells us that `a` has a value of `5`. Unlike `a`, `this` doesn't have a value of its own. Instead, it is simply a reference to some other object in memory.

#### The global object

The best way to understand `this` is to simply try a few things out. Open a node repl and simply type in `this` and press enter. What do you get? You should get a screenful of strange things. These strange things are key value pairs, much like any other object. You might get something like this

![global object](loud-and-proud/assets/images/global_object.png)


#### Calling context
