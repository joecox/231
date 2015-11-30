---
title: Homework 5 CS 231
author: Joe Cox, Christian Gram Kalhauge
...


# Assignment 1

# Assignment 2

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

> Write the liveness property of your queueing system using the
> predicates:
>
> $P(x)$, which is true when customer x is on a phone call.
>
> $T(x)$, which is true when customer x receives a ticket.

a)  $\forall x . \forever \eventually P(x) \lor \eventually T(x)$

b)  It's the same the liveness properties are not dependent on the
    implementation. But for this implementation, we can give the stronger
    grantee that everybody will eventually get a token.

    $\forall x . \eventually T(x)$
