port module Main exposing  (main)--(Model, Msg(..), add1, init, main, toJs, update, view)

import Browser
import Browser.Navigation as Nav

import Random

import Pure --https://package.elm-lang.org/packages/benthepoet/elm-purecss/1.0.3/

import Model exposing (..)
import Update
import View

-- ---------------------------
-- MAIN
-- ---------------------------


main : Program Int Model Msg
main =
    Browser.document
        { init = Model.init
        , update = Update.update
        , view =
            \m ->
                { title = "Welcome to Smythic-Labs"
                , body = [ View.view m ]
                }
        , subscriptions = \_ -> Sub.none
        }

