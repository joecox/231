---
title: Homework 4 CS 231
author: Joe Cox, Christian Gram Kalhauge
...


# Assignment 1

\infrule[I-Left]{
\iFresh{X} \andalso
\iFresh{X'} \andalso
\typeinfr{\Gamma}{t}{T}{C}
}{
\typeinfr{\Gamma}{\tLeft{t}}{X}{\{X = \TUnion{T}{X'}\} \cup C}
}

\infrule[I-Right]{
\iFresh{X} \andalso
\iFresh{X'} \andalso
\typeinfr{\Gamma}{t}{T}{C}
}{
\typeinfr{\Gamma}{\tRight{t}}{X}{\{X = \TUnion{X'}{T}\} \cup C}
}

\infrule[I-Match]{
\iFresh{X} \andalso
\iFresh{X'} \andalso
\iFresh{X''} \andalso
\typeinfr{\Gamma}{t_1}{T_1}{C_1} \andalso
\typeinfr{\Gamma,x:X'}{t_2}{T_2}{C_2} \andalso
\typeinfr{\Gamma,y:X''}{t_3}{T_3}{C_3}
}{
\typeinfr{\Gamma}{(\tMatch{t_1}{x}{t_2}{y}{t_3})}{X}
{\{X = T_2, X = T_3, T_1 =\TUnion{X'}{X''}\} \cup C_1 \cup C_2\cup C_3}
}

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
			{(\tFunction {y} {\TUnit} {\tApp{\tApp{x}{\TBool}}{\tTrue}})} {(\tApp{\tApp {x} {\TUnit}} {\tUnit})}
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
	Therefore is it not possible to apply $app$ to $app$ as the third argument.

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
        let x = r := 42 in
            !r
    ~~~

b)  ~~~ocaml
    let r = ref 41 in
        let x = ((function r : Ref Int -> (r := 41; 500)) (r := 42; ref 0)) in
            !r
    ~~~

c)  ~~~ocaml
    let f = let n = ref 5 in (function x : Unit -> n := !n + 1; !n) in
        (f ()) * (f ())
    ~~~

# Assignment 4

a)  $t = \tLet{r}{\tRef{\tUnit}}{\tFree{r};\tFetch{r}}$

    Because $\typecheck{\emptyset;\emptyset}{r}{\TRef{\TUnit}}$, then
    $\typecheck{\emptyset;\emptyset}{!r}{\TUnit}$, and
    $\typecheck{\emptyset;\emptyset}{t}{\TUnit}$.  But $t$ will be
    eventually stuck because $free\ r$ removes $r$ from $\mu$, but by
    \infr{E-DerefLoc}, $!r$ cannot step because $r$ is not in $\mu$.

b)  Progress is still uphold.

c)  Counter example:

    \begin{align*}
        t      =\ & \tFree{(\tFree{l};l)} \\
        \Sigma =\ & \{ l : Int \}      \\
        \mu    =\ & \{ l := 0 \}          \\
        T      =\ & \TUnit                \\
        t'     =\ & \tFree{l}            \\
        \mu'   =\ & \emptyset          \\
    \end{align*}

    First we have to convince ourselves that $t$ typechecks. Using
    a rule for sequence \infr{T-Seq}, and the facts that 
    $\typecheck{\emptyset;\{ l : Int \}}{\tFree{l}}{\TUnit}$ and
    $\typecheck{\emptyset;\{ l : Int \}}{l}{\TRef{\TInt}}$
    are true we can se that:

    
    \infrule[T-Seq]{
        \typecheck{\emptyset;\{ l : Int \}}{\tFree{l}}{\TUnit}
        \andalso
        \typecheck{\emptyset;\{ l : Int \}}{l}{\TRef{\TInt}}
    }{
        \typecheck{\emptyset;\{ l : Int \}}{\tFree{l};l}{\TRef{\TInt}} 
    }
    
    \infrule[T-Free]{
        \typecheck{\emptyset;\{ l : Int \}}{\tFree{l};l}{\TRef{\TInt}} 
    }{
        \typecheck{\emptyset;\{ l : Int \}}
        {\tFree{(\tFree{l};l)}}{\TUnit} 
    }

    Secondly we have to show that $<t | \mu>$ steps, which is does:
    $<\tFree{(\tFree{l};l)} | \{l := Int\}> \stepsto <\tFree{l}
    | \emptyset>$  

    And lastly we have to show that $t'$ does not typecheck, under any
    sigma $\Sigma' \models \mu'$. And that is pretty clear because
    $\Sigma'$ must be empty like $\mu'$ and $\tFree{l}$, requires $l \in
    dom(\Sigma')$ to typecheck.
