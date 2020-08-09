module Service.WheelList
  ( shuffle
  , superIndex
  )
where

import Prelude

import Data.Maybe (fromMaybe)
import Data.Traversable (traverse)
import Data.Tuple (fst, snd)
import Data.Array.NonEmpty (NonEmptyArray)
import Data.Array.NonEmpty as NE
import Effect (Effect)
import Effect.Random (random)

shuffle :: forall a. NonEmptyArray a -> Effect (NonEmptyArray a)
shuffle list = do
  randoms <- traverse (const random) list
  pure $ map fst $ NE.sortBy (comparing snd) $ NE.zip list randoms

superIndex :: forall a. NonEmptyArray a -> Int -> a
superIndex list index = fromMaybe fallback $ NE.index list i
  where
    i = index `mod` NE.length list
    fallback = NE.head list
