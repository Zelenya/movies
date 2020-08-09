module Config
  ( Config
  , MovieApiUrl(..)
  , PosterStorageUrl(..)
  )
where

import Data.Newtype (class Newtype)

newtype MovieApiUrl = MovieApiUrl String
derive instance newtypeMovieApiUrl :: Newtype MovieApiUrl _

newtype PosterStorageUrl = PosterStorageUrl String
derive instance newtypePosterStorageUrl :: Newtype PosterStorageUrl _

type Config =
  { movieApiUrl :: MovieApiUrl
  , posterStorageUrl :: PosterStorageUrl
  }
