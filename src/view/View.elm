-- update/Update.elm
module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (Model, Page, Msg)

import Index
import Experiments
import Navbar



view : Model -> Html Msg
view model =
    --remove this temporarily from css @import '~purecss/build/pure.css';
    div[class "pure-g container"][header [class "pure-u-1 header"]
          [ -- img [ src "/images/logo.png" ] []
            a [ class "logo", href "" ] [text "sMythic-Labs" ]
          --, h1 [] [ text "sMythic-Labs Starter Website" ]
          --translated from https://codepen.io/mutedblues/pen/MmPNPG and using sass hamburgers
          , Navbar.view model


          ]
    ,div [ class "pure-u-1 mainBody" ] [
        div [class "pure-u-11-12"]
        [

            case model.page of
                Model.Index ->
                    Index.view model
                Model.Experiments ->
                    Experiments.view model
                Model.About ->
                    div[][text "about!"]
            ,br [][]

            ]

        ]
    ,div[class "pure-u-1"][ footer[][text "Copyright Isaac Smyth 2018"]]
    ]
