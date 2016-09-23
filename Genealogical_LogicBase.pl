% Males
male(rodrigo).
male(rafael).
male(antonio).
male(eduardo).
male(lucio).
male(luis).

% Females
female(fatima).
female(perpetua).
female(joana).
female(luisa).
female(marta).
female(sara).
female(vanessa).

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

% Relationships
mother(Mother,Child):-
	parent(Mother,Child),
	female(Mother).

father(Father,Child):-
	parent(Father,Child),
	male(Father).

brother(Person1,Person2):-
	parent(Parent,Person1),
	parent(Parent,Person2),
	Person1 \= Person2.

grandfather(Person):-
	father(Person, Child),
	(father(Child,_);mother(Child,_)).

grandmother(Person):-
	mother(Person, Child),
	(father(Child,_);mother(Child,_)).
