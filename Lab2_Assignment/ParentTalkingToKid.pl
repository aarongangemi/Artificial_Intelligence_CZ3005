:- dynamic yes/1.
:- dynamic no/1.
ask(0):- print("Today at school, did you use"),nl, processOptions(['slides']).
ask(X):- getNextQuestion(X,L), processOptions(L).

getNextQuestion(Y,L):-
    yes(Y),print("Did you do"), findnsols(50,X,relatedQuestion(X,Y),L);
    print("Did you use"), findnsols(50,X,randomQuestion(X),L).

processOptions(L):-
    findnsols(50,X,yes(X),YesList),
    findnsols(50,X,no(X),NoList),
    append(YesList,NoList, ResponseList),
    list_to_set(L,ListSet),
    list_to_set(ResponseList,R),
    subtract(ListSet,R,ValidOption),
    member(Y,ValidOption),
    print(Y), nl, read(Response),
    ((Response == y -> assert(yes(Y));
    Response == n -> assert(no(Y)))),
    ask(Y).
   /*ask(Y).*/
play([slides,sandbox,toys,trains,cars,playmat,bears,animals,swings,soft_toys,alphabet,numbers]).

eat([cake,toffee,candy,sandwich,pizza,cheerios,veggies,fries]).

learn([math,english,books,science,homework,humanities, computers]).

sports([sports,soccer,cricket,run,sprint,football]).

friends([friends,billy,jimmy,playground]).

relatedQuestion(X,Y):- play(L), member(X,L), member(Y,L).
relatedQuestion(X,Y):- eat(L), member(X,L), member(Y,L).
relatedQuestion(X,Y):- learn(L), member(X,L), member(Y,L).
relatedQuestion(X,Y):- sports(L), member(X,L), member(Y,L).
relatedQuestion(X,Y):- friends(L), member(X,L), member(Y,L).

randomQuestion(Y):-
    play(A),eat(B),learn(C),sports(D),friends(E),
    append(A,B,AB),append(AB,C,ABC),append(ABC,D,ABCD),
    append(ABCD,E,ABCDE),random_member(Y,ABCDE).
yes(nothing).
no(nothing).
