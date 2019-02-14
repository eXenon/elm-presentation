---
title: Elm Workshop
revealOptions:
    transition: 'none'
    slideNumber: true
---
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
<h1>Elm Workshop</h1>

---

### What we will do today

1. Elm Syntax
2. A few concepts of FP
3. A few concepts of strong typing
4. The Elm Architecture
5. Example : simple todo-list

---

### Elm Syntax

Syntax is very minimalistic
```
-- Comment
{-
Multi-line comment
-}

-- Boolean
True  : Bool
False : Bool

42    : number  -- Int or Float depending on usage
3.14  : Float

'a'   : Char
"abc" : String

-- multi-line String
"""
This is useful for holding JSON or other
content that has "quotation marks".
"""
```

---

If statements need a `then` and accept `else` and `else if`.

Case statements combine `if` structures and variable destructuring.

```
if key == 40 then
    n + 1

else
    n

case n of
  0 -> 1
  1 -> 1
  _ -> fib (n-1) + fib (n-2)
```

---

Records are a the equivalent of structs or dataclasses

```
-- create records
origin = { x = 0, y = 0 }
point = { x = 3, y = 4 }

-- access fields
origin.x == 0
point.x == 3

-- field access function
List.map .x [ origin, point ] == [ 0, 3 ]

-- update many fields
{ point | x = point.x + 1, y = point.y + 1 }
```

---

Functions are the core elements of Elm.

They allow destructuring directly in the arguments.
```
square n =
  n^2

hypotenuse a b =
  sqrt (square a + square b)

distance (a,b) (x,y) =
  hypotenuse (a - x) (b - y)
```
