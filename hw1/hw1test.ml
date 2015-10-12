let tests = [
    True;
    If (True, False, False);
    If (False, True, False);
    If (If (True, True, False), True, False);
    If (False, If (True, False, True), True);
    If (True, If (True, False, True), True);
    If (False, Int(1), Int(2));
    Plus (Int 1, Int 2);
    Plus (Int 1, If (True, Int 2, Int 1));
    Plus (Plus (Int 1, Int 2), Plus(Int 3, Int 4));
    Plus (Int 1, Plus (Int 3, Int 4));
    GT (Int 1, Int 2);
    Plus (False, Int 3);
] ;;

let runtest fn x = 
    match fn x with
	exception NormalForm -> None
      | term -> Some term
;;

let evaltest x = eval x;;

List.combine tests (List.map (runtest step) tests);; 

let com = " SOME EVAL TESTS HERE " ;;

List.combine tests (List.map eval tests);;


