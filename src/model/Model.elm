--
-- model/Model.elm
--
module Model exposing (..)

import  Http exposing (Error)

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

