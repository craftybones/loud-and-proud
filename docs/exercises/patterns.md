#### Text based patterns

The aim of this exercise is to develop a library that can generate text based geometric patterns. There are several problems in this exercise. Do them one by one. As you attempt each, you might realise better ways of solving these.


**1. Filled Rectangle**

Generate a filled rectangle of MxN dimension. Additionally the user should be able to specify the character used to fill the rectangle.
<pre>
// 1 x 1, *
*

// 2 x 1, *
**

// 1 x 2, +
+
+

// 2 x 2, -
--
--

// 20 x 7, A
AAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAA
</pre>

----

**2. Hollow Rectangle**

Generate a hollow rectangle of MxN dimension. Additionally the user should be able to specify the character that outlines the rectangle.

<pre>
// 1 x 1, *
*

// 2 x 1, *
**

// 1 x 2, +
+
+

// 2 x 2, -
--
--

// 3 x 3, *
***
* *
***

// 20 x 7, +
++++++++++++++++++++
+                  +
+                  +
+                  +
+                  +
+                  +
++++++++++++++++++++
</pre>
----

**3. Cyclical Lines**

Generate N lines of length M. The text used to generate the line should be cycled through a list of characters

<pre>
// 3 x 1,+,-
+
-
+

// 2 x 4,+,-
++++
----

// 3 x 3, +,-,*
+++
---
***

// 5 x 3, +,-,*
+++
---
***
+++
---

// 4 x 1, +
+
+
+
+

</pre>

**4. Left Aligned Triangle**

Generate a left-aligned right angled triangle of size N as follows:

<pre>
// 2,-
-
--

// 3,+
+
++
+++

// 6, *
*
**
***
****
*****
******

</pre>

**5. Right Aligned Triangle**

Generate a right-aligned right angled triangle of size N as follows:

<pre>
// 2,-(the empty line below is simply to differentiate. Your output should not contain it)

 -
--

// 3,+(the empty line below is simply to differentiate. Your output should not contain it)

  +
 ++
+++

// 6, * (the empty line below is simply to differentiate. Your output should not contain it)

     *
    **
   ***
  ****
 *****
******

</pre>
