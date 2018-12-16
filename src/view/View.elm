-- update/Update.elm
module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (Model, Msg)

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
             p [] [ text "Click on the button below to increment the state." ]
            , div [ class "pure-g" ]
                [ div [ class "pure-u-1-3" ]
                    [ button
                        [ class "pure-button pure-button-primary"
                        , onClick Model.Inc
                        ]
                        [ text "+ 1" ]
                    , text <| String.fromInt model.counter
                    ]
                , div [ class "pure-u-1-3" ] []
                , div [ class "pure-u-1-3" ]
                    [ button
                        [ class "pure-button pure-button-primary"
                        , onClick Model.TestServer
                        ]
                        [ text "ping dev server" ]
                    , text model.serverMessage
                    ]
                ]
            , p [] [ text "" ]
            , p []
                [ text "A Begining website, Mostly just a playground of Elm junk! Using the following Base: "
                , a [ href "https://github.com/simonh1000/elm-webpack-starter" ] [ text "elm-webpack-starter" ]
                ]
            , p []
                [text "see this sites source code here: "
                , a [href "https://github.com/TronoTheMerciless/PersonalWebsite"] [text "TronoTheMerciless GitHub"]
                ]
            , Experiments.view model
            ,br [][]

            ]

        ]
        ,div[class "pure-u-1"][ footer[][text "Copyright Isaac Smyth 2018"]]
    ]
