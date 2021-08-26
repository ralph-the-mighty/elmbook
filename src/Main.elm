module Main exposing (..)

import Browser
import Html exposing (Html, button, div, text, input, ul, li)
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
    Done _ ->
      model




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



todoEntry i entry =
  li [] [
    div [] 
    [ text entry.text
      , button [onClick (Done i)] [text "done"]   
    ]
    
    ]