module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import List


main =
    Browser.sandbox { init = init, view = view, update = update }



-- Helpers


idToInt : TodoID -> Int
idToInt (TodoID id) =
    id


nextTodoID : TodoID -> TodoID
nextTodoID (TodoID id) =
    TodoID (id + 1)


descToStr : TodoDescription -> String
descToStr (TodoDescription desc) =
    desc



-- Model


type TodoID
    = TodoID Int


type TodoDescription
    = TodoDescription String


type Todo
    = Todo TodoID TodoDescription


type alias Model =
    { done : List Todo, open : List Todo, new : TodoDescription, next_id : TodoID }


type Msg
    = Closed TodoID
    | Opened TodoID
    | NewTodo String
    | Commit


initID : TodoID
initID =
    TodoID 0


init : Model
init =
    let
        id1 =
            initID

        id2 =
            nextTodoID initID

        id3 =
            nextTodoID id2
    in
    { done = [ Todo id1 (TodoDescription "Make todo App") ]
    , open = [ Todo id2 (TodoDescription "Learn Elm") ]
    , new = TodoDescription ""
    , next_id = id3
    }



-- Update


update : Msg -> Model -> Model
update msg model =
    case msg of
        Closed id_ ->
            let
                ( new_done_todos, remaining_open_todos ) =
                    List.partition (\(Todo id__ _) -> id__ == id_) model.open
            in
            { model | done = new_done_todos ++ model.done, open = remaining_open_todos }

        Opened id_ ->
            let
                ( new_opened_todos, remaining_done_todos ) =
                    List.partition (\(Todo id__ _) -> id__ == id_) model.done
            in
            { model | done = remaining_done_todos, open = new_opened_todos ++ model.open }

        NewTodo desc ->
            { model | new = TodoDescription desc }

        Commit ->
            { model
                | open = Todo model.next_id model.new :: model.open
                , next_id = nextTodoID model.next_id
                , new = TodoDescription ""
            }



-- View


checkbox : String -> Bool -> Msg -> Html Msg
checkbox desc checked_ msg =
    let
        style_ =
            if checked_ then
                [ style "text-decoration" "line-through"
                , style "color" "#aaa"
                ]

            else
                []
    in
    label
        style_
        [ input [ type_ "checkbox", checked checked_, onClick msg ] []
        , text desc
        ]


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ input [ onInput NewTodo, value (descToStr model.new) ] []
            , button [ onClick Commit ] [ text "Add new Todo" ]
            ]
        , text "TODOs"
        , div []
            [ ul [ style "list-style-type" "none" ]
                (List.map
                    (\(Todo id d) ->
                        li [] [ checkbox (descToStr d) False (Closed id) ]
                    )
                    model.open
                )
            ]
        , text "Closed"
        , div []
            [ ul [ style "list-style-type" "none" ]
                (List.map
                    (\(Todo id d) ->
                        li [] [ checkbox (descToStr d) True (Opened id) ]
                    )
                    model.done
                )
            ]
        ]
