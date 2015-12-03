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

    Our effect for $\infr{T-TryCatch}$ is the intersection of $\Phi_1$ and $\Phi_2$, because the effect is at most $\tEffExn$, but only when the catch block throws an exception, which will only occur if the try block throws an exception.

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

a) $\TPair{(\TFun{\TTop}{\TRef{\TTop}})}{\TBool} \subtypeq \TPair{(\TFun{\TTop}{\TTop})}{\TTop}$

   Yes.

b) $\TFun{({\TRef{\TTop}})}{\TTop} \subtypeq \TFun{\TTop}{\TTop}$

   No, ...

c) $\TRef{\TTop} \subtypeq \TRef{(\TPair{\TTop}{\TTop})}$
   
   No, $\tSnd{\tFetch{(\tRef{1})}}$.

d) $\TRef{(\TPair{\TTop}{\TTop})} \subtypeq \TRef{\TTop}$

   No, $\tApp{(\tFunction{x}{\TRef{\TTop}}{\tUpdate{x}{1}})}{\tRef{\tPair{1}{2}}}$

# Assignment 3

# Assignment 4

a)  ~~~
    if (x != null) then
      n := x.f;
      [ x != null ]
      [ x.f < a.length ]
    else
      n := z-1;
      [ z-1 < a.length ]
    [ a != null ]
    res := a[n];
    ~~~

b)  $I = (k \leq n) \land (r = k^2)$

# Assignment 5
