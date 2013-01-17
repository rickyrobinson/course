module L03.Interactive where

import L03.Moonad

-- | An infix, flipped version of @bind@.
(>>==) ::
  Moonad m =>
  m a
  -> (a -> m b)
  -> m b
(>>==) =
  flip bind

-- | Runs an action until a result of that action satisfies a given predicate.
untilM ::
  Moonad m =>
  (a -> m Bool) -- ^ The predicate to satisfy to stop running the action.
  -> m a -- ^ The action to run until the predicate satisfies.
  -> m a
untilM p a =
  a >>== \r ->
  p r >>== \q ->
  if q
    then
      reeturn r
    else
      untilM p a