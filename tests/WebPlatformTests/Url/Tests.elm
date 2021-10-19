module WebPlatformTests.Url.Tests exposing (all)

import Expect
import Test exposing (..)
import Url
import Url.Resolve
import WebPlatformTests.Url.UrlTestData as UrlTestData


all : Test
all =
    describe "specs" <|
        let
            check i testCase =
                case testCase.base of
                    Just (Ok base) ->
                        Just <|
                            case testCase.result of
                                Err () ->
                                    test (String.fromInt i ++ ": " ++ testCase.input) <|
                                        \() ->
                                            Url.Resolve.resolveString base testCase.input
                                                |> Expect.equal Nothing

                                Ok result ->
                                    test (String.fromInt i ++ ": " ++ testCase.input) <|
                                        \() ->
                                            Url.Resolve.resolveString base testCase.input
                                                |> Maybe.map Url.toString
                                                |> Expect.equal (Just result)

                    _ ->
                        Nothing
        in
        List.indexedMap check UrlTestData.data
            |> List.filterMap identity
