% Albuns

album('R. Stevie Moore', 'Manuscription').
album('Lane Steinberg', 'Manuscription').

album('Yukio Yung', 'Manuscription').

album('R. Stevie Moore', 'The Yung & Moore Show').
album('Yukio Yung', 'The Yung & Moore Show').


album('Jessie Evans', 'Autonervous').
album('Bettina Koster', 'Autonervous').
album('R. Stevie Moore', 'Autonervous').

album('Lucia Pamela', 'Walking on the Moon').
album('Shooby Taylor', 'The Human Horn').
album('Tiny Tim', 'God Bless Tiny Tim').
album('The Legendary Stardust Cowboy', 'Rock-It to Stardom').


% Formatos dos albuns
vinil('Rock-It to Stardom').
vinil('Walking on the Moon').
cd('God Bless Tiny Tim').
cd('Walking On the Moon').
cd('Autonervous').
cd('Manuscription').
cassete('The Yung & Moore Show').
cassete('The Human Horn').
mp3('Walking on the Moon').

% EXERCICIO 1
%
% a) cassete(X).
%
% b) album('R. Stevie Moore', F),vinil(F).
%
% c) album('R. Stevie Moore', F), album(Colaborator, F).
%
% d) album(_,B), \+ (album(A,B), album(C,B), A \= C).
%
% e) album(A,_), \+ (album(A,B), album(C,B), A \= C).
%
% f) album (A,_).
%
% g) cassete(A), \+ (vinil(A); cd(A); mp3(A)).
%
% h) album(X,_), \+ (album(X,A) ,(cassete(A); cd(A); mp3(A))).
%
% i) colabora(Art1, Art2), colabora(Art1, Art3), colabora(Art1, Art4), Art2 \= Art3, Art2 \= Art4, Art3 \= Art4.

% EXERCICIO 2
%
% a)
tem_cassete(A):-
	album(A,M),
	cassete(M).

% b)
so_tem_cassete(A):-
	album(A,M),
	cassete(M),
	B \= M,
	\+ (album(A,B), (vinil(B) ; cd(B) ; mp3(B))).

% c)
colabora(Art1,Art2):-
	album(Art1, Alb1),
	album(Art2, Alb1),
	Art1 \= Art2.

% d)
solo(A):-
	album(A,_),
	\+ colabora(A,_).

% e)
todos_os_formatos(A):-
	album(A,B),
	vinil(B),
	cd(B),
	cassete(B),
	mp3(B).

% f)
so_vinil(B):-
	vinil(B),
	\+ cd(B),
	\+ cassete(B),
	\+ mp3(B).

so_cd(B):-
	cd(B),
	\+ vinil(B),
	\+ cassete(B),
	\+ mp3(B).

so_cassete(B):-
	cassete(B),
	\+ vinil(B),
	\+ cd(B),
	\+ mp3(B).

so_mp3(B):-
	mp3(B),
	\+ vinil(B),
	\+ cd(B),
	\+ cassete(B).

um_so_formato(B):-
	so_vinil(B);
	so_cd(B);
	so_cassete(B);
	so_mp3(B).
