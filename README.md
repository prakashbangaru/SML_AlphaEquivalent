# SML_AlphaEquivalent
Write a curried function alpha that takes two l-expressions as input and checks whether they are a- equivalent.

 Lambda-expressions can be modelled using the following datatype:
datatype lambdaexp = V of int
| App of lambdaexp * lambdaexp
| Abs of int * lambdaexp
For instance, Abs(2, Abs(3,(V 3))) stands for lv2 : (lv3 :v3).

Write a curried function alpha that takes two lambda-expressions as input and checks whether they are a-
equivalent.

For instance,
- alpha;
val it = fn : lambdaexp -> lambdaexp -> bool
- alpha (Abs(0, App(V 0, V 0))) (Abs(1, App(V 1, V 0)));
val it = false : bool
- alpha (Abs(0, App(V 0, V 0))) (Abs(1, App(V 1, V 1)));
val it = true : bool
- alpha (Abs(0, Abs(1, V 0))) (Abs(0, Abs(1, V 1)));
val it = false : bool
- alpha (Abs(0, Abs(1, V 0))) (Abs(1, Abs(0, V 1)));
val it = true : bool
- alpha (App(V 0, Abs(0, V 1))) (App(V 1, Abs(2, V 1)));
val it = false : bool
- alpha (App(V 0, Abs(0, V 1))) (App(V 0, Abs(2, V 1)));
val
