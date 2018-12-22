module Update exposing (update)

import Http exposing (Error(..))
import Model exposing (Model, Page, Msg)
import Port exposing (toJs)
import Json.Decode as Decode
import Random

update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        Model.Inc ->
            ( add1 model, toJs "Hello Js" )

        Model.Set m ->
            ( { model | counter = m }, toJs "Hello Js" )
        Model.Roll ->
          ( model
          , Random.generate Model.NewFace (Random.int 1 6)
          )

        Model.NewFace newFace ->
          ( Model model.counter model.serverMessage newFace model.value model.content model.page
          , Cmd.none
          )
        Model.Increment ->
            ({model | value = model.value + 1}
            , Cmd.none
            )

        Model.Increment10 ->
            ({model | value = model.value + 10}
            , Cmd.none
            )

        Model.Decrement ->
            ({model | value = model.value - 1}
            , Cmd.none
            )

        Model.Decrement10 ->
            ({model | value = model.value - 10}
            , Cmd.none
            )


        Model.Reset ->
            (Model 0 model.serverMessage  1 1 "" model.page
            , Cmd.none
            )

        Model.Change newContent ->
              ({ model | content = newContent }
              , Cmd.none
              )
        Model.TestServer ->
            ( model
            , Http.get "/test" (Decode.field "result" Decode.string)
                |> Http.send Model.OnServerResponse
            )

        Model.OnServerResponse res ->
            case res of
                Ok r ->
                    ( { model | serverMessage = r }, Cmd.none )

                Err err ->
                    ( { model | serverMessage = "Error: " ++ httpErrorToString err }, Cmd.none )
        Model.SetPage page ->
            case page of
                Model.Index ->
                    ( { model | page = Model.Index }, Cmd.none )
                Model.Experiments ->
                    ( { model | page = Model.Experiments }, Cmd.none )
                Model.About ->
                    ( { model | page = Model.About }, Cmd.none )
                Model.Resume ->
                    ( { model | page = Model.Resume }, Cmd.none )

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
