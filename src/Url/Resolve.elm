module Url.Resolve exposing (resolveRelativeUrl, resolveString)

import Url exposing (Url)
import Url.Relative exposing (RelativeUrl)


resolveString : Url -> String -> Maybe Url
resolveString base input =
    Nothing


resolveRelativeUrl : Url -> RelativeUrl -> Url
resolveRelativeUrl base input =
    base
