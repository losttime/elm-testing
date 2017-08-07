module Component exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- MODEL


type alias State =
  { email : Maybe String
  }


initialState : State
initialState =
  { email = Nothing
  }


-- MESSAGES


type Msg
  = Subscribe (Maybe String) | Change String


-- UPDATE


update : Msg -> State -> ( State, Cmd Msg )
update message state =
  case message of
    Change newEmail ->
      ( { state | email = Just newEmail }, Cmd.none )
    Subscribe _ ->
      ( state, Cmd.none )


-- view


view : State -> Html Msg
view state =
  Html.form [ onSubmit (Subscribe state.email) ]
    [ input [ name "email", onInput Change] []
    , button [ type_ "submit" ] [ text "subscribe" ]
  ]
