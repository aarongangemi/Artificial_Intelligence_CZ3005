:- dynamic yes/1.
:- dynamic no/1.
ask(0):- nl, processOptions(['Did you play with the slides']).
ask(X):- getNextQuestion(X,L), processOptions(L).

getNextQuestion(Y,L):-
    yes(Y), findall(X,relatedQuestion(X,Y),L);
    findall(X,randomQuestion(X),L).

processOptions(L):-
    findall(X,yes(X),YesList),
    findall(X,no(X),NoList),
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
        "Did you play soccer todat?",
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
randomQuestion(Y):-
    play(A),eat(B),learn(C),sports(D),friends(E),
    append(A,B,AB),append(AB,C,ABC),append(ABC,D,ABCD),
    append(ABCD,E,ABCDE),random_member(Y,ABCDE).
yes(nothing).
no(nothing).



