---
title: Homework 5 CS 231
author: Joe Cox, Christian Gram Kalhauge
...


# Assignment 1

a)  Adding effects to the rules:
    
    \infrule[T-Throw]{}{
        \typeeffect
            {\Gamma}
            {\tThrow}
            {T}
            {\{\mathtt{exn}\}}
    }

    \infrule[T-TryCatch]{
        \typeeffect
            {\Gamma}
            {t_1}
            {T}
            {\Phi_1}
        \andalso
        \typeeffect
            {\Gamma}
            {t_2}
            {T}
            {\Phi_2}
    }{
        \typeeffect
            {\Gamma}
            {\tTryCatch{t_1}{t_2}}
            {T}
            {\Phi_2}
    }

b) Due to space constraints, we show the typing derivation as a sequence of applied rules, from the bottom of the tree to the top.

    \infrule[T-Var]{
        \emptyset,x\typeof\TBool(x) = \TBool
    }{
        \typeeffect{\emptyset,x\typeof\TBool}{x}{\TBool}{\emptyset}
    }

    \infrule[T-True]{}{
        \typeeffect{\emptyset,x\typeof\TBool}{\tTrue}{\TBool}{\emptyset}
    }

    \infrule[T-Throw]{}{
        \typeeffect{\emptyset,x\typeof\TBool}{\tThrow}{\TBool}{\{\mathtt{exn}\}}
    }

    \infrule[T-If]{
        \typeeffect{\emptyset,x\typeof\TBool}{x}{\TBool}{\emptyset}
        \\
        \typeeffect{\emptyset,x\typeof\TBool}{\tTrue}{\TBool}{\emptyset}
        \\
        \typeeffect{\emptyset,x\typeof\TBool}{\tThrow}{\TBool}{\{\mathtt{exn}\}}
    }{
        \typeeffect{\emptyset,x\typeof\TBool}{\tIf{x}{\tTrue}{\tThrow}}{\TBool}{\{\mathtt{exn}\}}
    }

    \infrule[T-Fun]{
        \typeeffect{\emptyset,x\typeof\TBool}{\tIf{x}{\tTrue}{\tThrow}}{\TBool}{\{\mathtt{exn}\}}
    }{
        \typeeffect{\emptyset}{\tFunction{x}{\TBool}{\tIf{x}{\tTrue}{\tThrow}}}{\TFunEffect{\TBool}{\TBool}{\{\mathtt{exn}\}}}{\emptyset}
    }

    \infrule[T-App]{
        \typeeffect{\emptyset}{\tFunction{x}{\TBool}{\tIf{x}{\tTrue}{\tThrow}}}{\TFunEffect{\TBool}{\TBool}{\{\mathtt{exn}\}}}{\emptyset}
        \\
        \typeeffect{\emptyset}{\tTrue}{\TBool}{\emptyset}
    }{
        \typeeffect{\emptyset}{\tApp{(\tFunction{x}{\TBool}{\tIf{x}{\tTrue}{\tThrow}})}{\tTrue}}{\TBool}{\{\mathtt{exn}\}}
    }

    \infrule[T-False]{}{
        \typeeffect{\emptyset}{\tFalse}{\TBool}{\emptyset}
    }

    \infrule[T-TryCatch]{
        \typeeffect{\emptyset}{\tApp{(\tFunction{x}{\TBool}{\tIf{x}{\tTrue}{\tThrow}})}{\tTrue}}{\TBool}{\{\mathtt{exn}\}}
        \\
        \typeeffect{\emptyset}{\tFalse}{\TBool}{\emptyset}
    }{
        \typeeffect{\emptyset}{\tTryCatch{\tApp{(\tFunction{x}{\TBool}{\tIf{x}{\tTrue}{\tThrow}})}{\tTrue}}{\tFalse}}{\TBool}{\emptyset}
    }

# Assignment 2

a) $\TPair{(\TFun{\TTop}{\TRef{\TTop}})}{\TBool} \subtypeq \TPair{(\TFun{\TTop}{\TTop})}{\TTop}$

   Yes.

b) $\TFun{({\TRef{\TTop}})}{\TTop} \subtypeq \TFun{\TTop}{\TTop}$

   No, ...

c) $\TRef{\TTop} \subtypeq \TRef{(\TPair{\TTop}{\TTop})}$
   
   No, $\tApp{(\tFunction{x}{\TRef{(\TPair{\TTop}{\TTop})}}{\tSnd{\tFetch{x}}})}{\tRef{5}}$.

d) $\TRef{(\TPair{\TTop}{\TTop})} \subtypeq \TRef{\TTop}$

   No, $\tSnd{\tFetch{(\tApp{(\tFunction{x}{\TRef{\TTop}}{x})}{\tRef{5}})}}$

# Assignment 3

a)  Write new type rules for integer constants, addition, and unary
    negation.

    \infrule[T-IntConst]{}{\typecheck{\Gamma}{n}{\TQS{n}{\TInt}}}
    
    \infrule[T-Add]{
        \typecheck{\Gamma}{t_1}{T_1} 
        \andalso 
        \typecheck{\Gamma}{t_2}{T_2} 
        \andalso T = T_1 +_T T_2
    }{
        \typecheck{\Gamma}{\tAdd{t_1}{t_2}}{T} 
    }
    
    \infrule[T-Neg]{
        \typecheck{\Gamma}{t}{T'} 
        \andalso T = \TNeg T'
    }{
        \typecheck{\Gamma}{\tNeg{t}}{T} 
    }

    Where 
    
    $$ T_1 +_T T_2 = 
    \begin{cases} 
        \TQS{n_1 [[+]] n_2}{\TInt}, &if\ T_1 = \TQS{n_1}{\TInt} \land T_2 = \TQS{n_2}{\TInt} \\
        \TQS{\TAny}{\TInt}, & otherwise
    \end{cases} 
    $$
    
    $$ \TNeg{T} = 
    \begin{cases} 
        \TQS{0 [[-]] n}{\TInt}, &if\ T = \TQS{n}{\TInt}\\
        \TQS{\TAny}{\TInt}, & otherwise
    \end{cases} 
    $$

b)  Show the $\Gamma$ that would be produces after each program point.
    ```python
    x := 8;            
    if (x > 0)         # G = { x <- 8 Int }
        y := x + x;    # G = { x <- 8 Int, y <- 16 Int }
        x := x + 1;    # G = { x <- 9 Int, y <- 16 Int }
    else               
        y := 0;        # G = { y <- 0 Int, x <- 8 Int }
        x := x + 1;    # G = { x <- 9 Int, y <- 0 Int }
    # Overapproximation, G = { x <- 9 Int, y <- any Int }
    while (x > 0) do   # G = { x <- any Int, y <- any Int }, Loop invariant 
        x := x - 1;    # G = { x <- any Int, y <- any Int }
        y := 5;        # G = { x <- any Int, y <- any Int }
    ```              

# Assignment 4

# Assignment 5

a)  $\forall x . \forever \eventually P(x) \lor \eventually T(x)$

b)  It's the same, as the liveness properties, should not be dependent
    on the implementation. But for this implementation, we can give the
    stronger grantee that everybody will eventually get a token if not
    always on the phone.

    $\forall x . \eventually \forever P(x) \lor \eventually T(x)$
