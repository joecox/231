exception ImplementMe

(* Problem 5 *)

(* Type t represents abstract syntax trees for the lambda calculus.  A
variable name is represented as an OCaml string. We include the value
True so that you have a simple value to use for testing purposes.

Example: the term ((function x -> x x) (function x -> x)) would be represented as follows:

   FunCall(Function("x", FunCall(Var "x", Var "x")), Function("x", Var "x"))

*)

type t = True | Var of string | Function of string * t | FunCall of t * t

(* 5a: Implement the subst function below, which substitutes a given
   value v for all free occurrences of the variable named x in term t,
   returning the resulting term. You may assume that v has no free
   variables. *)

let rec subst (x:string) (v:t) (t:t) =
  let subIn = subst x v  (* x or v do not change *)
  in match t with
    | Var s            when s = x  -> v
    | Function (s, _t) when s <> x -> Function (s, subIn _t)
    | FunCall (t1, t2)             -> FunCall (subIn t1, subIn t2)
    | _                            -> t
;;

(* 5b: Implement the step function, which takes a term of type t above
and produces a new term that results from taking one step of
computation on t.  If t is a normal form, the step function should
raise the NormalForm exception declared below. *)

exception NormalForm

let rec step t =
  match t with
  | FunCall (Function (s, _t), True) -> subst s True _t (* For debugging purposes *)
  | FunCall (Function (s1, _t1),
             (Function _ as t2))     -> subst s1 t2 _t1
  | FunCall ((Function _ as t1), t2) -> FunCall (t1, step t2)
  | FunCall (t1, t2)                 -> FunCall (step t1, t2)
  | _                                -> raise NormalForm
;;
