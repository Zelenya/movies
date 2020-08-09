module Service.MovieClient
  ( getMovieById
  , Movie
  , Overview(..)
  , PosterUrl(..)
  , Title(..)
  )
where

import Prelude

import Config (MovieApiUrl(..), PosterStorageUrl(..))
import Data.Array.NonEmpty (NonEmptyArray)
import Data.Array.NonEmpty as NE
import Data.Either (Either(..))
import Data.Foldable (intercalate)
import Data.Maybe (Maybe(..))
import Data.Newtype (class Newtype)
import Effect.Aff (Aff)
import Effect.Class.Console (log)
import Fetch (fetch)
import Foreign (renderForeignError)
import Service.IdList (Id(..))
import Simple.JSON (readJSON, class ReadForeign)

type Movie =
  { title :: Title
  , overview :: Overview
  , posterUrl :: PosterUrl
  }

getMovieById :: MovieApiUrl -> PosterStorageUrl -> Id -> Aff (Maybe Movie)
getMovieById movieApiUrl (PosterStorageUrl storageUrl) id = do
  movieResponse <- fetchMovie movieApiUrl id
  pure $ (withPosterUrl <<< NE.head <<< _.movie_results) <$> movieResponse
  where
    withPosterUrl :: MovieResult -> Movie
    withPosterUrl { title, overview, poster_path } =
      { title, overview, posterUrl: toPosterUrl poster_path }

    toPosterUrl :: PosterPath -> PosterUrl
    toPosterUrl (PosterPath path) = PosterUrl $ storageUrl <> path

fetchMovie :: MovieApiUrl -> Id -> Aff (Maybe MovieResponse)
fetchMovie (MovieApiUrl movieApiUrl) (Id id) = do
  let url = movieApiUrl <> id <> "?api_key=a029971d5f65f01b7182ba59fe172c08&external_source=imdb_id"
  responseBody <- fetch url {} >>= _.text
  case readJSON responseBody of
    Right movieResponse ->
      pure $ Just movieResponse
    Left e ->
      log ("Oopsie. Couldn't decode movie response. " <> toString e) $> Nothing
  where
    toString = intercalate ", " <<< map renderForeignError

type MovieResponse =
  { movie_results :: NonEmptyArray MovieResult }

type MovieResult =
  { title :: Title
  , overview :: Overview
  , poster_path :: PosterPath
  }

newtype Overview = Overview String
derive instance Newtype Overview _
derive newtype instance ReadForeign Overview
derive newtype instance Show Overview

newtype PosterUrl = PosterUrl String
derive instance Newtype PosterUrl _
derive newtype instance Show PosterUrl

newtype PosterPath = PosterPath String
derive instance Newtype PosterPath _
derive newtype instance ReadForeign PosterPath

newtype Title = Title String
derive instance Newtype Title _
derive newtype instance ReadForeign Title
derive newtype instance Show Title
