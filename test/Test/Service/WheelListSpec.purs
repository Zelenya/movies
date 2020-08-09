module Test.Service.WheelListSpec where

import Prelude

import Data.Array.NonEmpty (NonEmptyArray)
import Data.Array.NonEmpty as NE
import Service.WheelList (superIndex)
import Test.QuickCheck ((===))
import Test.Spec (Spec, describe, it)
import Test.Spec.QuickCheck (quickCheck)

spec :: Spec Unit
spec = do
  describe "superindex" do
    it "should stay in bounds" do
      quickCheck \(list :: NonEmptyArray Int) i ->
        let listLength = NE.length list
        in superIndex list i === superIndex list (i + listLength)
