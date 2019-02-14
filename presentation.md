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

<small>
Syntax is very minimalistic
</small>
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
```

---

<small>
If statements need a `then` and accept `else` and `else if`.<br>
Case statements combine `if` structures and variable destructuring.
</small>

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

<small>Records are a the equivalent of structs or dataclasses</small>

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

<small>
Functions are the core elements of Elm.<br>
Functions have (optional) type annotations.<br>
They allow destructuring directly in the arguments.
</small>
```
square : Float -> Float
square n =
  n^2

hypotenuse : Float -> Float -> Float
hypotenuse a b =
  sqrt (square a + square b)

distance : (Float, Float) -> (Float, Float) -> Float
distance (a,b) (x,y) =
  hypotenuse (a - x) (b - y)
```

---

<small>A few more</small>

```
-- The |> (pipe) operator is used to chain functions
viewNames2 names =
  names
    |> List.sort
    |> String.join ", "

-- The let keyword allows to declare variables
let
  twentyFour =
    3 * 8
in
twentyFour + 15

-- Elm has a rich module system
import List exposing (..)
```

---

A few niceties of Elm

- Every function is a single statement
- Data is immutable
- No implicit casts. Never.
- No objects, no classes (and no typeclasses).

---

### Functional, strong, static, fabulous, typing

---

<small>
Elm has not the same concept of objects as Python.
In Elm, a type has constructors (like a class) but no methods and no getters or setters.
This gives us the following approximation :
</small>

<div class="left half">
```
type Shape = ShapeConstructor Int Int

let
    square = Shape 2 2
in
    ...
```
</div>

<div class="right">
=
</div>

<div class="right half">
class Shape:
    def __init__(self, x, y):
        self.x, self.y = x, y

square = Shape(2, 2)```
```
</div>
