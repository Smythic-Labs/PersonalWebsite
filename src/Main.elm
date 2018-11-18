port module Main exposing (Model, Msg(..), add1, init, main, toJs, update, view)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http exposing (Error(..))
import Json.Decode as Decode
import Random

import Pure --https://package.elm-lang.org/packages/benthepoet/elm-purecss/1.0.3/



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
    div[][header []
                      [ -- img [ src "/images/logo.png" ] []
                        span [ class "logo" ] []
                      , h1 [] [ text "sMythic-Labs Starter Website" ]
                      ]
    ,div [ class "container pure-g mainBody" ] [
        div [class "pure-u-1-12 navbar"] [text "Nav goes here"]
        ,div [class "pure-u-5-6"]
        [
             p [] [ text "Click on the button below to increment the state." ]
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
                [ text "A Begining website, Mostly just a playground of Elm junk! Using the following Base: "
                , a [ href "https://github.com/simonh1000/elm-webpack-starter" ] [ text "elm-webpack-starter" ]
                ]
            , p []
                [text "see this sites source code here: "
                , a [href "https://github.com/TronoTheMerciless/PersonalWebsite"] [text "TronoTheMerciless GitHub"]
                ]
            , div [ class "pure-g"]
                [ div [class "pure-u-1"][ h1 [] [ text "On to the Experiments!" ] ]
                , div [class "pure-u-1"][ h1 [] [ text (dieImage model.dieFace) ]]
                , div [class "pure-u-1"][button [ onClick Roll ] [ text "Roll" ]]
                ]
                , br [][]
            , div [class "pure-g"] [
                    div [class "pure-u-1-6"] [button[ onClick Decrement10][text "-10"]
                    , button[ onClick Decrement][text "-"]

                    ]
                    , div [class "pure-u-1-6"] [text (String.fromInt model.value)]
                    , div [class "pure-u-1-6"] [ button [ onClick Increment] [text "+"]
                    , button[ onClick Increment10][text "+10"]
                    ]
                ]
                , br [][]
            ,div [class "pure-g"] [
                 div [class "pure-u-1"] [button [ onClick Reset] [text "Reset"]]
                , div [class "pure-u-1"]
                  [ input [ placeholder "Text to reverse", value model.content, onInput Change ] [] ]
                , div [class "pure-u-1"] [ text (String.reverse model.content)
                  ]
                ]
            ,br [][]

            ]
            ,div [class "pure-u-1-12 rightSidebar"] []
        ]
        ,div[][ footer[][text "Copyright Isaac Smyth 2018"]]
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
                { title = "Welcome to Smythic-Labs"
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