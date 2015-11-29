---
title: Homework 5 CS 231
author: Joe Cox, Christian Gram Kalhauge
...


# Assignment 1

# Assignment 2

# Assignment 3

# Assignment 4

# Assignment 5

> Write the liveness property of your queueing system using the
> predicates:
>
> $P(x)$, which is true when customer x is on a phone call.
>
> $T(x)$, which is true when customer x receives a ticket.

a)  $\forall x . \forever \eventually P(x) \lor \eventually T(x)$

b)  it's the same the liveness properties are not dependent on the
    implementation. But for this implementation, we can give the stronger
    grantee that everybody will eventually get a token.

    $\forall x . \eventually T(x)$
