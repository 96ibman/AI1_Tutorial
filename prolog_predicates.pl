%-----------------------
% Unary Natural Numbers
%-----------------------

% Definition
% nat/1
% nat(0) -> T
% nat(s(0)) -> T, nat(s(s(0))) -> T, ....
nat(0). % 0 is a natural number
nat(s(X)):-nat(X). % the successor of a natural number is a natrual number 

% Unary Addition
% add/3
% add(s(s(0)), s(0), X).
% X = s(s(s(0)))
add(X,0,X):-!.
add(0,X,X):-!.
add(s(X),Y,s(Z)):-add(X,Y,Z),!.
add(X,s(Y),s(Z)):-add(X,Y,Z),!.

% Unary Multiplication
% mult/3
% mult(s(s(s(s(0)))), s(s(0)), X). (4*2)
% X = s(s(s(s(s(s(s(s(0))))))))    (8)
mult(X,s(0),X):-!.
mult(s(0),X,X):-!.
mult(s(X), Y, Z):-mult(X,Y,W), add(W,Y,Z),!.
mult(X, s(Y), Z):-mult(X,Y,W), add(W,X,Z),!.

% Unary Exp
% uexp/3
% uexp(s(s(s(0))), s(s(0)), X).       (3^2)
% X = s(s(s(s(s(s(s(s(s(0)))))))))    (9)
uexp(_,0,s(0)):-!.
uexp(X,s(0),X):-!.
uexp(X,s(Y),Z):-uexp(X,Y,W), mult(W,X,Z),!.

%-----------------------
% Tail vs. Head Recursion
%-----------------------

% Factorial
% fact/2
% fact(5,X). -> X = 120
fact(0,1):-!.
fact(N,X):- Y is N-1, fact(Y, Yfact), X is N * Yfact, !. 

% Tail Recursive Factorial
% fact_t/2
fact_t(X,Y):-fact_helper(X,1,Y),!.
% fact_helper/3
fact_helper(0,Acc, Acc):-!.
fact_helper(X,Acc, Y):- X>0, Prev is X-1, Z is Acc * X, fact_helper(Prev, Z, Y), !. 


% Fibonacci
% fib/2
% fib(10,X) -> 55
fib(0,0):-!.
fib(1,1):-!.
fib(X,Y):-
    X>1,
    X1 is X-1,
    X2 is X-2,
    fib(X1,X1fib),
    fib(X2, X2fib),
    Y is X1fib + X2fib,
    !.

% Fibonacci Tail Recursive
% fib_t/2
fib_t(X,Y):-fib_helper(X,0,1,Y),!.
% fib_helper/3
fib_helper(0,Acc,_,Acc):-!.
fib_helper(X,Acc1,Acc2,Y):-
    X>0,
    X1 is X - 1,
    Sum is Acc1+Acc2,
    fib_helper(X1, Acc2, Sum, Y),
    !.
 
%-----------------------
% Lists
%-----------------------
% is_list/1
is_list([]).
is_list([_|T]):-is_list(T).

% is_member/2
is_member(X,[X|_]).
is_member(X,[_|T]):-is_member(X,T).

% my_length/2
my_length([],0).
my_length([_|T],L):-
    my_length(T,TailLength),
    L is TailLength + 1.

% sumlist/2
% sumlist([1,2,3],X).
% X = 6
sumlist([],0):-!.
sumlist([X],X):-!.
sumlist([H|T],Res):-
    sumlist(T,TailSum),
    Res is TailSum + H.

% sum_first_x/3
% sum_first_x([1,2,3,4,5],4,X).
% X = 10
sum_first_x(_,0,0):-!.
sum_first_x([H|T],X,Sum):-
    X1 is X - 1,
    sum_first_x(T,X1,TSum),
    Sum is TSum + H.

% sum_last_x/3
% sum_last_x([1,2,3,4,5],2,X)
% X = 9
sum_last_x(_,0,0):-!.
sum_last_x(List, X, Sum):-
    sumlist(List,SumAll),
    my_length(List,Length),
    F is Length - X,
    sum_first_x(List, F, ToSubtract),
    Sum is SumAll - ToSubtract.
    

