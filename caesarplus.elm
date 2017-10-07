module CaesarPlus exposing (longKeyEncrypt, longKeyDecrypt)

import Char


string2ascii message =
    message
        |> String.toList
        |> List.map Char.toCode


add x y =
    x + y


ascii2string nums =
    nums
        |> List.map Char.fromCode


extend key str =
    let
        n =
            String.length str

        k =
            String.length key

        r =
            (n // k) + 1

        longkey =
            List.repeat r key |> String.join ""
    in
        String.slice 0 n longkey


sub x =
    x - (Char.toCode 'a')


ad x =
    x - (Char.toCode 'a')


longKeyEncrypt key text =
    let
        longKey =
            extend key text |> string2ascii |> List.map sub

        textVector =
            text |> string2ascii

        newVector =
            List.map2 (+) textVector longKey
    in
        ascii2string newVector |> String.fromList


longKeyDecrypt key text =
    let
        longKey =
            Debug.log "longKey"
                extend
                key
                text
                |> string2ascii
                |> List.map ad

        textVector =
            Debug.log "textVector"
                text
                |> string2ascii

        newVector =
            Debug.log "newVector"
                List.map2
                (-)
                textVector
                longKey
    in
        ascii2string newVector |> String.fromList
