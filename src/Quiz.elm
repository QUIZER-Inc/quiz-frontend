module Quiz exposing (..)


import Id exposing (Id)
import Json.Decode exposing (Decoder, int, list, nullable, string, succeed)
import Json.Decode.Pipeline exposing (required)
import Question exposing (Question, decodeQuestion)


type Quiz = Quiz
    { id: QuizId
    , name: String
    , description: Maybe String
    , questions: List Question
    }


type alias QuizId =
    Id Int Quiz


fromValues : QuizId -> String -> Maybe String -> List Question -> Quiz
fromValues id name description questions =
    Quiz
    { id = id
    , name = name
    , description = description
    , questions = questions
    }


decodeQuiz : Decoder Quiz
decodeQuiz =
    succeed fromValues
        |> required "id" (Id.decoder int)
        |> required "name" string
        |> required "description" (nullable string)
        |> required "questions" (list decodeQuestion)