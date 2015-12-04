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
            {\tEffExn}
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
            {\Phi_1 \cap \Phi_2}
    }

    Our effect for $\infr{T-TryCatch}$ is the intersection of $\Phi_1$
    and $\Phi_2$, because the effect is at most $\tEffExn$, but only
    when the catch block throws an exception, which will only occur if
    the try block throws an exception.

b)  Due to space constraints, we show the typing derivation as
    a sequence of applied rules, from the bottom of the tree to the top.

    \infrule[T-Var]{
        \emptyset,x\typeof\TBool(x) = \TBool
    }{
        \typeeffect{\emptyset,x\typeof\TBool}{x}{\TBool}{\emptyset}
    }

    \infrule[T-True]{}{
        \typeeffect{\emptyset,x\typeof\TBool}{\tTrue}{\TBool}{\emptyset}
    }

    \infrule[T-Throw]{}{
        \typeeffect{\emptyset,x\typeof\TBool}{\tThrow}{\TBool}{\tEffExn}
    }

    \infrule[T-If]{
        \typeeffect{\emptyset,x\typeof\TBool}{x}{\TBool}{\emptyset}
        \\
        \typeeffect{\emptyset,x\typeof\TBool}{\tTrue}{\TBool}{\emptyset}
        \\
        \typeeffect{\emptyset,x\typeof\TBool}{\tThrow}{\TBool}{\tEffExn}
    }{
        \typeeffect{\emptyset,x\typeof\TBool}{\tIf{x}{\tTrue}{\tThrow}}{\TBool}{\tEffExn}
    }

    \infrule[T-Fun]{
        \typeeffect{\emptyset,x\typeof\TBool}{\tIf{x}{\tTrue}{\tThrow}}{\TBool}{\tEffExn}
    }{
        \typeeffect{\emptyset}{\tFunction{x}{\TBool}{\tIf{x}{\tTrue}{\tThrow}}}{\TFunEffect{\TBool}{\TBool}{\tEffExn}}{\emptyset}
    }

    \infrule[T-App]{
        \typeeffect{\emptyset}{\tFunction{x}{\TBool}{\tIf{x}{\tTrue}{\tThrow}}}{\TFunEffect{\TBool}{\TBool}{\tEffExn}}{\emptyset}
        \\
        \typeeffect{\emptyset}{\tTrue}{\TBool}{\emptyset}
    }{
        \typeeffect{\emptyset}{\tApp{(\tFunction{x}{\TBool}{\tIf{x}{\tTrue}{\tThrow}})}{\tTrue}}{\TBool}{\tEffExn}
    }

    \infrule[T-False]{}{
        \typeeffect{\emptyset}{\tFalse}{\TBool}{\emptyset}
    }

    \infrule[T-TryCatch]{
        \typeeffect{\emptyset}{\tApp{(\tFunction{x}{\TBool}{\tIf{x}{\tTrue}{\tThrow}})}{\tTrue}}{\TBool}{\tEffExn}
        \\
        \typeeffect{\emptyset}{\tFalse}{\TBool}{\emptyset}
    }{
        \typeeffect{\emptyset}{\tTryCatch{(\tApp{(\tFunction{x}{\TBool}{\tIf{x}{\tTrue}{\tThrow}})}{\tTrue})}{\tFalse}}{\TBool}{\emptyset}
    }

# Assignment 2

a)  $\TPair{(\TFun{\TTop}{\TRef{\TTop}})}{\TBool} \subtypeq \TPair{(\TFun{\TTop}{\TTop})}{\TTop}$

    Yes.

b)  $\TFun{({\TRef{\TTop}})}{\TTop} \subtypeq \TFun{\TTop}{\TTop}$

    No, $\tApp{(\tFunction{x}{\TRef{\TTop}}{\tFetch{x}})}{1}$

c)  $\TRef{\TTop} \subtypeq \TRef{(\TPair{\TTop}{\TTop})}$

    No, $\tSnd{\tFetch{(\tRef{1})}}$.

d)  $\TRef{(\TPair{\TTop}{\TTop})} \subtypeq \TRef{\TTop}$

    No, $$\tLet{x}{
          \tRef{\tPair{0}{0}}
        }{
          \tSeq{
            \tApp{
               (\tFunction{y}{\TRef{\TInt}}{\tUpdate{y}{1}})
             }{x}
          }{\tSnd{\tFetch{x}}}
        }
        $$ 
           


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
    x := 8;            # G = { x <- 8 Int }
    if (x > 0)         
        y := x + x;    # G = { x <- 8 Int, y <- 16 Int }
        x := x + 1;    # G = { x <- 9 Int, y <- 16 Int }
    else               
        y := 0;        # G = { y <- 0 Int, x <- 8 Int }
        x := x + 1;    # G = { x <- 9 Int, y <- 0 Int }
    # Overapproximation, G = { x <- 9 Int, y <- any Int }
    while (x > 0) do   # GFix = { x <- any Int, y <- any Int }
        x := x - 1;    # G = { x <- any Int, y <- any Int }
        y := 5;        # G = { x <- any Int, y <- any Int }
    ```              

# Assignment 4

a)  We just want to prove `true` in the program, using weakest precondition.
    Where `true` represent that the program is correct. To be able to argue
    about the preconditions of a term we add implicit assertions above .

    ~~~java
    l1: if (x != null) then // wpl1 = WP(..., wlp4) = (x != null => wpl2) && (x == null => wlp3)
          [ assert x != null; ]
    l2:   n := x.f;         // wpl2 = WP(..., wpl3) = x != null && a != null && 0 >= x.f >= a.length
        else
    l3:   n := z-1;         // wpl3 = WP(..., wpl4) = a != null && 0 >= z - 1 >= a.length
        [ assert a != null ]
        [ assert 0 >= n >= a.length ]
    l4: res := a[n];        // wpl4 = WP(..., true) = a != null && 0 >= n >= a.length
    ~~~

    The entire code have the weakest precondition:

    ~~~
    WP(code, true) = wpl1 =
        (x != null =>  x != null && a != null && 0 >= x.f >= a.length) && 
        (x == null => a != null && 0 >= z - 1 >= a.length) &&
    ~~~

b)  $I = (r = k^2 \land s = 2k + 1)$

# Assignment 5

a)  $\forall x . \forever \eventually P(x) \lor \eventually T(x)$

b)  It's the same, as the liveness properties, should not be dependent
    on the implementation. But for this implementation, we can give the
    stronger guarantee that everybody will eventually get a ticket if not
    eventually always on the phone.

    $\forall x . \eventually \forever P(x) \lor \eventually T(x)$
