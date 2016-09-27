% Albuns

album('Rodrigo', 'So Vinil').
album('R. Stevie Moore', 'Manuscription').
album('Lane Steinberg', 'Manuscription').

album('R. Stevie Moore', 'The Yung & Moore Show').
album('Yukio Yung', 'The Yung & Moore Show').
album('Jessie Evans', 'Autonervous').
album('Bettina Koster', 'Autonervous').
album('Lucia Pamela', 'Walking on the Moon').
album('Shooby Taylor', 'The Human Horn').
album('Tiny Tim', 'God Bless Tiny Tim').
album('The Legendary Stardust Cowboy', 'Rock-It to Stardom').


% Formatos dos albuns
vinil('So Vinil').
vinil('Rock-It to Stardom').
vinil('Walking on the Moon').
cd('God Bless Tiny Tim').
cd('Walking on the Moon').
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
% d)
colabora(Art1,Art2):-
	album(Art1, Alb1),
	album(Art2, Alb1),
	Art1 \= Art2.

albumSingleArtist:-
	album(A,B),
	\+ colabora(A,_),
	write(B),
	nl,
	fail.
albumSingleArtist.

% e) album(A,_), \+ colabora(A,_).
%
% f) album (A,_).
%
% g) album(_,A),cassete(A).
%
% h)
musicosDoVinil:-
	album(A,B),
	vinil(B),
	write(A),
	nl,
	fail.
musicosDoVinil.

% i)
maisQueDoisColabs:-
	album(A,_),
	colabora(A,C),
        colabora(A,D),
	colabora(A,E),
	A \= C,	A \= D,	A \= E,
	C \= D, C \= E,
	D \= E,
	write(A),
	nl,
	fail.

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
	\+ (album(A,B), (vinil(B) ; cd(B) ; mp3(B))).

% c)
colaborou(A,B):-
	colabora(A,B).

% d)
solo(A):-
	album(A,_),
	\+ colaborou(A,_).

% e)
todos_os_formatos(A):-
	album(A,B),
	vinil(B),
	cd(B),
	cassete(B),
	mp3(B).

% f)
so_vinil(B):-
	album(_,B),
	vinil(B),
	\+ (cd(B);cassete(B);mp3(B)).

so_cd(B):-
	album(_,B),
	cd(B),
	\+ (vinil(B);cassete(B);mp3(B)).

so_cassete(B):-
	album(_,B),
	cassete(B),
	\+ (vinil(B);cd(B);mp3(B)).

so_mp3(B):-
	album(_,B),
	mp3(B),
	\+ (vinil(B);cd(B);cassete(B)).

um_so_formato(B):-
	(so_vinil(B);so_cd(B);so_cassete(B);so_mp3(B)).