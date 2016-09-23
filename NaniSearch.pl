%Rooms
room(kitchen).
room(office).
room(hall).
room('dining room').
room(cellar).

% Location of things
location(desk, office).
location(apple, kitchen).
location(flashlight, desk).
location('washing machine', cellar).
location(nani, 'washing machine').
location(broccoli, kitchen).
location(crackers, kitchen).
location(computer, office).

% One way doors between rooms
door(office, hall).
door(kitchen, office).
door(hall, 'dining room').
door(kitchen, cellar).
door('dining room', kitchen).

% Propperties of items
edible(apple).
edible(crackers).

tastes_yucky(broccoli).

% Initial status of player location and flashlight
turned_off(flashlight).

here(kitchen).


% There is something to eat in room X if X is located in Y and X is
% edible

where_food(Food, Where) :-
	location(Food, Where),
	edible(Food).

% Map door connections
connect(X,Y) :- door(X,Y).
connect(X,Y) :- door(Y,X).

% List connections
list_connections(Place) :-
  connect(Place, X),
  tab(2),
  write(X),
  nl,
  fail.
% IS ADDED SO IT DOESNT FAIL
list_connections(_).


% List things in a place
list_things(Place) :-
	location(X, Place),
	tab(2),
	write(X),
	nl,
	fail.
% IS ADDED SO IT DOESNT FAIL
list_things(_).

% Look around
look :-
  here(Place),
  write('You are in the '), write(Place), nl,
  write('You can see:'), nl,
  list_things(Place),
  write('You can go to:'), nl,
  list_connections(Place).
