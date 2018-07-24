	
	%print
	printom([H|T]) :-
	( H > 0 ->
	  write(assignment), write('\t'), write(H), write('\t'), write(1), nl,
	  printom(T);
	  P is abs(H),
	  write(assignment), write('\t'), write(P),write('\t'), write(0),nl,
	  printom(T)).
	printom([]).

	% reduce(+ListOfList, +Elem, +Elem, -ListOfList)
	update([], _, _, []).
	update([K|F], L, M, [J|G]) :-
	member(M,K),
	select(M, K, J), !,
	J \== [],
	update(F, L, M, G).
	update([K|F], L, M, [K|G]) :-
	update(F, L, M, G).
	update([K|F], L, M, G) :-
	member(L, K), !,
	update(F, L, M, G).
	update([K|F], L, M, [K|G]) :-
	update(F, L, M, G).



	% dpll(+ListOfLists, -List)
	dpll([[L|_]|F], X):-
	X = [L|V],
	M is -1*L,
	update(F, L, M, G),
	dpll(G, V).

	dpll([[L|[K|_]]|F], X):-
	X =  [M|V],
	M is -L,
	update(F, M, L, G),
	dpll([K|G], V).

	dpll([], []).



	sat_with_print(Clauses) :-
	dpll(Clauses, X),printom(X),nl.

	sat_with_print(_):-
	 write('UNSATISFIABLE'),nl.
