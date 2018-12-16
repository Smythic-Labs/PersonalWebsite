module Experiments exposing (view)
import Model exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (Model, Msg)

view : Model -> Html Msg
view model =
        div[][
                div [ class "pure-g-u-1"]
                    [ div [class "pure-u-1"][ h1 [] [ text "On to the Experiments!" ] ]
                    , viewDiceRoll model
                    ]
                    , br [][]
                    , viewIncrements model
                  , br [][]
    ]


viewDiceRoll : Model -> Html Msg
viewDiceRoll model =
    div[][
        div [class "pure-u-1"][ h1 [] [ text (dieImage model.dieFace) ]]
        , div [class "pure-u-1"][button [class "pure-button button-roll", onClick Model.Roll ] [ text "Roll" ]]
    ]

viewIncrements : Model -> Html Msg
viewIncrements model =
    div[][
        div [class "pure-g-u-1"] [
                div [class "pure-u-1-6"] [button[class "pure-button button-decrement", onClick Model.Decrement10][text "-10"]
                , button[class "pure-button button-decrement", onClick Model.Decrement][text "-"]

                ]
                , div [class "pure-u-1-6"] [text (String.fromInt model.value)]
                , div [class "pure-u-1-6"] [ button [class "pure-button button-increment", onClick Model.Increment] [text "+"]
                , button[class "pure-button button-increment", onClick Model.Increment10][text "+10"]
                ]
            ]
            , br [][]
        ,div [class "pure-g-u-1"] [
             div [class "pure-u-1"] [button [class "pure-button button-reset", onClick Model.Reset] [text "Reset"]]
            , div [class "pure-u-1"]
              [ input [ placeholder "Text to reverse", value model.content, onInput Model.Change ] [] ]
            , div [class "pure-u-1"] [ text (String.reverse model.content)
              ]
          ]
    ]


dieImage : Int -> String
dieImage value =
    case value of
        1 -> "⚀"
        2 -> "⚁"
        3 -> "⚂"
        4 -> "⚃"
        5 -> "⚄"
        6 -> "⚅"
        _ -> ""