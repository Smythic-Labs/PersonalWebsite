module Navbar exposing (view)
import Model exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (Model, Msg)

view : Model -> Html Msg
view model =
    div [class "navbar", style "float" "right", style "clear" "right"][input [class "menu-btn", type_ "checkbox", id "menu-btn"] []
      , label [class "menu-icon", for "menu-btn"][span [class "navicon"][]]
      , ul [class "menu"][
        li [][a [href "#Test"][text "Test"]]
        , li [][a [href "#Test"][text "Test2"]]
        , li [][a [href "#Test"][text "Test3"] ]
        ]
    ]