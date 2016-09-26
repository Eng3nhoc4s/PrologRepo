% —————————————————————————————

%  JOGO do RASTROS

% —————————————————

% Fazer reset. e depois jogo.

% para interromper escreva um ponto quando lhe pedirem para jogar.


% a dimensao eh 8
dim(8).
adversario(sul,norte).
adversario(norte,sul).
objectivo(norte,(1,1)).
objectivo(sul,(D,D)) :-
	dim(D).
inicial((5,5)).
norte((X,Y),(X,NY)) :-
	dim(D),
	Y < D,
	NY is Y + 1.
sul((X,Y),(X,NY)) :-
	Y > 1,
	NY is Y - 1.
oeste((X,Y),(NX,Y)) :-
	X > 1,
	NX is X - 1.
leste((X,Y),(NX,Y)) :-
	dim(D),
	X < D,
	NX is X + 1.
nordeste((X,Y),(NX,NY)) :-
	dim(D),
	Y < D,
	X < D,
	NX is X + 1,
	NY is Y + 1.
nordoeste((X,Y),(NX,NY)) :-
	dim(D),
	Y < D,
	X > 1,
	NX is X - 1,
	NY is Y + 1.
sudeste((X,Y),(NX,NY)) :-
	Y > 1,
	dim(D),
	X < D,
	NX is X + 1,
	NY is Y - 1.
sudoeste((X,Y),(NX,NY)) :-
	Y > 1,
	X > 1,
	NX is X - 1,
	NY is Y - 1.

vizinha(C, CV):-
	norte(C, CV).
vizinha(C, CV):-
	sul(C, CV).
vizinha(C, CV):-
	leste(C, CV).
vizinha(C, CV):-
	oeste(C, CV).
vizinha(C, CV):-
	nordeste(C, CV).
vizinha(C, CV):-
	nordoeste(C, CV).
vizinha(C, CV):-
	sudeste(C, CV).
vizinha(C, CV):-
	sudoeste(C, CV).
% se for adjacente ah branca e nao estiver
% ocupada.
valida(C) :-
	branca(B),
	vizinha(B,C),
	\+ preta(C).
le(C) :-
	repeat,
	proximo(J),
	write(J), write('(in format X-Y.):'),
	read(X),
	mapeia(X,C),
	valida(C).
mapeia(X-Y,(NX,Y)) :-
	map(X,NX).
% fizemos apenas uma tabela de 10 letras
map(a, 1).
map(b, 2).
map(c, 3).
map(d, 4).
map(e, 5).
map(f, 6).
map(g, 7).
map(h, 8).
map(i, 9).
map(j, 10).
final(Vencedor) :-
	objectivo(Vencedor, B),
	branca(B).
final(Vencedor) :-
	\+ valida(_),
	proximo(J),
	adversario(J,Vencedor).
move_branca(NB) :-
	retract(branca(B)),
	assert(preta(B)),
	assert(branca(NB)).
jogo :- 
	final(V),
	show,
	write('Fim! O vencedor eh '),write(V).
jogo :-
	show,
	le(C),
	move_branca(C),
	alterna_jogador,
	jogo.
alterna_jogador :-
	retract(proximo(J)),
	adversario(J,O),
	assert(proximo(O)).
% reset
reset :-
	retractall(preta(_)),
	retractall(branca(_)),
	inicial(Inicial),
	assert(branca(Inicial)),
	retractall(proximo(_)),
	assert(proximo(norte)).


show :- 	
	nl,
 	dim(Dim),
 	mostra_linhas(Dim),
	tab(34),mostra_colunas(1,Dim),nl.
mostra_linhas(Dim) :-
 	Dim < 1,nl,!. 
mostra_linhas(Y) :-
	mostra1linha(Y),
	NY is Y - 1,
 	mostra_linhas(NY).

% Mostra uma linha
mostra1linha(Y) :-
 	tab(30),
	escreve_linha(Y),
	tab(2),
	dim(Dim),
	mostra_linha(Y,1,Dim).


escreve_linha(0) :-
 	write(' '),!.
escreve_linha(L) :-
 	write(L).  

% Mostra uma linha do tabuleiro  
mostra_linha(_,X,Dim) :-
  	X > Dim,!,nl,nl.
mostra_linha(Y,X,Dim) :-
 	mostra_quadrado(X,Y),
 	NX is X+1,
 	mostra_linha(Y,NX,Dim).

% Mostra o conteudo de uma celula  
mostra_quadrado(X,Y) :-
	branca((X,Y)),
 	write(' 0 '),!. 
mostra_quadrado(X,Y) :-
 	preta((X,Y)),
 	write(' * '),!. 
mostra_quadrado(_,_) :-
 	write(' . '). 


mostra_colunas(X,Lim) :-
	X > Lim,!.
mostra_colunas(X,Lim) :-
	map(MX,X),
	write(MX),
	write('  '),
	NX is X + 1,
	mostra_colunas(NX,Lim).