# Simple Stack-based interpreter

A LIFO stack machine with _add, subtract, multiply_ and _divide_ operators.

## How to run:

```console
ghci main.hs
```

Then:

```haskell
λ> evaluate [Push 17, Push 2, Do Multiply, Push 35, Do Add] []
[69.0]
```
