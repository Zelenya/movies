module Service.WhatToWatch
  ( defaultMovie
  , getMovie
  , loadIdList
  )
where

import Prelude

import Config (Config)
import Data.Maybe (Maybe(..))
import Data.Array.NonEmpty (NonEmptyArray)
import Effect (Effect)
import Effect.Aff (Aff)
import Service.IdList (Id, idList)
import Service.MovieClient (Movie, Overview(..), PosterUrl(..), Title(..), getMovieById)
import Service.WheelList (shuffle)

defaultMovie :: Movie
defaultMovie  =
  { title: Title "Scott Pilgrim vs. the World"
  , overview: Overview "As bass guitarist for a garage-rock band, Scott Pilgrim  has never had trouble getting a girlfriend; usually, the problem is getting rid of them. But when Ramona Flowers skates into his heart, he finds she has the most troublesome baggage of all: an army of ex-boyfriends who will stop at nothing to eliminate him from her list of suitors."
  , posterUrl: PosterUrl "https://image.tmdb.org/t/p/w300/g5IoYeudx9XBEfwNL0fHvSckLBz.jpg"
  }

getMovie :: Config -> Id -> Aff Movie
getMovie { movieApiUrl, posterStorageUrl } id = do
  movie <- getMovieById movieApiUrl posterStorageUrl id
  case movie of
    Just e  -> pure e
    Nothing -> pure defaultMovie

loadIdList :: Effect (NonEmptyArray Id)
loadIdList = shuffle idList

