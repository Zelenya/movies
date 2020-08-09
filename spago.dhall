{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "what-to-watch"
, dependencies = [ "affjax", "aff-promise", "console", "effect", "random", "react-basic", "react-basic-hooks", "psci-support", "simple-json", "spec", "spec-discovery", "spec-quickcheck" ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
