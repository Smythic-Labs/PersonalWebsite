module About exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Model exposing (Model, Msg)

view : Model -> Html Msg
view model =
        div[][

             br [][]

            , h2[][text "Architecture"]
            , div [] [getArchitecture]

    ]

getArchitecture: Html Msg
getArchitecture =
    div [] [
        ul [][
            li   [][a [href "https://elm-lang.org/"][text "The Elm Programming Language"]]
            , li [][a [href "https://purecss.io/" ][text "purecss"], text " for a lightweight CSS toolkit"]
            , li [][a [href "https://sass-lang.com/"][text "SASS CSS"], text " for cleaner functional CSS"]
            , li [][a [href "https://github.com/simonh1000/elm-webpack-starter"][text "Webpack Starterkit for Elm by simonh1000"], text " to enable Advanced Dev features and builds"]
            , li [][a [href "https://github.com/" ][text "GitHub"], text " For Open source code hosting and git integration"]
            , li [][a [href "https://circleci.com/" ][text "circleci"], text " for Continuous Integration allowing Automatic Builds and Deployments using Docker Images"]
            , li [][a [href "https://www.docker.com/"][text "Docker"], text " for CircleCI build and deploy images and Dev environments"]
            , li [][a [href "https://aws.amazon.com/"][text "Amazon AWS"], text " for web hosting"]
        ]
    ]
