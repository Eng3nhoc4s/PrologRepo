% —————————————————————————————

%  JOGO do RASTROS

% —————————————————

% Fazer reset. e depois jogo.

% para interromper escreva um ponto quando lhe pedirem para jogar.


% a dimensao eh 8
dim(8).% o Sul eh adversario do Norte e vice versa
adversario(sul,norte).
adversario(norte,sul).% O objectivo do norte eh a casa de fundo ‘a esquerda 
objectivo(norte,(1,1)).% O objectivo do sul eh o topo direito
objectivo(sul,(D,D)) :-
	dim(D).% Esta peca eh colocada explicitamente.
inicial((5,5)).% adjacente norte
norte((X,Y),(X,NY)) :-
	dim(D),
	Y < D,
	NY is Y + 1.% adjacente sul
sul((X,Y),(X,NY)) :-
	Y > 1,
	NY is Y - 1.% adjacente oeste
oeste((X,Y),(NX,Y)) :-
	X > 1,
	NX is X - 1.% adjacente oeste
leste((X,Y),(NX,Y)) :-
	dim(D),
	X < D,
	NX is X + 1.% adjacente nordeste
nordeste((X,Y),(NX,NY)) :-
	dim(D),
	Y < D,
	X < D,
	NX is X + 1,
	NY is Y + 1.% adjacente nordeste
nordoeste((X,Y),(NX,NY)) :-
	dim(D),
	Y < D,
	X > 1,
	NX is X - 1,
	NY is Y + 1.% adjacente nordeste
sudeste((X,Y),(NX,NY)) :-
	Y > 1,
	dim(D),
	X < D,
	NX is X + 1,
	NY is Y - 1.% adjacente nordeste
sudoeste((X,Y),(NX,NY)) :-
	Y > 1,
	X > 1,
	NX is X - 1,
	NY is Y - 1.% a relacao de vizinhanca entre celulas

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
	sudoeste(C, CV).% Uma casa eh valida para deslocar a branca
% se for adjacente ah branca e nao estiver
% ocupada.
valida(C) :-
	branca(B),
	vizinha(B,C),
	\+ preta(C).% repete a leitura ate ser jogada valida
le(C) :-
	repeat,
	proximo(J),
	write(J), write('(in format X-Y.):'),
	read(X),
	mapeia(X,C),
	valida(C).% mapeia os Xs das casas, de letras para números
mapeia(X-Y,(NX,Y)) :-
	map(X,NX).% correspondencia entre letras e números
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
map(j, 10).% fim se a branca estiver num dos objectivos
final(Vencedor) :-
	objectivo(Vencedor, B),
	branca(B).% Fim se jogador cercado. Cercado quer dizer que nao ha' casas validas para jogar. % Quem ganha eh o adversario de quem joga e que esta' imobilizado.
final(Vencedor) :-
	\+ valida(_),
	proximo(J),
	adversario(J,Vencedor).% A casa com branca passa a casa com preta e a nova casa fica com a branca 
move_branca(NB) :-
	retract(branca(B)),
	assert(preta(B)),
	assert(branca(NB)).% o jogo acabou e mostra o vencedor
jogo :- 
	final(V),
	show,
	write('Fim! O vencedor eh '),write(V).% O jogo ainda nao acabou
jogo :-
	show,
	le(C),
	move_branca(C),
	alterna_jogador,
	jogo.% muda de jogador
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
% +++++++++++++++++++++++++++++++++++++++++++++++++++++% 			Mostra o Tabuleiro  

show :- 	
	nl,
 	dim(Dim),
 	mostra_linhas(Dim),
	tab(34),mostra_colunas(1,Dim),nl.   % Mostra todas as linhas do tabuleiro  
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

   % escreve o numero da linha
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