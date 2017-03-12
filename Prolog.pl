%Question one
parent(queenmother,elisabeth).  parent(elisabeth,charles).
parent(elisabeth,andrew).       parent(elisabeth,anne).
parent(elisabeth,edward).       parent(diana,william).
parent(diana,harry).            parent(sarah,beatrice).
parent(anne,peter).             parent(anne,zara).
parent(george,elisabeth).       parent(philip,charles).
parent(philip,andrew).          parent(philip,edward).
parent(charles,william).        parent(charles,harry).
parent(andrew,beatrice).        parent(andrew,eugene).
parent(mark,peter).             parent(mark,zara).
parent(william,georgejun).      parent(kate,georgejun).
parent(william,charlotte).      parent(kate,charlotte).
parent(philip,anne).
  
the_royal_females(queenmother).
the_royal_females(elisabeth).
the_royal_females(diana).
the_royal_females(anne).
the_royal_females(sarah).
the_royal_females(beatrice).
the_royal_females(charlotte).
the_royal_females(zara).
the_royal_females(kate).
  
the_royal_males(andrew).
the_royal_males(edward).
the_royal_males(harry).
the_royal_males(peter).
the_royal_males(george).
the_royal_males(philip).
the_royal_males(charles).
the_royal_males(william).
the_royal_males(mark).
the_royal_males(georgejun).
the_royal_males(phillip).
the_royal_males(eugene).
 
the_royal_family(queenmother).
the_royal_family(elisabeth).
the_royal_family(diana).
the_royal_family(anne).
the_royal_family(sarah).
the_royal_family(beatrice).
the_royal_family(charlotte).
the_royal_family(zara).
the_royal_family(kate).
the_royal_family(andrew).
the_royal_family(edward).
the_royal_family(harry).
the_royal_family(peter).
the_royal_family(george).
the_royal_family(philip).
the_royal_family(charles).
the_royal_family(william).
the_royal_family(mark).
the_royal_family(georgejun).
the_royal_family(phillip).
the_royal_family(eugene).
 
%parents are ancestors of their child
%parents of parents is still the accestor
%of the second persons child. 
ancestor(X,Y):- parent(X,Y).
ancestor(X,Y):- parent(X,Z),ancestor(Z,Y).
%Y = charlotte
%X= william;
%X= kate;
%X= queenmother;
%X= elisabeth;
%X= diana;
%X= george;
%X= philip;
%X= charles;

common_ancestor(X,Y,Z):- ancestor(X,Y),ancestor(X,Z).
%Y = anne 
%Z = edward;
%x = elisabeth;
%x = philip;
%x = queenmother;
%x = george;

%Only a sibling if they have the same parents
sibling(X,Y):- parent(Z,X),parent(Z,Y),X\=Y.

%person is a brother if the person is a male and has a sibling.
brother(X,Y):- the_royal_males(X),sibling(X,Y).

%Grandfather if male and child is also a parent.
grandfather(X,Y):- the_royal_males(X), parent(X,Z), parent(Z,Y).

%Y is has a sibling who is also a grandfather.
grandbro(Y):- grandfather(X,_),sibling(X,Y).
%grandbro(Y).
%Y = andrew ;
%Y = anne ;
%Y = edward ;
%Y = andrew ;
%Y = edward ;
%Y = anne ;
%Y = andrew ;
%Y = anne ;
%Y = edward ;
%Y = andrew ;
%Y = edward ;
%Y = anne ;

%question Two
%my length function.
mylen([],0).
mylen([_|T],N) :-  
	mylen(T,X),  N  is  X+1.

%my election function removed an selected
%element from a list and produces a new list from it.
mysel(E,[E|T],T).
mysel(E,[H|T],[H|T2]):-
	mysel(E,T,T2).

%my nth0 function select the nth elements of 
%a list that starts at 0.	
mynth0(0, [H | _], H).
mynth0(X, [_ | T], Z) :-
  X1 is X-1, 
  mynth0(X1, T, Z).

%removed and element E at position N and produces a new
%list without the selceted element.  
nth_elt(N,L,E,R):-
	mynth0(N,L,E),
	mylen(L,Q),
	N>0,
	N =< Q,
	mysel(E,L,R).

%nth_elt(2,[1,2,3,4,5],3,R).
%R = [1, 2, 4, 5] ;
%false.

pivot(_,[],[],[]).
pivot(H,[X|T],[X|L],Z):-X>=H,pivot(H,T,L,Z).
pivot(H,[X|T],L,[X|Z]):-X<H,pivot(H,T,L,Z).

qsort(L,S):-mysort(L,[],S).
mysort([],A,A).
mysort([H|T],A,S):-
	pivot(H,T,L1,L2),
	mysort(L1,A,S1),mysort(L2,[H|S1],S).
	
%gives information on which element is 
%in K index of list L.	
kth_sorted_elt(K,L,R):-
	qsort(L,X),
	mynth0(K,X,R).
	
%kth_sorted_elt(3,[7,6,3,2,1,4,5],X).
%X = 4 ;	
	
%Gives the median of list L by dividing the length
% by 2 by retrieveing the middle elements index and -1 so it 
% finds the lower bound if there are two middle values
% in an even length list. Using Round to round to the nearest
%integer if it's a float result.

median(L,E):-
    mylen(L,X),
    K is round(X/2 - 1), 
	kth_sorted_elt(K,L,E). 
	
%median([1,2,3,4,5,6],X).
%X = 3 ;

%median([1,2,3,4,5,6,7],X).
%X = 4 ;

%median([4,6,1,5,3,7,2],X).
%X = 4 ;
	
%Question 3	
% takes aways elements of two list of 
% the same index and squares them. Uses 
%reccursion, but not it's not tail reccursive.

euclidsqr([], [], 0).
euclidsqr([XH|X], [YH|Y], ED1) :-
	euclidsqr(X, Y, ED),
	ED1 is ED + (XH-YH)*(XH-YH).
%euclidsqr([5,3,7],[4,3,8],ED).
%ED = 2.

%Does the same the same things as above, but 
%it's tail recursive and uses and acculamator.
%on to the new accmator.

euclidsqr_acc([],[], Z, ED):-
	ED is Z.
euclidsqr_acc([XH|X], [YH|Y], OldA, ED) :-
	A is OldA + (XH-YH)*(XH-YH),
	euclidsqr_acc(X, Y, A, ED).
	
%euclidsqr_acc([5,3,7],[4,3,8],0,ED).
%ED = 2.	

%Question 4
%removes element E from the list L and remainder is given 
%as list R.
member_rem(E,L,R):-
	mysel(E,L,R).
	
%member_rem(2,[1,2,3,4,5],R).
%R = [1, 3, 4, 5] 	