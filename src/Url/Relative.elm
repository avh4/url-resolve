module Url.Relative exposing (ParseError, RelativeUrl, parse)


type alias RelativeUrl =
    {}


type alias ParseError =
    Never


parse : String -> Result ParseError RelativeUrl
parse _ =
    Ok {}