% get_element/3
get_element(0,[H|_],H).
get_element(X,[_|T],E):-
    X1 is X-1,
    get_element(X1,T,E).

% is_last/2
is_last(X,[X]).
is_last(X,[_|T]):-
    is_last(X,T).


% Maximum Element of a List (Tail Recursion)
% a helper predicate 
% maxListAcc/3
maxListAcc([], Acc, Acc).
maxListAcc([H|T], Acc, Res):-
    H>Acc,
    maxListAcc(T,H,Res).   
maxListAcc([H|T], Acc, Res):-
    H=<Acc,
    maxListAcc(T,Acc,Res).  

% maxList/2
maxList([], _) :- fail.
maxList([H|T],Y):-maxListAcc([H|T], H, Y). 

% Similarly, Minimum Element of a List
minListAcc([], Acc, Acc).
minListAcc([H|T], Acc, Res):-
    H=<Acc,
    minListAcc(T,H,Res).   
minListAcc([H|T], Acc, Res):-
    H>Acc,
    minListAcc(T,Acc,Res).  

minList([], _) :- fail.
minList([H|T],Y):-minListAcc([H|T], H, Y).


% my_append/3
my_append([],X,X).
my_append([H|T], Y, [H|T1]):-
    my_append(T,Y,T1).

% remove_one/3
remove_one(X,[X|T],T).
remove_one(X,[H|T],[H|T2]):-
    H \= X,
    remove_one(X,T,T2).

% remove_all/3
remove_all(_,[],[]).
remove_all(X,[X|T],Res):-
    remove_all(X,T,Res).
remove_all(X,[H|T],[H|T1]):-
    H \= X,
    remove_all(X,T,T1).

% remove_duplicates/2
remove_duplicates([],[]).
remove_duplicates([H|T],[H|T1]):-
    remove_all(H,T,T2),
    remove_duplicates(T2, T1).

% is_set/1
is_set(X):-remove_duplicates(X,X).

% my_reverse/2
my_reverse([],[]).
my_reverse([H|T],Res):-
    my_reverse(T,TailReversed),
    my_append(TailReversed, [H], Res).

% zip/3
% zip([1,2],[3,4,5,6,7],X).
% X = [(1,3), (2,4)]
zip(_,[],[]).
zip([],_,[]).
zip([H1|T1], [H2|T2], [(H1,H2)|T3]):-
    zip(T1,T2,T3).

% permutations/2
% permutations([1,2],X).
% X = [1, 2]
% X = [2, 1]
permutations([],[]).
permutations([H|T],Res):-
    permutations(T,Tperm),
    remove_one(H,Res,Tperm).

% my_flatten/2
% my_flatten([[1,2],3,[4,[5,[6,7,[8]]]]],X).
% X = [1, 2, 3, 4, 5, 6, 7, 8]
my_flatten([],[]).
my_flatten([H|T],Res):- 
	is_list(H), 
	my_flatten(H,Hflat), 
	my_flatten(T,Tflat), 
	my_append(Hflat, Tflat, Res). 

my_flatten([H|T],[H|T1]):- 
	\+ is_list(H), 
	my_flatten(T,T1).

% sorted/1
sorted([]).
sorted([_]).
sorted([H1,H2|T]):- 
    H1=<H2, 
    sorted([H2|T]).

% my_sort/2
my_sort([],[]).
my_sort(X,Y):-
    permutations(X,Y),
    sorted(Y).


% maplist/3
% maplist(square,[1,2,3,4],X).
% X = [1, 4, 9, 16]
square(X,Y):- Y is X*X.
maplist(_,[],[]).
maplist(Pred,[H|T],[H1|T1]):-
    call(Pred,H,H1),
    maplist(Pred,T,T1).


% remove_if/3
% remove_if(even,[1,2,3,4,5,6],X).
% X = [1, 3, 5]
% remove_if(odd,[1,2,3,4,5,6],X).
% X = [2, 4, 6]

