module WebPlatformTests.Url.Tests exposing (all)

import Expect
import Test exposing (..)
import Test.Runner
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
                                    ( String.fromInt i ++ ": " ++ testCase.input
                                    , \() ->
                                        Url.Resolve.resolveString base testCase.input
                                            |> Expect.equal Nothing
                                    )

                                Ok result ->
                                    ( String.fromInt i ++ ": " ++ testCase.input
                                    , \() ->
                                        Url.Resolve.resolveString base testCase.input
                                            |> Maybe.map Url.toString
                                            |> Expect.equal (Just result)
                                    )

                    _ ->
                        Nothing

            run =
                List.map (\( name, expect ) -> test name expect)

            expectPassing n tests =
                [ test "expectPassing" <|
                    \() ->
                        List.map
                            (\( _, expect ) ->
                                if Test.Runner.getFailureReason (expect ()) == Nothing then
                                    1

                                else
                                    0
                            )
                            tests
                            |> List.sum
                            |> Expect.equal n
                ]
        in
        List.indexedMap check UrlTestData.data
            |> List.filterMap identity
            -- |> run
            |> expectPassing 45
