module Main exposing (..)

import Browser
import Html exposing (Html, button, span, div, text, input, ul, li)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)



main = Browser.sandbox { init = init, update = update, view = view}


type alias Model = 
  { textfield: String
  , entries: List Entry
  }

init : Model
init = {textfield = "", entries = []}



type Msg
  = TextUpdate String
  | Add
  | Done Int


type alias Entry =
  { text: String
  , done: Bool
  }

update : Msg -> Model -> Model
update msg model =
  case msg of
    TextUpdate newtextfield ->
      {model | textfield = newtextfield}
    Add ->
      {model | entries = (Entry model.textfield False) :: model.entries }
    Done index ->
      {
        model | 
        entries = List.indexedMap (\ i entry -> 
                                      if i == index 
                                      then {entry | done = True} 
                                      else entry) model.entries
      }




view : Model -> Html Msg
view model =
  div [] 
  [ input [ placeholder "Todo", value model.textfield, onInput TextUpdate] []
  , button [onClick Add] [text "Add"]
  , div [] [text model.textfield]
  , div []
    [ ul []
      (List.indexedMap (\ i entry -> todoEntry i entry) model.entries)
    ]
  ]


todoEntry : Int -> Entry -> Html Msg
todoEntry i entry =
  li [] [
    div [] 
    [ span [style "text-decoration" (if entry.done then "line-through" else "none") ] [ text entry.text]
      , button [onClick (Done i)] [text "done"]
    ]
    
    ]



