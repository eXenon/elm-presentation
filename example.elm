module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import List


main =
    Browser.sandbox { init = init, view = view, update = update }



-- Helper


popAtIndex : List a -> Int -> List a -> ( Maybe a, List a )
popAtIndex l i rem =
    case ( i, l ) of
        ( 0, h :: t ) ->
            ( Just h, rem )

        ( _, [] ) ->
            ( Nothing, rem )

        ( _, h :: t ) ->
            popAtIndex t (i - 1) (rem ++ [ h ])



-- Model


type Todo
    = Todo String


type alias Model =
    { done : List Todo, open : List Todo }


type Msg
    = Closed Int
    | Opened Int
    | Add String


init : Model
init =
    { done = [ Todo "Make todo App" ], open = [ Todo "Learn Elm" ] }



-- Update


update : Msg -> Model -> Model
update msg model =
    case msg of
        Closed idx ->
            let
                ( closed_todo, open ) =
                    popAtIndex model.open idx []
            in
            case closed_todo of
                Nothing ->
                    model

                Just t ->
                    { model | done = t :: model.done, open = open }

        Opened idx ->
            let
                ( opened_todo, done ) =
                    popAtIndex model.done idx []
            in
            case opened_todo of
                Nothing ->
                    model

                Just t ->
                    { model | done = done, open = t :: model.open }

        Add description ->
            { model | open = Todo description :: model.open }



-- View


checkbox : String -> Bool -> Msg -> Html Msg
checkbox desc checked_ msg =
    let
        style_ =
            if checked_ then
                [ style "padding" "20px"
                , style "text-decoration" "line-through"
                , style "color" "#aaa"
                ]

            else
                [ style "padding" "20px" ]
    in
    label
        style_
        [ input [ type_ "checkbox", checked checked_, onClick msg ] []
        , text desc
        ]


view : Model -> Html Msg
view model =
    div []
        [ text "TODOs"
        , div []
            [ ul []
                (List.indexedMap
                    (\i (Todo d) ->
                        li [] [ checkbox d False (Closed i) ]
                    )
                    model.open
                )
            ]
        , text "Closed"
        , div []
            [ ul []
                (List.indexedMap
                    (\i (Todo d) ->
                        li [] [ checkbox d True (Opened i) ]
                    )
                    model.done
                )
            ]
        ]