% even/1
even(X):- 0 is X mod 2,!.

% odd/1
odd(X):- \+ even(X).

remove_if(_,[],[]).
remove_if(Pred, [H|T],Res):-
    call(Pred,H),
    remove_if(Pred, T, Res).
remove_if(Pred, [H|T],[H|T1]):-
    \+ call(Pred,H),
    remove_if(Pred, T, T1).

%IF-THEN-ELSE%
%remove_if(_, [], []).
%remove_if(Pred, [H|T], Res) :-
%    ( call(Pred, H) ->
%        remove_if(Pred, T, Res)
%    ;
%        Res = [H|T1],
%        remove_if(Pred, T, T1)
%    ).


% my_subtract/3
% my_subtract([1,2,3,4,4,2], [1,3],X).
% X = [2, 4, 4, 2]
my_subtract([],_,[]).
my_subtract([H|T], List, Res):-
    is_member(H,List),
    my_subtract(T,List,Res).

my_subtract([H|T], List, [H|T1]):-
    \+ is_member(H,List),
    my_subtract(T,List,T1).

% hide/3
% hide([1,2,3,4], [2,4],X).
% X = [1, hidden, 3, hidden]
hide([],_,[]):-!.
hide(X,[],X):-!.
hide([H|T],Elements,[hidden|T1]):-
    is_member(H,Elements),
    hide(T,Elements, T1).

hide([H|T],Elements,[H|T1]):-
    \+ is_member(H,Elements),
    hide(T,Elements, T1).
    

%-----------------------
% Binary (Search) Trees
%-----------------------

% tree(nil) % empty tree
% tree(1,nil,nil) % one node
% tree(1,tree(2,nil,nil),tree(3,nil,nil)) % one node with two children

% is_tree/1
is_tree(nil).
is_tree(tree(_,L,R)):-
    is_tree(L),
    is_tree(R).

% tree/1
tree(X):-is_tree(X).

% tree/3
tree(N, L, R):-is_tree(tree(N,L,R)).

% Insert a node to a binary serarch tree (BST)
% bst_ins/3
bst_ins(N,nil, tree(N,nil,nil)).
bst_ins(N,tree(Root, L, R), tree(Root, Res1, R)):- 
    N<Root,
    bst_ins(N, L, Res1).

bst_ins(N,tree(Root, L, R), tree(Root, L, Res1)):- 
    N>Root,
    bst_ins(N, R, Res1).

bst_ins(N, tree(N,L,R), tree(N,L,R)) :- !.  % ignore duplicates

% Construct a BST
% construct/2
bst_cons([],nil).
bst_cons([H|T], Res):-
    bst_cons(T,T1),
    bst_ins(H,T1,Res).

% Tail Recursive Construct of a BST 

% bstConst/2
bstConst([],nil).
bstConst(X,Res):- bstConstAcc(X,nil,Res).

% bstConstAcc/3
bstConstAcc([],Acc,Acc).
bstConstAcc([H|T],Acc,Res):-
    bst_ins(H,Acc,Acc1),
    bstConstAcc(T, Acc1, Res).


% Count nodes in a BT
% bt_nodes_count/2
bt_nodes_count(nil,0):-!.
bt_nodes_count(tree(_, L, R), Res):-
    bt_nodes_count(L,LeftNodes),
    bt_nodes_count(R,RightNodes),
    Res is LeftNodes + RightNodes + 1.

% Count leaves in a BT
bt_leaves_count(nil,0):-!.
bt_leaves_count(tree(_,nil,nil),1):-!.
bt_leaves_count(tree(_, L, R), Res):-
    bt_leaves_count(L,LeftLeaves),
    bt_leaves_count(R,RightLeaves),
    Res is LeftLeaves + RightLeaves.

% Check if a BT is symmetric
%1. A helper predicate to check if one tree is the mirror of the other
% mirror/2
mirror(nil,nil):-!.
mirror(tree(N,L1,R1), tree(N,L2,R2)):-
    mirror(L1,R2),
    mirror(R1,L2).

