
module MoviesComponent
  ( mkMoviesComponent
  ) where

import Prelude

import Config (Config)
import Control.Apply (lift3)
import Data.Maybe (Maybe(..), fromMaybe)
import Data.Traversable (sequence_)
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import React.Basic.DOM as R
import React.Basic.DOM.Events (clientX, clientY)
import React.Basic.Events (handler, merge)
import React.Basic.Hooks (Component, component, useState, (/\))
import React.Basic.Hooks as React
import Service.IdList (Id(..))
import Service.MovieClient (Movie, PosterUrl)
import Service.WhatToWatch (getMovie, getMovie_, loadIdList)
import Service.WheelList (superIndex)

import React.Basic.Hooks.Aff (useAff)

mkMoviesComponent :: Config -> Component Unit
mkMoviesComponent config = do
  movieInfo <- mkMovieInfo
  component "Movies" \props -> React.do
    { movie, setId } <- useMovieApi $ getMovie config
    pure $ R.div
      { children:
        [ movieInfo { movie, onChange: setId }
        , clickAnywhere
        ]
      }
  where
    useMovieApi
      :: (Id -> Aff Movie)
      -> _ { movie :: Movie, setId :: Id -> Effect Unit }
    useMovieApi fetchMovie = React.do
      id /\ updateEncoded <- useState $ Id ""
      maybeMovie <- useAff id (fetchMovie id)
      let movie = fromMaybe getMovie_ maybeMovie
          setId = updateEncoded <<< const
      pure { movie, setId }

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

mkMovieInfo :: Component { movie :: Movie, onChange :: Id -> Effect Unit }
mkMovieInfo = do
  movieIds <- loadIdList
  component "MovieInfo" \{ movie, onChange } -> React.do
    movieFocus /\ setMovieFocus <- useState 0
    _ <- useAff movieFocus $ liftEffect $
      onChange $ superIndex movieIds movieFocus

    pure $
      R.div
        { onClick: handler (merge { clientX, clientY })
          (\{ clientX, clientY } -> addPoster clientX clientY movie *> setMovieFocus (_ + 1))
        , style: R.css { height: "100vh", width: "100vw", position: "absolute" }
        }
  where
    addPoster :: Maybe Number -> Maybe Number -> Movie -> Effect Unit
    addPoster x y { posterUrl } =
      sequence_ $ lift3 addImage x y $ Just posterUrl

foreign import addImage :: Number -> Number -> PosterUrl -> Effect Unit
