module Main exposing (..)

import Html exposing (Html, div, text, program)
import Component exposing (..)


-- MODEL


type alias Model =
  { subscriptionState : Component.State
  , address : Maybe String
  }


init : ( Model, Cmd Msg )
init =
  ( { subscriptionState = Component.initialState
    , address = Nothing
    }
  , Cmd.none
  )


-- MESSAGES


type Msg
  = ComponentMsg Component.Msg


-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ Html.map ComponentMsg (Component.view model.subscriptionState)
    , text (Maybe.withDefault "---" model.address)
    ]


-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    ComponentMsg compMsg ->
      case Debug.log "Component Msg in parent" compMsg of
        Component.Subscribe data ->
          ( emailSubmitted data model, Cmd.none )
        _ ->
          let
            ( updatedWidgetModel, widgetCmd ) =
              Component.update compMsg model.subscriptionState
          in
            ( { model | subscriptionState = updatedWidgetModel }, Cmd.map ComponentMsg widgetCmd )


emailSubmitted : Maybe String -> Model -> Model
emailSubmitted emailAddress model =
  case emailAddress of
    Just address ->
      { model | address = emailAddress }
    Nothing ->
      model


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


-- MAIN


main : Program Never Model Msg
main =
  program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
