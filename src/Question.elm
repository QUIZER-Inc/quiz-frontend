module Question exposing (..)

import Json.Decode exposing (Decoder, andThen, fail, list, nullable, string, succeed)
import Json.Decode.Pipeline exposing (required)


type alias Question =
    { name: String
    , description: Maybe String
    , imageURL: Maybe String
    , difficulty: Difficulty
    , category: String
    , subCategories: Maybe (List String)
    , answers: List String
    }


type Difficulty
    = Easy
    | Medium
    | Hard


sampleQuestion : Question
sampleQuestion =
    { name = "Что такое ООП?"
    , description = Nothing
    , imageURL = Nothing
    , difficulty = Easy
    , category = "JAVA"
    , subCategories = Just [ "CORE", "OOP" ]
    , answers =
        [ "Объектно-ориентированное программирование - ... (1)"
        , "Объектно-ориентированное программирование - ... (2)"
        , "Объектно-ориентированное программирование - ... (3)"
        , "Объектно-ориентированное программирование - ... (4)"
        ]
    }


decodeDifficulty : Decoder Difficulty
decodeDifficulty =
    string
        |> andThen (\str ->
            case str of
                "EASY" ->
                    succeed Easy

                "MEDIUM" ->
                    succeed Medium

                "HARD" ->
                    succeed Hard

                _ ->
                    fail "Unknown difficulty"
        )


decodeQuestion : Decoder Question
decodeQuestion =
    succeed Question
        |> required "name" string
        |> required "description" (nullable string)
        |> required "imageUrl" (nullable string)
        |> required "difficultyType" decodeDifficulty
        |> required "categoryName" string
        |> required "subCategories" (nullable (list string))
        |> required "answers" (list string)