%2. symmetric/1
symmetric(nil):-!.
symmetric(tree(_,L,R)):-
    mirror(L,R).


% Depth First Traversal of a BT (in-order)
bt_dfs_trav(nil):-!.
bt_dfs_trav(tree(N,L,R)):-
    bt_dfs_trav(L),
    write(N), write(" "),
    bt_dfs_trav(R).


% Breadth First Traversal of a BT
% helper enqueue predicate
% enqueue/3 add element to the queue and returns the new queue
% enqueue(x, [a,b], Q).
% Q = [a,b,x].
enqueue(X,[],[X]):-!.
enqueue(X,[H|T],[H|T1]):-
   enqueue(X,T,T1),!. 


% bt_bfs_trav/1
% starting point, push the whole tree in the queue
bt_bfs_trav(nil):-!.
bt_bfs_trav(Tree):-
    bfs_loop([Tree]).

% bfs_loop/1
% we stop when the queue is empty
bfs_loop([]):-!.

% we process the head
% we add its children to the queue
% we recurse on the new queue
bfs_loop([tree(N,L,R)|Rest]):-
    write(N), write(" "),
    add_children(L,R,Rest,NewQ),
    bfs_loop(NewQ).


% Add children predicate
% add_children/4

% Case 1: both children are nil
% Return the Queue as it is
add_children(nil,nil,Q,Q):-!.

% Case 2: only left child exists
% Add that to the queue
% add_children(tree(2,nil,nil), nil, [tree(1,nil,nil)], Q).
% Q = [tree(1,nil,nil), tree(2,nil,nil)]
add_children(L,nil,CurrentQ, NewQ):-
    enqueue(L,CurrentQ, NewQ),!.

% Case 3: only right child exists
% Add that the queue
% add_children(nil, tree(3,nil,nil), [tree(2,nil,nil)], Q).
% Q = [tree(2,nil,nil), tree(3,nil,nil)]
add_children(nil,R,CurrentQ, NewQ):-
    enqueue(R,CurrentQ, NewQ),!.

% Case 4: both children exist
% Add first the left -> update queue
% Add the right -> final queue
% add_children(tree(2,nil,nil), tree(3,nil,nil), [tree(1,nil,nil)], Q).
% Q = [tree(1,nil,nil), tree(2,nil,nil), tree(3,nil,nil)]
add_children(L,R,CurrentQ,NewQ):-
    enqueue(L, CurrentQ, LAddedQ),
    enqueue(R,LAddedQ,NewQ),
    !.

%-----------------------
% Encode Predicate
%-----------------------
% encode([a,a,a,a,b,c,c,a,a,d,e,e,e,e], X).
% X = [[4, a], [1, b], [2, c], [2, a], [1, d], [4, e]]

% count([1,1,1,1,1], X).
% X = [5, 1]
count([H|T],[L,H]):-
    my_length([H|T], L). 

% pack([a,a,a,a,b,c,c,a,a,d,e,e,e,e], X).
% X = [[a,a,a,a],[b],[c,c],[a,a],[d],[e,e,e,e]]
pack([],[]):-!.
pack([X],[[X]]):-!.
pack([X,Y|T],[[X|Xs]|TPacked]):-
    X==Y,
    pack([Y|T],[Xs|TPacked]).
pack([X,Y|T],[[X]|TPacked]):-
    X\==Y,
    pack([Y|T],TPacked).

% encode/2
encode([], []) :- !.
encode(List, Encoded) :-
    pack(List, Packed),
    encode_packed(Packed, Encoded).

% encode_packed/2
encode_packed([], []):-!.
encode_packed([Group | RestGroups], [EncodedGroup | RestEncoded]) :-
    count(Group, EncodedGroup),
    encode_packed(RestGroups, RestEncoded).


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

move(1, A, B,_):-
    write("Move top disk from "),
    write(A), write(" to "), write(B), nl.

move(N,A,B,C):-
    N>1,
    N1 is N-1,
    move(N1, A,C,B),
    move(1, A,B,_),
    move(N1, C, B, A).



 





























    


