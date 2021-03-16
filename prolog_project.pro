
contained(X,Y,[Xr,Yr,W,H]) :- X>Xr, Y>Yr, Xr+W>=X, Yr+H>=Y.

make_rect([X,W,H],R1) :- Y is 10-H, R1 = [[X,Y,W,H]].

get_rects1(O,R) :- O = [O1|O2], length(O,X), X>0, make_rect(O1,R1), get_rects1(O2,R2), append(R1, R2, R3), R = R3.
get_rects1([],R) :- R = [].

get_rects(O,R,L) :- get_rects1(O,R1), person_rect(P,R1,L), append(P, R1, R2), L1 is L-1, append([[0,L1,1,1]], R2, R3), 
		    append([[11,L1,1,1]], R3, R4), R = R4.

inbounds(X,Y) :- X>0, Y>0, 12>X, 11>Y.
check_safe([X,Y,_],[R1|R2]) :- inbounds(X,Y),\+contained(X,Y,R1),check_safe([X,Y,_],R2).
check_safe([_,_,_],[]) :- true.

person_rect([[X,0,2,6]],R,L,X1) :- (check_safe([X1, 7, _],R), X2 is X1+1, check_safe([X2, 7, _],R), X3 is X1+2,                            					   check_safe([X3, 7, _],R), X4 is X1+3, check_safe([X4, 7, _],R), X is X1);
				   (X2 is X1+1, 13>X2, person_rect([[X,0,2,6]],R,L,X2)).

person_rect([[X,0,2,6]],R,L) :- person_rect([[X,0,2,6]],R,L,2).
person_rect([[X,0,2,6]],R,L) :- L>6, person_rect([[X,0,2,6]],R,L,1).

next_mirror(X,Y,[[_,L,1,1]|_],0,M,M1)  :- L1 is L+1, length(M,S), 9>S, M1 = M, X = 11, Y = L1.
next_mirror(X,Y,[[_,L,1,1]|_],1,M,M1)  :- L1 is L+1, append([[X,Y,/]], M, M2), length(M2,S), 9>S, M1 = M2, X = 11, Y = L1.
next_mirror(X,Y,[[_,L,1,1]|_],-1,M,M1) :- L1 is L+1, append([[X,Y,\]], M, M2), length(M2,S), 9>S, M1 = M2, X = 11, Y = L1.

next_mirror(X,Y,R,0,M,M1) :- X1 is X+1, Y1 is Y, check_safe([X1,Y1,_],R), next_mirror(X1,Y1,R,0,M,M1).
next_mirror(X,Y,R,0,M,M1) :- X1 is X, Y1 is Y+1, check_safe([X1,Y1,_],R), append([[X,Y,/]], M, M2), next_mirror(X1,Y1,R,1,M2,M1).
next_mirror(X,Y,R,0,M,M1) :- X1 is X, Y1 is Y-1, check_safe([X1,Y1,_],R), append([[X,Y,\]], M, M2), next_mirror(X1,Y1,R,-1,M2,M1).

next_mirror(X,Y,R,1,M,M1)  :- X1 is X, Y1 is Y+1, check_safe([X1,Y1,_],R), next_mirror(X1,Y1,R,1,M,M1).
next_mirror(X,Y,R,1,M,M1)  :- X1 is X+1, Y1 is Y, check_safe([X1,Y1,_],R), append([[X,Y,/]], M, M2), next_mirror(X1,Y1,R,0,M2,M1).
%next_mirror(X,Y,R,1,M,M1) :- X1 is X-1, Y1 is Y, check_safe([X1,Y1,_],R), append([[X,Y,\]], M, M2), next_mirror(X1,Y1,R,-2,M2,M1).

next_mirror(X,Y,R,-1,M,M1)  :- X1 is X, Y1 is Y-1, check_safe([X1,Y1,_],R), next_mirror(X1,Y1,R,-1,M,M1).
%next_mirror(X,Y,R,-1,M,M1) :- X1 is X-1, Y1 is Y, check_safe([X1,Y1,_],R), append([[X,Y,/]], M, M2), next_mirror(X1,Y1,R,-2,M2,M1).
next_mirror(X,Y,R,-1,M,M1)  :- X1 is X+1, Y1 is Y, check_safe([X1,Y1,_],R), append([[X,Y,\]], M, M2), next_mirror(X1,Y1,R,0,M2,M1).


place_mirrors(L,O,M):- place_mirrors(L, O, [], M1), M = M1.
place_mirrors(L, O, M, M1) :- get_rects(O, R, L), next_mirror(1,L,R,0,M,M1).
