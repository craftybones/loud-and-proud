#### The magic of variable length arguments

Javascript lets us call function with any number of arguments. This seems powerful, but in order to make use of this ability, we need to know how many arguments have been passed and we need to be able to access them individually.

There are two ways to achieve this. One is to use the `arguments` object. The other is to use the `...` syntax. That isn't a spelling mistake. It is actually the [ellipsis](https://en.wikipedia.org/wiki/Ellipsis) operator.
