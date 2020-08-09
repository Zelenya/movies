module Main where

import Prelude

import Config (Config, MovieApiUrl(..), PosterStorageUrl(..))
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Exception (throw)
import MoviesComponent (mkMoviesComponent)
import React.Basic.DOM.Client (createRoot, renderRoot)
import Web.DOM.NonElementParentNode (getElementById)
import Web.HTML (window)
import Web.HTML.HTMLDocument (toNonElementParentNode)
import Web.HTML.Window (document)

config :: Config
config =
  { movieApiUrl: MovieApiUrl "https://api.themoviedb.org/3/find/"
  , posterStorageUrl: PosterStorageUrl "https://image.tmdb.org/t/p/w300"
  }

main :: Effect Unit
main = do
  container <- getElementById "container" =<< (map toNonElementParentNode $ document =<< window)
  case container of
    Nothing -> throw "Container element not found."
    Just root -> do
      movies <- mkMoviesComponent config
      reactRoot <- createRoot root
      renderRoot reactRoot (movies {})