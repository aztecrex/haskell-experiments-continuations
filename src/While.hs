module While where

import Control.Monad.Cont
import Control.Monad.Fix (fix)
loop' :: (Monad m) => m a -> m a
loop' body = fix (body >>)

loop :: (MonadCont m) => m a -> m a
loop body = callCC $ \k -> fix (body >>)

whileDemo :: IO ()
whileDemo = flip runContT return $ do
  callCC $ \k -> loop' $ do
    lift $ putStrLn "Hello"
    k()
  lift $ putStrLn "Good-bye"
    --  callCC $ \k -> k ()


-- loop :: (MonadCont m) =>  m (m a)



-- loop :: MonadCont m => a -> m (m a)


-- while :: (MonadCont m) => Bool -> m Bool
-- while c0 = callCC $ \k -> do
--   if k
--     then let f x = k f
--       in return f
--     else k False



-- lef f x = k (x, f) in return (x0, f)

-- label = callCC $ \k -> let f = k f in return f


-- getCC' :: MonadCont m => a -> m (a, a -> m b)
-- getCC' x0 = callCC (\c -> let f x = c (x, f) in return (x0, f)
