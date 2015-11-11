---
title: Homework 4 CS 231
author: Joe Cox, Christian Gram Kalhauge
...


# Assignment 1

# Assignment 2

# Assignment 3
a) $\texttt{let\ r\ =\ ref\ 41\ in}$\newline
   $\texttt{let\ r\ =\ \textbf{r\ :=\ !r\ +\ 1;\ 1}\ in}$\newline
   $\texttt{\ \ !r;;}$

b) $\texttt{let\ r\ =\ ref\ 41\ in}$\newline
   $\texttt{let\ x\ =\ ((function\ r:Ref\ Int\ ->\ (r\ :=\ 41;\ 500))}$\newline
   $\texttt{\ \ \ \ \ \ \ \ \ \ \ \textbf{(let\ r2\ =\ ref\ 41\ in\ r\ :=\ !r\ +\ 1;\ r2)})}$\newline
   $\texttt{\ \ in\ !r;;}$

c) $\texttt{let\ f\ =\ \textbf{(let\ n\ =\ ref\ 5\ in\ function\ x\ ->\ (n\ :=\ !n\ +\ 1;\ !n))}\ in}$\newline
   $\texttt{\ \ (f\ ())\ *\ (f\ ());;}$

# Assignment 4

a) $t = \tLet{r}{ref\ \tUnit}{free\ r;\ !r}$

   Because $\typecheck{\emptyset;\emptyset}{r}{\TRef{\TUnit}}$, then $\typecheck{\emptyset;\emptyset}{!r}{\TUnit}$, and $\typecheck{\emptyset;\emptyset}{t}{\TUnit}$.  But $t$ will be eventually stuck because $free\ r$ removes $r$ from $\mu$, but by \infr{E-DerefLoc}, $!r$ cannot step because $r$ is not in $\mu$.
