% Males
male(rodrigo).
male(rafael).
male(antonio).
male(eduardo).
male(lucio).
male(luis).
male(joaquim).
male(manuel).

% Females
female(fatima).
female(perpetua).
female(joana).
female(luisa).
female(marta).
female(sara).
female(vanessa).
female(bruna).
female(delfina).

% Parent-child relationships
%Mother side family
parent(eduardo, fatima).
parent(eduardo, manuel).
parent(perpetua, fatima).
parent(perpetua, manuel).

% Father side family
parent(lucio, antonio).
parent(lucio, joaquim).
parent(lucio, luisa).
parent(joana, antonio).
parent(joana, joaquim).
parent(joana, luisa).

% Nuclear family
parent(antonio, rafael).
parent(antonio, rodrigo).
parent(fatima, rafael).
parent(fatima, rodrigo).

% Cousins
parent(luisa, luis).
parent(luisa, marta).
parent(luisa, sara).
parent(luisa, vanessa).

parent(manuel, bruna).
parent(delfina, bruna).

% Relationships
%
% Mother M is child's C mother
mother(M, C):-
	parent(M, C),
	female(M).

% Father F is child's C father
father(F, C):-
	parent(F, C),
	male(F).

% P is parent of S
isParentOf(P,S):-
	mother(P,S);
	father(P,S).

% C1 and C2 have at least the same mother or father
sameParents(C1, C2):-
	((mother(M,C1),mother(M,C2));
	(father(F,C1),father(F,C2))),
	C1 \= C2.


% B is P's brother
brother(B, P) :-
	male(B),
	sameParents(B,P),
	B \= P.

% S is P's sister
sister(S, P) :-
	female(S),
	sameParents(S,P),
	S \= P.

% Grandparent rule
grandparent(G, P):-
	( father(G,A) ; mother(G,A) ),
	( father(A,P) ; mother(A,P) ).

% G is P's grandfather
grandfather(G, P):-
	male(G),
	grandparent(G,P).

% G is P's grandfather
grandmother(G,P):-
	female(G),
	grandparent(G,P).

% U is P's uncle
uncle(U,P):-
	male(U),
	sameParents(U,A),
	isParentOf(A,P).

% A is P's aunt
aunt(A,P):-
	female(A),
	sameParents(A,B),
	isParentOf(B,P).

% C is cousin of P
cousin(C,P):-
	isParentOf(P1,C),
	isParentOf(P2,P),
	sameParents(P1,P2).
