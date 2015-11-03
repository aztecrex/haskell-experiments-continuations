module Jump where

import Control.Monad.Cont
import Control.Monad.Identity

label :: (MonadCont m) => m (m a)
label = callCC $ \k -> let f = k f in return f

demoJump :: IO ()
demoJump = flip runContT return $ do
  lift $ putStrLn "Start"
  top <- label
  lift $ putStrLn "Spam"
  top
  lift $ putStrLn "Never End"
