module LinearAutoDestroy (
    LinearAutoDestroy, -- Exporta o tipo nominal, mas não o construtor interno
    initLinear,
    consumeLinear
) where

import Data.IORef

-- Tipo Nominal Puro contendo uma referência mutável em memória
newtype LinearAutoDestroy a = LinearAutoDestroy (IORef (Maybe a))

initLinear :: a -> IO (LinearAutoDestroy a)
initLinear val = do
    ref <- newIORef (Just val)
    return (LinearAutoDestroy ref)

consumeLinear :: LinearAutoDestroy a -> IO a
consumeLinear (LinearAutoDestroy ref) = do
    current <- readIORef ref
    case current of
        Nothing -> error "VariableAlreadyDestroyed"
        Just val -> do
            writeIORef ref Nothing -- Destrói a referência logicamente
            return val
