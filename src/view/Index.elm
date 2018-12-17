module Index exposing (view)
import Model exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (Model, Msg)

view : Model -> Html Msg
view model =
        div[][

             br [][]
            , p []
                [ text "A Beginning website, Mostly just a playground of Elm junk! Using the following Base: "
                , a [ href "https://github.com/simonh1000/elm-webpack-starter" ] [ text "elm-webpack-starter" ]
                ]
            , p []
                [text "see this sites source code here: "
                , a [href "https://github.com/TronoTheMerciless/PersonalWebsite"] [text "TronoTheMerciless GitHub"]
                ]
            , h2[][text "Resume"]
            , div [class "iframe-container"]
                [iframe
                    [ class "resume"
                    , src "https://docs.google.com/document/d/e/2PACX-1vT8xQavqTs4LsUzSE6STZ4oANoHT0sf7HBhkmalgbiRGRJ59VLTosJonjHv5J68EwU9xE9Qzi3E5DTJ/pub?embedded=true"][]
                ]
    ]