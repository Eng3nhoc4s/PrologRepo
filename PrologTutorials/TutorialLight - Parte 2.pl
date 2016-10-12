% *********************
% Factos simples
% *********************

joao_canta.
joao_muito_alto.

% Esta a chover
chove.

% Escadote muito alto
escadote_muito_alto.


% *********************
% Factos com argumentos
% *********************

baixinho(joao).
viu(joao, diana).


% As mulheres
mulher(diana).
mulher(ausenda).

%Os homens
homem(joao).
homem(pedro).
homem(gonzaga).
homem(gasosa).

% As cidades
cidade(napoles).
cidade(luanda).
cidade(cartagenaDasIndias).

% As vilas
vila(vilaVerde).

% As aldeias
aldeia(pitoesDasJunias).

% O Joao viu a Diana em Napoles
viu(joao,diana,napoles).
% O Joao viu o Pedro em Pitoes das Junias
viu(joao,pedro,pitoesDasJunias).
% O Joao viu o Pedro em Vila Verde
viu(joao,pedro,vilaVerde).
% A Diana viu o Gonzaga em Cartagena das I�ndias
viu(diana,gonzaga,cartagenaDasIndias).
% A Diana foi vista pelo Gasosa em Luanda
viu(gasosa,diana,luanda).
% A Diana viu o Joao em Napoles
viu(diana,joao,napoles).

mostra_homens :-
	homem(H),
	write(H),nl,
	fail
	;
	true.

% Definicao de pessoa
pessoa(P) :- homem(P).
pessoa(M) :- mulher(M).

% Todos os que foram vistos ou que viram algu�m num
% determinado lugar estiveram nesse lugar
esteve(P,L) :- viu(P,_,L).
esteve(P,L) :- viu(_,P,L).

% Pessoa invisivel - nunca foi visto por ninguem
invisivel(X) :-
	pessoa(X),
	\+ viu(_,X,_).

% aquele que esteve numa cidade e nunca tenha estado
% nem numa aldeia nem numa vila
urbano(X) :-
	esteve(X,L),
	cidade(L),
	\+ (esteve(X,H), (vila(H) ; aldeia(H))).

% para se distinguir se a pessoa existe sequer
urbano(X) :-
	\+ pessoa(X),
	write(X),write(' n�o existe na base de dados'),
	fail.


% assert(c) - Adiciona c � base de dados.
% asserta(c) - Adiciona c no in�cio da base de dados.
% assertz(c) - Adiciona c no fim da base de dados.
% retract(c) - remove c da base de dados.
% retractall(c) - remove todos os c da base de dados.
% listing - lista todos os predicados carregados para a mem�ria de
% trabalho.
% listing(c) - lista todas as cl�usulas do predicado c.

% Relogio
reset :-
	retractall(relogio(_)),
	assert(relogio(0)).

inc :-
	retract(relogio(X)),
	NewX is X + 1 mod 60,
	assert(relogio(NewX)).

mostra :-
	relogio(X),
	write(X), write(' s').

% Se num programa tivessemos um facto que precisava e ser alterado com
% retracts e asserts tinha de ser declarado como dinamico
%
% dynamic relogio/1


% Verificar se o primeiro � elemento da lista
membro(X,[X|_]).

% � membro da lista se for membro do resto
membro(X,[_|L]) :-
	membro(X,L).


% O maior de 2 elementos
maior(X,Y,X) :-
	X >= Y.
maior(X,Y,Y) :-
	Y > X.

% O maximo de uma lista unitaria
max([M],M).
% O maximo de uma lista com mais que um elemento
max([P,S|R],M) :-
	maior(P,S,X),
	max([X|R],M).


%  O corte � sempre true na� alterando a execu��o do programa da
%  esquerda para a direira mas impede o retrocesso para o lado esquerdo
%  do corpo da regra e impedindo novos �matchings� com a cabe�a da
%  regra. Sendo assim o que acontece � que:
%
% � se removem as alternativas a Q que ainda n� oforam tentadas quando se
% passou o corte
% � se removem as alternativas a P que ainda n�o foram tentadas quando se
% passou o corte


% FINDALL/3

% Se quisermos recolher as solu��es de um predicado numa lista poderemos
% usar o findall/3. Em geral findall(X,G,L) ir� instanciar L � lista de
% todas as instancia��es da vari�vel X que correspondem a solu��es de G.



% BAGOF/3

% O predicado bagof/3 � um pouco diferente do findall(X,O,L), no que
% concerne o tratamento das vari�veis n�o instanciadas no segundo
% argumento O que n�o aparecem em X.



% SETOF/3

% O predicado setoff/3 funciona exctamente como o bagof mas elimina as
% repeti��es e ordena os resultados.
