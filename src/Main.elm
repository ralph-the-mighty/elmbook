module Main exposing (..)

import Browser
import Html exposing (Html, button, span, div, text, input, ul, li)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)



main = Browser.sandbox { init = init, update = update, view = view}


type alias Model = 
  { textfield: String
  , entries: List Entry
  , nextId: Int
  }

init : Model
init = {textfield = "", entries = [], nextId = 0}



type Msg
  = TextUpdate String
  | Add
  | Done Int
  | Remove Int


type alias Entry =
  { text: String
  , done: Bool
  , id: Int
  }

update : Msg -> Model -> Model
update msg model =
  case msg of
    TextUpdate newtextfield ->
      {model | textfield = newtextfield}
    Add ->
      {
        model | entries = (Entry model.textfield False model.nextId) :: model.entries 
              , nextId = model.nextId + 1
      }
    Done id ->
      {
        model | 
        entries = List.map (\ entry -> 
                                      if id == entry.id
                                      then {entry | done = True} 
                                      else entry) model.entries
      }
    Remove id -> {
      model | entries = List.filter (\ entry -> entry.id /= id) model.entries
      }




view : Model -> Html Msg
view model =
  div [] 
  [ input [ placeholder "Todo", value model.textfield, onInput TextUpdate] []
  , button [onClick Add] [text "Add"]
  , div []
    [ ul []
      (List.map (\ entry -> todoEntry entry) model.entries)
    ]
  ]


todoEntry : Entry -> Html Msg
todoEntry entry =
  li [] [
    div [] 
    [ span [style "text-decoration" (if entry.done then "line-through" else "none") ] [ text entry.text]
      , button [onClick (Done entry.id)] [text "Done"]
      , button [onClick (Remove entry.id)] [text "Remove"]
    ]
    
    ]



