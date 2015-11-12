---
title: Homework 4 CS 231
author: Joe Cox, Christian Gram Kalhauge
...


# Assignment 1

# Assignment 2

> Show both the rewritten term $t$, and the type $T$, if they exists:

a)  \begin{align*}
	\Gamma =& \emptyset \\
	t =& \tApp{\tApp {( \tTFun{X}{\tFunction{x}{X}{x}} )} {\TBool}} {\tTrue} \\
	T =& \TBool 
	\end{align*}

b)  \begin{align*}
	\Gamma =& \emptyset \\
	t =& \tFunction {x} {(\TForall{X}{\TFun{X}{\TUnit}})} {
		\tApp
			{(\tFunction {y} {\TUnit} {\tApp{\tApp{x}{\TBool}}{\tTrue}})}
			{(\tApp{\tApp {x} {\TUnit}} {\tUnit})}
		} \\
	T =& \TFun{(\TForall{X}{\TFun{X}{\TUnit}})}{\TUnit}
	\end{align*}

c)  \begin{align*}
	\Gamma =& \emptyset \\
	t =& \tFunction {x} {(\TForall{X}{\TFun{X}{\TBool}})} {
		\tApp
			{(\tFunction {y} {\TBool} {\tApp{\tApp{x}{\TBool}}{\tTrue}})}
			{(\tApp{\tApp {x} {\TUnit}} {\tUnit})}
		} \\
	T =& \TFun{(\TForall{X}{\TFun{X}{\TBool}})}{\TBool}
	\end{align*}

d)  \begin{align*}
	\Gamma =& \{ app : \TForall{X}{\TForall{X'}{\TFun{(\TFun{X}{X'})}{\TFun{X}{X'}}}} \} \\
	t =& \tApp{\tApp{\tApp{app}{\TUnit}}{\TBool}}{\tFunction{x}{\TUnit}{\tTrue}}\\
	T =& \TFun{\TUnit}{\TBool}
	\end{align*}

e)  Clearly not possible, because the $app$ is of type $\TForall{X}{(\ldots)}$ and
	$app$ expects something of type $\TFun{(\ldots)}{(\ldots)}$ its third argument.
	Therefore is it not possible to apply $app$ to $app$ as a the third argument.

f)  \begin{align*}
	\Gamma =& \{ app : \TForall{X}{\TForall{X'}{\TFun{(\TFun{X}{X'})}{\TFun{X}{X'}}}} \} \\
	t =& \tApp
		{\tApp
			{\tApp{app}{(\TFun{\TUnit}{\TBool})}}
			{(\TFun{\TUnit}{\TBool})}}
		{(\tApp{\tApp{app}{\TUnit}}{\TBool})}\\
	T =& \TFun{\TFun{(\TFun{\TUnit}{\TBool})}{\TUnit}}{\TBool}
	\end{align*}

# Assignment 3
a)  ~~~ocaml
    let r = ref 41 in
        let x = r := 42; () in
            !r
    ~~~

    $\texttt{let\ r\ =\ ref\ 41\ in}$\newline
    $\texttt{let\ r\ =\ \textbf{r\ :=\ !r\ +\ 1;\ 1}\ in}$\newline
    $\texttt{\ \ !r;;}$

b)  ~~~ocaml
    let r = ref 41 in
        let x = ((function r : Ref Int -> (r := 41; 500)) (r := 42; ref 0)) in
            !r
    ~~~

    $\texttt{let\ r\ =\ ref\ 41\ in}$\newline
    $\texttt{let\ x\ =\ ((function\ r:Ref\ Int\ ->\ (r\ :=\ 41;\ 500))}$\newline
    $\texttt{\ \ \ \ \ \ \ \ \ \ \ \textbf{(let\ r2\ =\ ref\ 41\ in\ r\ :=\ !r\ +\ 1;\ r2)})}$\newline
    $\texttt{\ \ in\ !r;;}$

c) 
    ~~~ocaml
    let f = let n = ref 5 in (function x : Unit -> n := !n + 1; !n) in
        (f ()) * (f ())
    ~~~
    $\texttt{let\ f\ =\ \textbf{(let\ n\ =\ ref\ 5\ in\ function\ x\ ->\ (n\ :=\ !n\ +\ 1;\ !n))}\ in}$\newline
    $\texttt{\ \ (f\ ())\ *\ (f\ ());;}$

# Assignment 4

a) $t = \tLet{r}{ref\ \tUnit}{free\ r;\ !r}$

   Because $\typecheck{\emptyset;\emptyset}{r}{\TRef{\TUnit}}$, then $\typecheck{\emptyset;\emptyset}{!r}{\TUnit}$, and $\typecheck{\emptyset;\emptyset}{t}{\TUnit}$.  But $t$ will be eventually stuck because $free\ r$ removes $r$ from $\mu$, but by \infr{E-DerefLoc}, $!r$ cannot step because $r$ is not in $\mu$.
