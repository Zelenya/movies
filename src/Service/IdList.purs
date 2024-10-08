module Service.IdList
  ( Id(..)
  , idList
  ) where

import Prelude

import Data.Newtype (class Newtype)
import Data.Array.NonEmpty (NonEmptyArray, cons')

newtype Id = Id String

derive instance Newtype Id _
derive newtype instance Show Id
derive newtype instance Eq Id
derive newtype instance Ord Id

-- Over the Garden Wall: "tt3718778"
idList :: NonEmptyArray Id
idList = Id <$> cons'
  "tt6751668"
  [ "tt1865505"
  , "tt0460791"
  , "tt3464902"
  , "tt0120601"
  , "tt0270288"
  , "tt0268126"
  , "tt0338013"
  , "tt0030993"
  , "tt2401878"
  , "tt0054331"
  , "tt0056193"
  , "tt0057012"
  , "tt0062622"
  , "tt0066921"
  , "tt0072684"
  , "tt0081505"
  , "tt0093058"
  , "tt0120663"
  , "tt0049730"
  , "tt1605717"
  , "tt0446029"
  , "tt0805564"
  , "tt0061184"
  , "tt0364569"
  , "tt0073486"
  , "tt0085859"
  , "tt0080678"
  , "tt1450321"
  , "tt0117951"
  , "tt1213663"
  , "tt0365748"
  , "tt0335266"
  , "tt2278388"
  , "tt1853728"
  , "tt0361748"
  , "tt0110912"
  , "tt0097216"
  , "tt0120382"
  , "tt0048281"
  , "tt0092603"
  , "tt0268978"
  , "tt0107048"
  , "tt0119217"
  , "tt0960144"
  , "tt0088763"
  , "tt1587707"
  , "tt2582496"
  , "tt0118715"
  , "tt0780504"
  , "tt1748122"
  , "tt0109445"
  , "tt0095690"
  , "tt0145487"
  , "tt0829482"
  , "tt2788710"
  , "tt0910936"
  , "tt1156398"
  , "tt0071853"
  , "tt0120737"
  , "tt0102926"
  , "tt0075314"
  , "tt0166924"
  , "tt0114369"
  , "tt0258000"
  , "tt2267998"
  , "tt0443706"
  , "tt0409459"
  , "tt0091042"
  , "tt4633694"
  , "tt1379182"
  , "tt5311514"
  , "tt1489887"
  , "tt6710474"
  , "tt0058642"
  ]
