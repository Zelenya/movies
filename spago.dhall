{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "movies"
, dependencies =
  [ "aff"
  , "arrays"
  , "console"
  , "effect"
  , "either"
  , "exceptions"
  , "fetch"
  , "foldable-traversable"
  , "foreign"
  , "maybe"
  , "newtype"
  , "prelude"
  , "quickcheck"
  , "random"
  , "react-basic"
  , "react-basic-dom"
  , "react-basic-hooks"
  , "simple-json"
  , "spec"
  , "spec-discovery"
  , "spec-quickcheck"
  , "tuples"
  , "web-dom"
  , "web-html"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
