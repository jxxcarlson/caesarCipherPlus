module Decode exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import CaesarPlus exposing (longKeyEncrypt, longKeyDecrypt)


main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias Model =
    { plainText : String
    , cipherText : String
    , key : String
    }


model : Model
model =
    Model "" "" ""



-- UPDATE


type Msg
    = PlainText String
    | Key String


update : Msg -> Model -> Model
update msg model =
    case msg of
        PlainText plainText ->
            { model | plainText = plainText, cipherText = longKeyEncrypt model.key plainText }

        Key key ->
            { model | cipherText = longKeyDecrypt key model.plainText, key = key }



-- VIEW


view : Model -> Html Msg
view model =
    div
        [ style
            [ ( "width", "400px" )
            , ( "height", "300px" )
            , ( "padding", "15px" )
            , ( "margin", "40px" )
            , ( "background-color", "rgb(140,140,140" )
            ]
        ]
        [ h1
            [ style
                [ ( "color", "white" )
                , ( "padding-bottom", "20px" )
                ]
            ]
            [ text "Caesar cipher + (Decode)" ]
        , div []
            [ input
                [ type_ "text"
                , style
                    [ ( "width", "350px" )
                    , ( "font-family", "monospace" )
                    , ( "font-size", "14pt" )
                    ]
                , placeholder "Encrypted text"
                , onInput PlainText
                ]
                []
            , span [ style [ ( "margin-left", "10px" ), ( "color", "white" ) ] ] [ text (toString (String.length model.plainText)) ]
            ]
        , div []
            [ input
                [ style
                    [ ( "width", "350px" )
                    , ( "font-family", "monospace" )
                    , ( "margin-top", "15px" )
                    , ( "font-size", "14pt" )
                    ]
                , type_ "text"
                , placeholder "key"
                , onInput Key
                ]
                []
            , span [ style [ ( "margin-left", "10px" ), ( "color", "white" ) ] ] [ text (toString (String.length model.key)) ]
            ]
        , div [ style [ ( "margin-top", "15px" ) ] ]
            [ span
                [ style
                    [ ( "width", "350px" )
                    , ( "height", "30px" )
                    , ( "font-size", "14pt" )
                    , ( "font-family", "monospace" )
                    , ( "padding", "4px" )
                    , ( "background-color", "rgb(160, 110, 110)" )
                    , ( "color", "white" )
                    ]
                ]
                --[ text (longKeyEncrypt model.key model.plainText) ]
                [ text model.cipherText ]
            , span [ style [ ( "margin-left", "10px" ), ( "color", "white" ) ] ] [ text (toString (String.length model.cipherText)) ]
            ]
        , p
            [ style
                [ ( "width", "350px" )
                , ( "height", "32px" )
                , ( "font-size", "12pt" )
                , ( "padding", "4px" )
                , ( "padding-top", "20px" )
                , ( "color", "white" )
                ]
            ]
            [ text "Enter the encrypted text in 'Encrypted text' and a string in 'key'. Use ALL CAPS for the key" ]
        ]
