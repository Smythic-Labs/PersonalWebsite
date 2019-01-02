module Resume exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Model exposing (Model, Msg)

view : Model -> Html Msg
view model =
         div [class "pure-g-u-1 iframe-container"]
                [iframe
                    [ class "resume"
                    , src "https://docs.google.com/document/d/e/2PACX-1vT8xQavqTs4LsUzSE6STZ4oANoHT0sf7HBhkmalgbiRGRJ59VLTosJonjHv5J68EwU9xE9Qzi3E5DTJ/pub?embedded=true"][]
                ]
