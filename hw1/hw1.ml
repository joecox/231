exception ImplementMe

type t = True 
       | False 
       | If of t * t * t 
       | Int of int 
       | Plus of t * t 
       | GT of t * t

let isval t =
  match t with
      True | False -> true
    | Int _        -> true
    | _            -> false

(* Problem 1a.  *)

exception NormalForm 

let elevate v = 
  match v with
    true -> True
  | false -> False
;;

let rec step t = 
    match t with 
        If (True,t2,_)            -> t2                 (* E-IfTrue *)
      | If (False,_,t3)           -> t3                 (* E-IfFals *)
      | If (t1,t2,t3)             -> If (step t1,t2,t3) (* E-If *)

      | Plus (Int n1, Int n2)     -> Int (n1 + n2)      (* E-Plus *)
      | Plus (v, t2) when isval v -> Plus (v, step t2)  (* E-Plus2 *)
      | Plus (t1, t2)             -> Plus (step t1, t2) (* E-Plus1 *)

      | GT (Int n1, Int n2)       -> elevate (n1 > n2)  (* E-GT *)
      | GT (v, t2) when isval v   -> GT (v, step t2)    (* E-GT2 *)
      | GT (t1, t2)               -> GT (step t1, t2)   (* E-GT1 *)

      | _                             -> raise NormalForm
    ;;

(* Problem 1b. *)
  
let rec eval t = 
  match step t with
      exception NormalForm -> t
    | _t -> eval _t
;;
