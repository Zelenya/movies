
module MoviesComponent
  ( mkMoviesComponent
  )
  where

import Prelude

import Config (Config)
import Control.Apply (lift3)
import Data.Maybe (Maybe(..), fromMaybe)
import Data.Traversable (sequence_)
import Effect (Effect)
import React.Basic.DOM as R
import React.Basic.DOM.Events (clientX, clientY)
import React.Basic.Events (handler, merge)
import React.Basic.Hooks (Component, JSX, component, useState, (/\))
import React.Basic.Hooks as React
import React.Basic.Hooks.Aff (useAff)
import Service.MovieClient (Movie, PosterUrl)
import Service.WhatToWatch (getMovie, defaultMovie, loadIdList)
import Service.WheelList (superIndex)

mkMoviesComponent :: Config -> Component {}
mkMoviesComponent config = do 
  movieIds <- loadIdList
  moviesDisplay <- mkMoviesDisplay
  component "MoviesApp" \_ -> React.do
    movieFocus /\ setMovieFocus <- useState 0
    maybeMovie <- useAff movieFocus do 
      let nextMovieId = superIndex movieIds movieFocus 
      getMovie config nextMovieId

    let movie = fromMaybe defaultMovie maybeMovie
        selectNextMovie = setMovieFocus (_ + 1)

    pure $ R.div
      { children:
        [ moviesDisplay { movie, selectNextMovie }
        , clickAnywhere
        ]
      }

type MoviesDisplayProps = 
   { movie :: Movie
   , selectNextMovie :: Effect Unit 
   }

-- | On click: render new movie poster, select a next movie
mkMoviesDisplay :: Component MoviesDisplayProps
mkMoviesDisplay = do
  component "MoviesDisplay" \{ movie, selectNextMovie } -> React.do
    pure $
      R.div
        { onClick: handler (merge { clientX, clientY }) (\{ clientX, clientY } -> 
            addPoster clientX clientY movie  *> selectNextMovie)
        , style: R.css { height: "100vh", width: "100vw", position: "absolute" }
        }
  where
    addPoster :: Maybe Number -> Maybe Number -> Movie -> Effect Unit
    addPoster x y { posterUrl } =
      sequence_ $ lift3 addImage x y $ Just posterUrl

foreign import addImage :: Number -> Number -> PosterUrl -> Effect Unit

clickAnywhere :: JSX
clickAnywhere =
  R.div
    { children: [R.text "click anywhere"]
    , style: R.css
      { height: "100vh"
      , width: "100vw"
      , position: "absolute"
      , lineHeight: "100vh"
      , textAlign: "center"
      , zIndex: "-1"
      }
    }
