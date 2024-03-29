:- dynamic yes/1.
:- dynamic no/1.
/*yes and no are set to dynamic as they can change at run time.
This is due to options being added based on the response
provided by the user*/
ask(X):- getNextQuestion(X,L), processOptions(L).
/*ask(X) will be user to run the program. It calls the below functions*/

/******************************
 * getNextQuestion:
 * Purpose: runs the relatedQuestion(X,Y) function if the response is
 yes. If the response is no, then finds a random question to run. Uses
 the find all to get all possible questions and then gets chooses only 1
 in each function.
 * Parameters: Y = Question, L = List
 ******************************/
getNextQuestion(Y,L):-
    yes(Y), findall(X,relatedQuestion(X,Y),L); /*Get related Question*/
    findall(X,randomQuestion(Y,X),L). /*Get random question.*/

/*********************************
 * processOptions:
 * Purpose: Gets all values in the yesList and noList. Appends all found
   values to the responseList. By converting the list passed in to a
   set, this ensures each value is unique so it is not asked twice. The
   same principle is applied for the responseList. They are then
   subtracted from each other and a member of the subtracted List is
   found. This method then calls getResponse(Y) to ask for user input.
 *Parameters: L = List
********************************/
processOptions(L):-
    findall(X,yes(X),YesList), %find everything in yes list
    findall(X,no(X),NoList), % find everything in no list
    append(YesList,NoList, ResponseList),
    list_to_set(L,ListSet), %Ensure all elements are unique
    list_to_set(ResponseList,R), %Ensure all elements are unique.
    subtract(ListSet,R,ValidOption), %find differences
    member(Y,ValidOption), getResponse(Y). %ask for response of question Y

/*****************************
 * getResponse(Y):
 * Purpose: Takes in a question, and asks the user in prolog to
  enter a valid response (y/n/q). If neither of these is found, then the
  program assumes the response is no. The next question is then asked.
 * Parameters: Y = Question
 * ******************************/
getResponse(Y):-
    print(Y), nl, read(Response), %Print question and get response
    ((Response == y -> assert(yes(Y)); %if response yes, add to yesList
    Response == n -> assert(no(Y)); %if response no, add to noList
     ((Response \= n, Response \= y, Response \= q) -> print("Assuming that's a no"),nl, assert(no(Y))); %if response isn't yes/no/quit, then assume no and inform user
     Response == q -> print("exiting program..."),abort)), %if response if q, abort program.
    ask(Y). %ask next question
   /*ask(Y).*/

/*********************************
play[] = a list of question that are asked when the user responds yes to
a previous play question or selects no to a different category question
and play is the new question
**********************************/
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

/*********************************
eat[] = a list of question that are asked when the user responds yes to
a previous eat question or selects no to a different category question
and eat is the new question
**********************************/

eat(["Did you eat the cake I packed for you?",
     "Did you eat the toffee I packed for you?",
     "Did you eat any candy today?",
     "Did you eat the sandwich I packed for lunch?",
     "Did you eat any pizza today?",
     "Did you eat any cheerios today?",
     "Did you eat any veggies today?",
     "Did you eat any fries today?"]).

/*********************************
learn[] = a list of question that are asked when the user responds yes
to a previous learn question or selects no to a different category
question and learn is the new question
**********************************/

learn(["Did you learn math today?",
       "Did you learn english today?",
       "Did you read any books today?",
       "Did you learn science today?",
       "Did you get any homework?",
       "Did you learn humanities today?",
       "Did you use the computers today?"]).
/*********************************
sports[] = a list of question that are asked when the user responds yes
to a previous sports question or selects no to a different category
question and sports is the new question
**********************************/
sports(["Did you play any sports today?",
        "Did you play soccer today?",
        "Did you play cricket today?",
        "Did you run much today?",
        "Did you sprint much today?",
        "Did you play any football today"]).
/*********************************
friends[] = a list of question that are asked when the user responds yes
to a previous friends question or selects no to a different category
question and friends is the new question
**********************************/
friends(["Did you see your friends today?",
         "Was Billy at school today?",
         "Was Jimmy at school today?",
         "Did you play with your friends on the playground?"]).
/**********************************
 * relatedQuestion(X,Y):
 * Purpose: There are 5 related question functions, one for each list.
 * If the question passed in is a member of the associated list, then
 * this will ask the next question in the list.
 * *********************************/
relatedQuestion(X,Y):- play(L), member(X,L), member(Y,L). %get next question in play list
relatedQuestion(X,Y):- eat(L), member(X,L), member(Y,L). %get next question in eat list
relatedQuestion(X,Y):- learn(L), member(X,L), member(Y,L). %get next question in learn list
relatedQuestion(X,Y):- sports(L), member(X,L), member(Y,L). %get next question in sport list
relatedQuestion(X,Y):- friends(L), member(X,L), member(Y,L). %get next question in friends list

/***********************************
 * randomQuestion(X,Y):
 * Purpose: Checks which list the previous question was a  member of.
It then appends all other lists that the previous question is not apart
of and asks a question from this list.
****************************************/
randomQuestion(X,Y):-
    play(A),eat(B),learn(C),sports(D),friends(E),
    ((member(X,A)->append(B,C,BC),append(BC,D,BCD),append(BCD,E,BCDE),random_member(Y,BCDE));%Check if a member of play, then append other lists
    (member(X,B)->append(A,C,AC),append(AC,D,ACD),append(ACD,E,ACDE),random_member(Y,ACDE)); %Check if a member of eat, then append other lists
    (member(X,C)->append(A,B,AB),append(AB,D,ABD),append(ABD,E,ABDE),random_member(Y,ABDE));%Check if a member of learn, then append other lists
    (member(X,D)->append(A,B,AB),append(AB,C,ABC),append(ABC,E,ABCE),random_member(Y,ABCE));%Check if a member of sports, then append other lists
    (member(X,E)->append(A,B,AB),append(AB,C,ABC),append(ABC,D,ABCD),random_member(Y,ABCD))). %Check if a member of friends, then append other lists
yes(nothing). %Set yes list initially to have no elements
no(nothing). %Set no list initially to have no elements



