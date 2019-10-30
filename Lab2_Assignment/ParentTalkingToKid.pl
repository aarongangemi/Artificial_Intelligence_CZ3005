:- dynamic yes/1.
:- dynamic no/1.
ask(X):- getNextQuestion(X,L), processOptions(L).

getNextQuestion(Y,L):-
    yes(Y), findall(X,relatedQuestion(X,Y),L);
    findall(X,randomQuestion(Y,X),L).

processOptions(L):-
    findall(X,yes(X),YesList),
    findall(X,no(X),NoList),
    append(YesList,NoList, ResponseList),
    list_to_set(L,ListSet),
    list_to_set(ResponseList,R),
    subtract(ListSet,R,ValidOption),
    member(Y,ValidOption), getResponse(Y).

getResponse(Y):-
    print(Y), nl, read(Response),
    ((Response == y -> assert(yes(Y));
    Response == n -> assert(no(Y));
     Response == q -> abort)),
    ask(Y).
   /*ask(Y).*/
play(["Did you play with the slides?",
      "Did you play in the sandbox?",
      "Did you play with the toys?",
      "Did you play with the trains?",
      "Did you play with the cars?",
      "Did you use the playmat?",
      "Did you play with the bears?",
      "Did you play with the animals?",
      "Did you play on the swings?",
      "Did you use the soft_toys?",
      "Did you play with the alphabet?",
      "Did you play with the numbers?"]).

eat(["Did you eat the cake I packed for you?",
     "Did you eat the toffee I packed for you?",
     "Did you eat any candy today?",
     "Did you eat the sandwich I packed for lunch?",
     "Did you eat any pizza today?",
     "Did you eat any cheerios today?",
     "Did you eat any veggies today?",
     "Did you eat any fries today?"]).

learn(["Did you learn math today?",
       "Did you learn english today?",
       "Did you read any books today?",
       "Did you learn science today?",
       "Did you get any homework?",
       "Did you learn humanities today?",
       "Did you use the computers today?"]).

sports(["Did you play any sports today?",
        "Did you play soccer today?",
        "Did you play cricket today?",
        "Did you run much today?",
        "Did you sprint much today?",
        "Did you play any football today"]).

friends(["Did you see your friends today?",
         "Was Billy at school today?",
         "Was Jimmy at school today?",
         "Did you play with your friends on the playground?"]).

relatedQuestion(X,Y):- play(L), member(X,L), member(Y,L).
relatedQuestion(X,Y):- eat(L), member(X,L), member(Y,L).
relatedQuestion(X,Y):- learn(L), member(X,L), member(Y,L).
relatedQuestion(X,Y):- sports(L), member(X,L), member(Y,L).
relatedQuestion(X,Y):- friends(L), member(X,L), member(Y,L).
randomQuestion(X,Y):-
    play(A),eat(B),learn(C),sports(D),friends(E),
    ((member(X,A)->append(B,C,BC),append(BC,D,BCD),append(BCD,E,BCDE),random_member(Y,BCDE));
    (member(X,B)->append(A,C,AC),append(AC,D,ACD),append(ACD,E,ACDE),random_member(Y,ACDE));
    (member(X,C)->append(A,B,AB),append(AB,D,ABD),append(ABD,E,ABDE),random_member(Y,ABDE));
    (member(X,D)->append(A,B,AB),append(AB,C,ABC),append(ABC,E,ABCE),random_member(Y,ABCE));
    (member(X,E)->append(A,B,AB),append(AB,C,ABC),append(ABC,D,ABCD),random_member(Y,ABCD))).
yes(nothing).
no(nothing).



