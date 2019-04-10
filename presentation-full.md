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
hypotenuse : Float -> Float -> Float
hypotenuse a b =
  sqrt (square a + square b)

distance : (Float, Float) -> (Float, Float) -> Float
distance (a,b) (x,y) =
  hypotenuse (a - x) (b - y)

-- Anonymous functions
\a, b -> a + b
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
```

---

### Fabulous, functional, strong, assets typing


---

<small>
Elm has not the same concept of objects as Python.
In Elm, a type has constructors (like a class) but no methods and no getters or setters.
This gives us the following approximation :
</small>

<p class="left third">
<small><pre><code class="hljs elm">
type Shape = ShapeConstructor Int Int

let
    square = ShapeConstructor 2 2
in
    ...
</code></pre></small>
</p>

<p class="left third">
≈
</p>

<p class="right third">
<small><pre><code class="hljs python">
class Shape:
    def __init__(self, x, y):
        self.x, self.y = x, y

square = Shape(2, 2)
</code></pre></small>
</p>

---

But the compiler is really smart, so we can do things like this
```
type Shape = Shape Int Int

square = Shape 2 2
```

*`Shape` is a constructor AND and type*

---

A few things to get used to in Elm :

- No implicit casts. Never.
- Data is immutable
- *Every function is a single statement*

---

Custom data types are everything in Elm :
```
type Shape = Square Int | Rectangle Int | Circle Float

unit = Square 1
center = Circle 1.2
```

---

These types are really easy to match on
```
area : Shape -> Float
area shape =
    case shape of
        Square side -> Int.toFloat(side^2)
        Rectangle a b -> Int.toFloat(a*b)
        Circle radius -> radius * 3.14
```

<small><i>Types are a huge part of any Elm part.<br>
They should be at the root of the app design and mirror business logic.</i></small>

---

### The Elm Architecture

---

<small>Elm is built around a `Update > View` cycle, with a single source of truth : the model.</small>
<img src="assets/elm-architecture.svg" style="height:40vh;">

---

Minimal Elm app
```
type Model = Int
type Msg = Increase | Decrease

init = 0
update message model =
    case message of
        Increase -> model + 1
        Decrease -> model - 1
view model =
    div [] [ button [ onClick Increase ] [ text "+" ]
           , text (String.fromInt model)
           , button [ onClick Decrease ] [ text "-" ] ]
```
<small>Let's pick that example apart.</small>

---

# TODO List App

--- 

1. Make yourself a dedicated folder
2. Go to `github.com/eXenon/elm-presentation/`
3. Run the init command in the README
4. Open `src/main.elm` in your favorite editor

---

First, the most basic skeleton
```
module Main exposing (main)

import Browser

main = Browser.sandbox {init=init, view=view, update=update}
```

---

Decide on the model 
```
type Model = ?

init : Model
init = ?
```

---

Decide on a few basic actions and their effect on the model
```
type Msg = ?

update : Msg -> Model -> Model
update = ?
```

---

And render a basic model
```
import Html exposing (..)


view : Model -> Html
view = ?
```

---

Example at [https://exenon.github.io/elm-presentation/assets/example.html](https://exenon.github.io/elm-presentation/assets/example.html)

Code at [https://github.com/eXenon/elm-presentation](https://github.com/eXenon/elm-presentation/blob/master/example.elm)
