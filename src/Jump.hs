module Jump where

import Control.Monad.State
import Control.Monad.Cont
import Control.Monad.Identity

label :: (MonadCont m) => m (m a)
label = callCC $ \k -> let f = k f in return f

demoJump1 :: IO ()
demoJump1 = flip runContT return $ do
  lift $ putStrLn "Start"
  top <- label
  lift $ putStrLn "Spam"
  top
  lift $ putStrLn "Never End"



demoJump2 :: Int
demoJump2 = runCont (evalStateT body 0) id
  where
    body = do
      l1 <- label
      modify (+1)
      s <- get
      if s == 5
        then return s
        else l1
