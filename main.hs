{-# LANGUAGE LambdaCase #-}

type StackValue = Double

type Stack = [StackValue]

data Op = Add | Minus | Multiply | Divide

data StackInstructions
  = Do Op
  | Push StackValue
  | Swap
  | Pop

calcOp :: Op -> Stack -> Stack
calcOp = \case
  Add -> \case
    x : y : xs -> (x + y) : xs
    _ -> error "Add: stack too short"
  Minus -> \case
    x : y : xs -> (x - y) : xs
    _ -> error "Minus: stack too short"
  Multiply -> \case
    x : y : xs -> (x * y) : xs
    _ -> error "Multiply: stack too short"
  Divide -> \case
    x : y : xs ->
      if y == 0
        then error "Divide: divide by zero"
        else (x / y) : xs
    _ -> error "Divide: stack too short"

evaluate :: [StackInstructions] -> Stack -> Stack
evaluate = \case
  [] -> id
  (Do op : xs) -> evaluate xs . calcOp op
  (Push x : xs) -> evaluate xs . (x :)
  (Swap : xs) ->
    evaluate xs . \case
      x : y : xs -> y : x : xs
      _ -> error "Swap: stack too short"
  (Pop : xs) ->
    evaluate xs . \case
      _ : xs -> xs
      _ -> error "Pop: stack too short"