port module Main exposing (Model, Msg(..), add1, init, main, toJs, update, view)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http exposing (Error(..))
import Json.Decode as Decode
import Random



-- ---------------------------
-- PORTS
-- ---------------------------


port toJs : String -> Cmd msg



-- ---------------------------
-- MODEL
-- ---------------------------


type alias Model =
    { counter : Int
    , serverMessage : String
    , dieFace : Int
    , value : Int
    , content : String
    }


init : Int -> ( Model, Cmd Msg )
init flags =
    ( { counter = flags, serverMessage = "", dieFace = 1, value = 1, content = "" }, Cmd.none )



-- ---------------------------
-- UPDATE
-- ---------------------------


type Msg
    = Inc
    | Set Int
    | Roll
    | NewFace Int
    | Increment
    | Decrement
    | Increment10
    | Decrement10
    | Reset
    | Change String
    | TestServer
    | OnServerResponse (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        Inc ->
            ( add1 model, toJs "Hello Js" )

        Set m ->
            ( { model | counter = m }, toJs "Hello Js" )
        Roll ->
          ( model
          , Random.generate NewFace (Random.int 1 6)
          )

        NewFace newFace ->
          ( Model model.counter model.serverMessage newFace model.value model.content
          , Cmd.none
          )
        Increment ->
            ({model | value = model.value + 1}
            , Cmd.none
            )

        Increment10 ->
            ({model | value = model.value + 10}
            , Cmd.none
            )

        Decrement ->
            ({model | value = model.value - 1}
            , Cmd.none
            )

        Decrement10 ->
            ({model | value = model.value - 10}
            , Cmd.none
            )


        Reset ->
            (Model 0 model.serverMessage  1 1 ""
            , Cmd.none
            )

        Change newContent ->
              ({ model | content = newContent }
              , Cmd.none
              )
        TestServer ->
            ( model
            , Http.get "/test" (Decode.field "result" Decode.string)
                |> Http.send OnServerResponse
            )

        OnServerResponse res ->
            case res of
                Ok r ->
                    ( { model | serverMessage = r }, Cmd.none )

                Err err ->
                    ( { model | serverMessage = "Error: " ++ httpErrorToString err }, Cmd.none )


httpErrorToString : Http.Error -> String
httpErrorToString err =
    case err of
        BadUrl _ ->
            "BadUrl"

        Timeout ->
            "Timeout"

        NetworkError ->
            "NetworkError"

        BadStatus _ ->
            "BadStatus"

        BadPayload _ _ ->
            "BadPayload"


{-| increments the counter

    add1 5 --> 6

-}
add1 : Model -> Model
add1 model =
    { model | counter = model.counter + 1 }



-- ---------------------------
-- VIEW
-- ---------------------------


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ header []
            [ -- img [ src "/images/logo.png" ] []
              span [ class "logo" ] []
            , h1 [] [ text "sMythic-Labs Starter Website" ]
            ]
        , p [] [ text "Click on the button below to increment the state." ]
        , div [ class "pure-g" ]
            [ div [ class "pure-u-1-3" ]
                [ button
                    [ class "pure-button pure-button-primary"
                    , onClick Inc
                    ]
                    [ text "+ 1" ]
                , text <| String.fromInt model.counter
                ]
            , div [ class "pure-u-1-3" ] []
            , div [ class "pure-u-1-3" ]
                [ button
                    [ class "pure-button pure-button-primary"
                    , onClick TestServer
                    ]
                    [ text "ping dev server" ]
                , text model.serverMessage
                ]
            ]
        , p [] [ text "" ]
        , p []
            [ text "A Begining website, Mostly just a playground of Elm junk! Using the following Base:"
            , a [ href "https://github.com/simonh1000/elm-webpack-starter" ] [ text "elm-webpack-starter" ]
            ]
        , p []
            [text "see this sites source code here:"
            , a [href "https://github.com/TronoTheMerciless/PersonalWebsite"] [text "TronoTheMerciless GitHub"]
            ]
        , div []
            [ h1 [] [ text "On to the Experiments!" ]
            , h1 [] [ text (dieImage model.dieFace) ]
            , button [ onClick Roll ] [ text "Roll" ]
            , div [] []
            , button[ onClick Decrement][text "-"]
            , button[ onClick Decrement10][text "-10"]
            , div [] [text (String.fromInt model.value)]
            , button [ onClick Increment] [text "+"]
            , button[ onClick Increment10][text "+10"]
            , div[] []
            , button [ onClick Reset] [text "Reset"]
            , div []
              [ input [ placeholder "Text to reverse", value model.content, onInput Change ] []
              , div [] [ text (String.reverse model.content) ]
              ]
            ]
        ]



-- ---------------------------
-- MAIN
-- ---------------------------


main : Program Int Model Msg
main =
    Browser.document
        { init = init
        , update = update
        , view =
            \m ->
                { title = "Elm 0.19 starter"
                , body = [ view m ]
                }
        , subscriptions = \_ -> Sub.none
        }

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