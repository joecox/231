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

# Assignment 3

# Assignment 4

# Assignment 5
