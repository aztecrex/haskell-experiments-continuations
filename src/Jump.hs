module Jump where

import Control.Monad.Cont
import Control.Monad.Identity

rightNow :: (MonadCont m) => m (m a)
rightNow = callCC $ \k -> let f = k f in return f

goWhen :: (MonadCont m) => m (m a) -> m (m a)
goWhen moment = do
  jump <- moment
  moment


demoJump :: IO ()
demoJump = flip runContT return $ do
  lift $ putStrLn "Start"
  label <- rightNow
  lift $ putStrLn "Spam"
  goWhen label
  lift $ putStrLn "Never End"
