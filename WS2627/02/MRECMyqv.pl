% my_append/3
% my_append(L1, L2, L3) is true iff L3 is the result of concatenating L2 to L1
% my_append([1,2], [3,4], X).
% X = [1,2,3,4]
my_append([],X,X).
my_append([H|T], X, [H|T2]):-
    my_append(T, X, T2).

% my_append_el/3
% my_append_el(L1, X, L2) is true iff L2 is the result of appending element X to the end of L1
% my_append_el([1,2], 3, X).
% X = [1,2,3]
my_append_el([], X, [X]).
my_append_el([H|T], X, [H|T2]):-  
	my_append_el(T, X, T2).

% my_reverse/2
% my_reverse(L1, L2) is true iff L2 is the reverse of list L1
% my_reverse([1,2,3], X).
% X = [3,2,1]
my_reverse([],[]).
my_reverse([H|T], Res):-
    my_reverse(T, TailRev),
    my_append_el(TailRev, H, Res).

%-----------------Reverse (Tail Recursive)-----------------
% my_reverse_main/2
my_reverse_main(L, Res):-
    my_reverse_helper(L, [], Res).

% my_reverse_helper/3
my_reverse_helper([], Acc, Acc).
my_reverse_helper([H|T], Acc, Res):-
    my_reverse_helper(T, [H|Acc], Res).
%-----------------Reverse (Tail Recursive)-----------------
% remove_first/3
% remove_first(X, L1, L2) is true iff L2 is the list L1 with the first occurrence of element X removed
% remove_first(2, [1,2,3,2], X).
% X = [1,3,2]
remove_first(X,[X|T], T).
remove_first(X,[H|T], [H|T2]):-
    X \= H,
    remove_first(X,T,T2).

% remove_all/3
% remove_all(X, L1, L2) is true iff L2 is the list L1 with all occurrences of element X removed
% remove_all(2, [1,2,3,2,4,2], X).
% X = [1,3,4]
remove_all(_,[],[]):-!.
remove_all(X,[X|T], Res):-
    !,
    remove_all(X, T, Res).
remove_all(X,[H|T], [H|T2]):-
    X \= H,
    remove_all(X, T, T2).

% removeDuplicates/2
% removeDuplicates(L1, L2) is true iff L2 is the list L1 with all duplicate elements removed,
% preserving the first occurrence of each element
% removeDuplicates([1,2,1,3,2,4], X).
% X = [1,2,3,4]
removeDuplicates([],[]).
removeDuplicates([H|T], [H|T3]):-
    remove_all(H, T,  T2),
    removeDuplicates(T2, T3).

% zip/3
% zip(L1, L2, L3) is true if L3 is the result of zipping L1 and L2
% zip([1,2,3],[4,5,6],L).
% L = [[1, 4], [2, 5], [3, 6]].
% zip([1,2],[3,4,5],L).
% L = [[1, 3], [2, 4]].
zip([],_,[]):-!.
zip(_,[],[]):-!.
zip([H1|T1], [H2|T2], [[H1, H2]|T]):-
    zip(T1, T2, T).

% permut/2
% permut(L1, L2) is true iff L2 is a permutation of L1
% permut([1,2,3], X).
% X = [1,2,3] ;
% X = [2,1,3] ;
% X = [2,3,1] ;
% X = [1,3,2] ;
% X = [3,1,2] ;
% X = [3,2,1]
permut([],[]).
permut([H|T], Res):-
    permut(T, TailPermut),
    remove_first(H, Res, TailPermut).

% is_tree/1
% checking a valid binary tree strucutre
is_tree(nil).
is_tree(tree(_,L,R)):-
    is_tree(L),
    is_tree(R).

% countNodes/2
% countNodes(T, N) is true iff N is the total number of nodes in binary tree T
% countNodes(tree(1, tree(2, nil, nil), nil), X).
% X = 2
countNodes(nil, 0).
countNodes(tree(_, L, R), Res):-
    countNodes(L, Lcount), 
    countNodes(R, Rcount),
    Res is Lcount + Rcount + 1.

% countLeaves/2
% countLeaves(T, N) is true iff N is the number of leaf nodes in binary tree T
% countLeaves(
% tree(1,
% 	tree(2, 
% 		tree(4, nil, nil), tree(5, nil, nil)),
% 	tree(3, 
% 		tree(6, nil, nil), tree(7, nil, nil))), X).
% X = 4
countLeaves(nil, 0):-!.
countLeaves(tree(_, nil,nil), 1):-!.
countLeaves(tree(_, L, R), Res):-
    countLeaves(L, Lcount), 
    countLeaves(R, Rcount), 
    Res is Lcount + Rcount.

% symmetric/1
% symmetric(T) is true iff binary tree T is symmetric around its center
% symmetric(tree(1, tree(2, nil, tree(3, nil, nil)), tree(2, tree(3, nil, nil), nil))).
% true
symmetric(nil).
symmetric(tree(_, L, R)):-
    mirror(L,R).

% mirror/2
% mirror(T1, T2) is true iff binary tree T1 is the mirror image of binary tree T2
% mirror(tree(2, nil, tree(3, nil, nil)), tree(2, tree(3, nil, nil), nil)).
% true
mirror(nil,nil).
mirror(tree(X, L1, R1), tree(X, L2, R2)):-
    mirror(L1, R2),
    mirror(R1, L2).

% bst_insert/3
% bst_insert(X, T1, T2) is true iff T2 is the binary search tree resulting from
% inserting value X into binary search tree T1
% bst_insert(5, tree(3, nil, nil), X).
% X = tree(3, nil, tree(5, nil, nil))
bst_insert(X, nil, tree(X, nil,nil)).
bst_insert(X, tree(Root, L, R), tree(Root,L, Rnew)):-
    X > Root,
    bst_insert(X, R, Rnew).
bst_insert(X, tree(Root, L, R), tree(Root,Lnew, R)):-
    X < Root,
    bst_insert(X, L, Lnew).

% bst_construct/2
% bst_construct(L, T) is true iff T is the binary search tree constructed
% by successively inserting the elements of list L into an empty tree
% bst_construct([3,1,5], X).
% X = tree(3, tree(1, nil, nil), tree(5, nil, nil))
bst_construct(L, T):-
    bst_construct_helper(L, nil, T).

% bst_construct_helper/3
bst_construct_helper([], Acc, Acc).
bst_construct_helper([H|T], Acc, Res):-
    bst_insert(H, Acc, Inter),
    bst_construct_helper(T, Inter, Res).

%-----------------------
% Towers of Hanoi
%-----------------------
% move all pegs from A to B using auxiliary peg C.
% move(N,A,B,C)
% example usage
%?- move(3, left, center, right).
%Move top disk from left to center
%Move top disk from left to right
%Move top disk from center to right
%Move top disk from left to center
%Move top disk from right to left
%Move top disk from right to center
%Move top disk from left to center
%true ;
%false.
move(1, Source, Target, _):-
    write("move top disk from "), 
    write(Source), 
    write(" to "), 
    write(Target),
    nl.

move(N, Source, Target, Aux):-
    N > 1, 
    N1 is N-1, 
    move(N1, Source, Aux, Target), 
    move(1, Source, Target, Aux), 
    move(N1, Aux, Target, Source).