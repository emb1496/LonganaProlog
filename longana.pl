generateNums(Max, []) :- Max < 0.
generateNums(Max, Nums) :- NewMax is Max-1,
    generateNums(NewMax, NewNums),
    append(NewNums, [Max], Nums).

generateRowTile(_, Values, []) :- Values = [].
generateRowTile(Number, Values, Tiles) :- [First | Rest] = Values,
    generateRowTile(Number, Rest, NewTiles),
    Domino = [Number, First],
    append(NewTiles, [Domino], Tiles).

generateTiles(Pips, []) :- Pips = [].
generateTiles(Pips, Tiles) :- [First | Rest] = Pips,
    generateRowTile(First, Pips, Tiles1),
    generateTiles(Rest, NewTiles),
    append(Tiles1, NewTiles, Tiles).

givePlayerTiles(Stock, Counter, Stock, _) :- Counter < 1; Stock = [].
givePlayerTiles(Stock, Counter, NewStock, Player) :- [First | Rest] = Stock,
    Count1 is Counter - 1,
    givePlayerTiles(Rest, Count1, Stock1, Player1),
    append(Player1, [First], Player),
    NewStock = Stock1.

generateEngine(RoundNo, Center) :- RoundNo >= 1, Side is mod(RoundNo, 7), Side =:= 0,
    Center = [Side, Side].
generateEngine(RoundNo, Center) :- RoundNo >= 1, Side is 7 - mod(RoundNo, 7),
    Center = [Side, Side].

validateScore(NewScore, Score) :- not(number(NewScore)),
    getTournScoreFromUser(Score).

validateScore(NewScore, Score) :- NewScore < 1,
    getTournScoreFromUser(Score).

validateScore(NewScore, Score) :- number(NewScore), NewScore > 0, Score = NewScore.

setFirstPlayer(Human, [], [], [], _, _, _, _) :- Human = [].
setFirstPlayer([], Computer, [], [], _, _, _, _) :- Computer = [].
setFirstPlayer([], [], Center, [], _, _, _, _) :- Center = [].
setFirstPlayer(Human, Computer, Center, Stock, PlayNext, NewHuman1, NewComputer1, NewStock) :- member(Center, Human),
    delete(Human, Center, NewHuman1),
    write("Human has the engine, he will place it and the computer will be next to play..."), nl,
    PlayNext = computer,
    NewComputer1 = Computer,
    NewStock = Stock.
setFirstPlayer(Human, Computer, Center, Stock, PlayNext, NewHuman1, NewComputer1, NewStock) :- member(Center, Computer),
    delete(Computer, Center, NewComputer1),
    write("Computer has the engine, he will place it and the human will be next to play..."), nl,
    PlayNext = human,
    NewHuman1 = Human,
    NewStock = Stock.
setFirstPlayer(Human, Computer, Center, Stock, PlayNext, NewHuman1, NewComputer1, NewStock) :- member(Center, Stock),
    [First | Rest] = Stock,
    write("Human has drawn "),
    write(First), nl,
    append(Human, [First], NewHuman),
    [Head | Tail] = Rest,
    write("Computer has drawn "),
    write(Head), nl,
    append(Computer, [Head], NewComputer),
    setFirstPlayer(NewHuman, NewComputer, Center, Tail, PlayNext, NewHuman1, NewComputer1, NewStock).

getTournScoreFromUser(Score) :- not(number(Score)),
    write("Please enter tournament score: "),
    read(NewScore),
    validateScore(NewScore, Score).

getTournScoreFromState(State, _) :- State = [].
getTournScoreFromState(State, Score) :- [Score | _] = State.

getRoundNoFromState(State, _) :- State = [].
getRoundNoFromState(State, RN) :- [_ | Rest] = State,
    [RN | _] = Rest.

getHumanFromState(State, _) :- State = [].
getHumanFromState(State, Human) :- [_ | Rest1] = State,
    [_ | Rest2] = Rest1,
    [Human | _] = Rest2.

getHumanScoreFromState(State, _) :- State = [].
getHumanScoreFromState(State, HS) :- [_ | Rest1] = State,
    [_ | Rest2] = Rest1,
    [_ | Rest3] = Rest2,
    [HS | _] = Rest3.

getComputerFromState(State, _) :- State = [].
getComputerFromState(State, Computer) :- [_ | Rest1] = State,
    [_ | Rest2] = Rest1,
    [_ | Rest3] = Rest2,
    [_ | Rest4] = Rest3,
    [Computer | _] = Rest4.

getComputerScoreFromState(State, _) :- State = [].
getComputerScoreFromState(State, CS) :- [_ | Rest1] = State,
    [_ | Rest2] = Rest1,
    [_ | Rest3] = Rest2,
    [_ | Rest4] = Rest3,
    [_ | Rest5] = Rest4,
    [CS | _] = Rest5.

getBoardFromState(State, _) :- State = [].
getBoardFromState(State, Board) :- [_ | Rest1] = State,
    [_ | Rest2] = Rest1,
    [_ | Rest3] = Rest2,
    [_ | Rest4] = Rest3,
    [_ | Rest5] = Rest4,
    [_ | Rest6] = Rest5,
    [Board | _] = Rest6.

getStockFromState(State, _) :- State = [].
getStockFromState(State, Stock) :- [_ | Rest1] = State,
    [_ | Rest2] = Rest1,
    [_ | Rest3] = Rest2,
    [_ | Rest4] = Rest3,
    [_ | Rest5] = Rest4,
    [_ | Rest6] = Rest5,
    [_ | Rest7] = Rest6,
    [Stock | _] = Rest7.

getPlayNextFromState(State, _) :- State = [].
getPlayNextFromState(State, PlayNext) :- [_ | Rest1] = State,
    [_ | Rest2] = Rest1,
    [_ | Rest3] = Rest2,
    [_ | Rest4] = Rest3,
    [_ | Rest5] = Rest4,
    [_ | Rest6] = Rest5,
    [_ | Rest7] = Rest6,
    [_ | Rest8] = Rest7,
    [PlayNext | _] = Rest8.

getLastPassedFromState(State, _) :- State = [].
getLastPassedFromState(State, LastPassed) :- [_ | Rest1] = State,
    [_ | Rest2] = Rest1,
    [_ | Rest3] = Rest2,
    [_ | Rest4] = Rest3,
    [_ | Rest5] = Rest4,
    [_ | Rest6] = Rest5,
    [_ | Rest7] = Rest6,
    [_ | Rest8] = Rest7,
    [_ | Rest9] = Rest8,
    [LastPassed | _] = Rest9.

getPassCountFromState(State, PassCount) :- [_ | Rest1] = State,
    [_ | Rest2] = Rest1,
    [_ | Rest3] = Rest2,
    [_ | Rest4] = Rest3,
    [_ | Rest5] = Rest4,
    [_ | Rest6] = Rest5,
    [_ | Rest7] = Rest6,
    [_ | Rest8] = Rest7,
    [_ | Rest9] = Rest8,
    [_ | Rest10] = Rest9,
    [PassCount | _] = Rest10.

printFirstLineToScreen(Hand) :- [] = Hand.
printFirstLineToScreen(Hand) :- [[L | [R|_]] | Rest] = Hand, L =:= R,
    write("  "),
    write(L),
    write("  "),
    printFirstLineToScreen(Rest).
printFirstLineToScreen(Hand) :- [[L | [R|_]] | Rest] = Hand, L\==R,
    write("     "),
    printFirstLineToScreen(Rest).

printSecondLineToScreen(Hand) :- [] = Hand.
printSecondLineToScreen(Hand) :- [[L | [R|_]] | Rest] = Hand, L\==R,
    write(L),
    write(" - "),
    write(R),
    printSecondLineToScreen(Rest).
printSecondLineToScreen(Hand) :- [[L | [R|_]] | Rest] = Hand, L =:= R,
    write("  |  "),
    printSecondLineToScreen(Rest).

printBoardToScreen(Hand) :- Hand = [].
printBoardToScreen(Hand) :- [_ | _] = Hand,
    write("  "),
    printFirstLineToScreen(Hand), nl,
    write("L "),
    printSecondLineToScreen(Hand),
    write(" R"), nl,
    write("  "),
    printFirstLineToScreen(Hand), nl.

printHandIndex(Start, Stop) :- Start > Stop.
printHandIndex(Start, Stop) :- Start > 9, Start < Stop+1,
    write(Start),
    write("    "),
    NewStart is Start + 1,
    printHandIndex(NewStart, Stop).
printHandIndex(Start, Stop) :- Start < Stop+1,
    write(Start),
    write("     "),
    NewStart is Start + 1,
    printHandIndex(NewStart, Stop).


printStateToScreen(State) :- State = [].
printStateToScreen(State) :- getBoardFromState(State, Board),
    getStockFromState(State, Stock),
    getHumanFromState(State, Human),
    getComputerFromState(State, Computer),
    nl,
    nl,
    write("Computer hand: "), nl,
    write(Computer),nl,
    write("Board: "), nl,
    printBoardToScreen(Board),nl,
    write("Human hand: "), nl,
    write(Human),nl,
    length(Human, HumanSize),
    write("   "),
    printHandIndex(1, HumanSize), nl,
    write("Stock: "), nl,
    write(Stock), nl.

canPlayTile(_, Human, _, _, _) :- [] = Human.
canPlayTile(State, [[L | [R|_]] | _], LeftMost, _, _) :- (R =:= LeftMost; L =:= LeftMost),
    write("You can play a tile and therefore cannot pass. Press h if you need a hint."),nl,
    playRound(State).
canPlayTile(State, [[L | [R|_]] | _], _, RightMost, _) :- R =:= L, L =:= RightMost,
    write("You can play a tile and therefore cannot pass. Press h if you need a hint."),nl,
    playRound(State).
canPlayTile(State, [[L | [R|_]] | _], _, RightMost, true) :- (R =:= RightMost; L =:= RightMost),
    write("You can play a tile and therefore cannot pass. Press h if you need a hint."),nl,
    playRound(State).
canPlayTile(State, [_ | Rest], LeftMost, RightMost, LastPassed) :-
    canPlayTile(State, Rest, LeftMost, RightMost, LastPassed).

checkForLegalMove(State) :- getHumanFromState(State, Human),
    getLastPassedFromState(State, LastPassed),
    getBoardFromState(State, Board),
    getLeftMostPip(Board, LeftMost),
    length(Board, Size),
    getRightMostPip(Board, RightMost, Size),
    canPlayTile(State, Human, LeftMost, RightMost, LastPassed).

canPlayTileAfterPassing(_, Human, _, _, _) :- [] = Human.
canPlayTileAfterPassing(State, [[L | [R|_]] | _], LeftMost, _, _) :- (R =:= LeftMost; L =:= LeftMost),
    write("You can play a tile and therefore cannot pass. Press h if you need a hint."),nl,
    justPassed(State).
canPlayTileAfterPassing(State, [[L | [R|_]] | _], _, RightMost, _) :- R =:= L, L =:= RightMost,
    write("You can play a tile and therefore cannot pass. Press h if you need a hint."),nl,
    justPassed(State).
canPlayTileAfterPassing(State, [[L | [R|_]] | _], _, RightMost, true) :- (R =:= RightMost; L =:= RightMost),
    write("You can play a tile and therefore cannot pass. Press h if you need a hint."),nl,
    justPassed(State).
canPlayTileAfterPassing(State, [_ | Rest], LeftMost, RightMost, LastPassed) :-
    canPlayTile(State, Rest, LeftMost, RightMost, LastPassed).

checkForLegalMoveAfterPassing(State) :- getHumanFromState(State, Human),
    getLastPassedFromState(State, LastPassed),
    getBoardFromState(State, Board),
    getLeftMostPip(Board, LeftMost),
    length(Board, Size),
    getRightMostPip(Board, RightMost, Size),
    canPlayTileAfterPassing(State, Human, LeftMost, RightMost, LastPassed).

humanPassTwice(State) :- checkForLegalMoveAfterPassing(State),
    write("You have passed again computer will play"), nl,
    printStateToScreen(State),
    getTournScoreFromState(State, TS),
    getRoundNoFromState(State, RN),
    getHumanFromState(State, Human),
    getHumanScoreFromState(State, HS),
    getComputerFromState(State, Computer),
    getComputerScoreFromState(State, CS),
    getBoardFromState(State, Board),
    getStockFromState(State, Stock),
    getPassCountFromState(State, PassCount),
    NewState = [TS, RN, Human, HS, Computer, CS, Board, Stock, computer, true, PassCount],
    playRound(NewState).


validateTileNumberAfterPassing(AnIndex, _, State, _) :- AnIndex = p, humanPassTwice(State).
validateTileNumberAfterPassing(AnIndex, _, State, _) :- AnIndex = h, getHelp(State), justPassed(State).
validateTileNumberAfterPassing(AnIndex, _, State, Index) :- AnIndex < 1, getTileToPlay(State, Index).
validateTileNumberAfterPassing(AnIndex, Size, State, Index) :- AnIndex > Size, getTileToPlay(State, Index).
validateTileNumberAfterPassing(AnIndex, Size, _, Index) :- AnIndex < Size+1, AnIndex > 0,
    Index = AnIndex.

getTileToPlayAfterPassing(State, Index) :- getHumanFromState(State, Human),
    length(Human, Size),
    write("Please enter number corresponding to a tile from left to right, 1 - "),
    write(Size),
    write(","), nl,
    write("Or enter 'h' for hint, or 'p' to pass: "),
    read(AnIndex),
    validateTileNumberAfterPassing(AnIndex, Size, State, Index).

isValidHumanMoveAfterPassing(State, l, LeftMost, _, L, R, _) :- L =:= LeftMost,
    Tile = [R, L],
    getBoardFromState(State, Board),
    append([Tile], Board, NewBoard),
    getHumanFromState(State, Human),
    Tile1 = [L, R],
    delete(Human, Tile1, NewHuman),
    getTournScoreFromState(State, TS),
    getRoundNoFromState(State, RN),
    getHumanScoreFromState(State, HS),
    getComputerFromState(State, Computer),
    getComputerScoreFromState(State, CS),
    getStockFromState(State, Stock),
    NewState = [TS, RN, NewHuman, HS, Computer, CS, NewBoard, Stock, computer, false, 0],
    printStateToScreen(NewState),
    playRound(NewState).
isValidHumanMoveAfterPassing(State, l, LeftMost, _, L, R, _) :- R =:= LeftMost,
    Tile = [L, R],
    getBoardFromState(State, Board),
    append([Tile], Board, NewBoard),
    getHumanFromState(State, Human),
    delete(Human, Tile, NewHuman),
    getTournScoreFromState(State, TS),
    getRoundNoFromState(State, RN),
    getHumanScoreFromState(State, HS),
    getComputerFromState(State, Computer),
    getComputerScoreFromState(State, CS),
    getStockFromState(State, Stock),
    NewState = [TS, RN, NewHuman, HS, Computer, CS, NewBoard, Stock, computer, false, 0],
    printStateToScreen(NewState),
    playRound(NewState).
isValidHumanMoveAfterPassing(State, r, _, RightMost, L, R, _) :- L =:= R, L =:= RightMost,
    Tile = [L, R],
    getBoardFromState(State, Board),
    append(Board, [Tile], NewBoard),
    getHumanFromState(State, Human),
    delete(Human, Tile, NewHuman),
    getTournScoreFromState(State, TS),
    getRoundNoFromState(State, RN),
    getHumanScoreFromState(State, HS),
    getComputerFromState(State, Computer),
    getComputerScoreFromState(State, CS),
    getStockFromState(State, Stock),
    NewState = [TS, RN, NewHuman, HS, Computer, CS, NewBoard, Stock, computer, false, 0],
    printStateToScreen(NewState),
    playRound(NewState).
isValidHumanMoveAfterPassing(State, r, _, RightMost, L, R, true) :- L =:= RightMost,
    Tile = [L, R],
    getBoardFromState(State, Board),
    append(Board, [Tile], NewBoard),
    getHumanFromState(State, Human),
    delete(Human, Tile, NewHuman),
    getTournScoreFromState(State, TS),
    getRoundNoFromState(State, RN),
    getHumanScoreFromState(State, HS),
    getComputerFromState(State, Computer),
    getComputerScoreFromState(State, CS),
    getStockFromState(State, Stock),
    NewState = [TS, RN, NewHuman, HS, Computer, CS, NewBoard, Stock, computer, false, 0],
    printStateToScreen(NewState),
    playRound(NewState).
isValidHumanMoveAfterPassing(State, r, _, RightMost, L, R, true) :- R =:= RightMost,
    Tile = [R, L],
    getBoardFromState(State, Board),
    append(Board, [Tile], NewBoard),
    getHumanFromState(State, Human),
    Tile1 = [L, R],
    delete(Human, Tile1, NewHuman),
    getTournScoreFromState(State, TS),
    getRoundNoFromState(State, RN),
    getHumanScoreFromState(State, HS),
    getComputerFromState(State, Computer),
    getComputerScoreFromState(State, CS),
    getStockFromState(State, Stock),
    NewState = [TS, RN, NewHuman, HS, Computer, CS, NewBoard, Stock, computer, false, 0],
    printStateToScreen(NewState),
    playRound(NewState).
isValidHumanMoveAfterPassing(State, _, _, _, _, _, _) :-
    write("Invalid move."), nl,
    justPassed(State).

validateHumanMoveAfterPassing(State, Board, LastPassed, Move) :- getLeftMostPip(Board, LeftMost),
    length(Board, Size),
    getRightMostPip(Board, RightMost, Size),
    [Tile | [Side | _]] = Move,
    [L | [R | _]] = Tile,
    isValidHumanMoveAfterPassing(State, Side, LeftMost, RightMost, L, R, LastPassed).

playHumanMoveAfterPassing(State, Move) :- getBoardFromState(State, Board),
    getLastPassedFromState(State, LastPassed),
    validateHumanMoveAfterPassing(State, Board, LastPassed, Move).

justPassed(State) :- [_|_] = State,
    printStateToScreen(State),
    getTileToPlayAfterPassing(State, Index),
    getSideToPlay(State, Side),
    getHumanFromState(State, Human),
    getTileAtIndex(State, Index, Human, Tile),
    Move = [Tile, Side],
    playHumanMoveAfterPassing(State, Move).

humanPass(State) :- checkForLegalMove(State),
    getStockFromState(State, Stock),
    [] = Stock,
    write("You have passed and the stock is empty, computer will play"), nl,
    getTournScoreFromState(State, TS),
    getRoundNoFromState(State, RN),
    getHumanFromState(State, Human),
    getHumanScoreFromState(State, HS),
    getComputerFromState(State, Computer),
    getComputerScoreFromState(State, CS),
    getBoardFromState(State, Board),
    getPassCountFromState(State, PassCount),
    NewPassCount = PassCount+1,
    NewState = [TS, RN, Human, HS, Computer, CS, Board, Stock, computer, true, NewPassCount],
    playRound(NewState).
humanPass(State) :- checkForLegalMove(State),
    write("You have passed on your move, if you pass again computer will play"), nl,
    getStockFromState(State, Stock),
    [First | _] = Stock,
    getHumanFromState(State, Human),
    append(Human, [First], NewHuman),
    delete(Stock, First, NewStock),
    getTournScoreFromState(State, TS),
    getRoundNoFromState(State, RN),
    getHumanScoreFromState(State, HS),
    getComputerFromState(State, Computer),
    getComputerScoreFromState(State, CS),
    getBoardFromState(State, Board),
    getLastPassedFromState(State, LastPassed),
    getPassCountFromState(State, PassCount),
    NewPassCount = PassCount+1,
    NewState = [TS, RN, NewHuman, HS, Computer, CS, Board, NewStock, human, LastPassed, NewPassCount],
    justPassed(NewState).

hintDisplay(_, [L | [R|_]], LeftMost, _, _, _) :- L =:= R, L =:= LeftMost,
    write("The computer weighs doubles above other tiles. The heaviest double which can legally be played is "),
    write(L),
    write(" - "),
    write(R), nl,
    write("And the computer recommends playing it on the left."), nl.
hintDisplay(_, [L | [R|_]], _, RightMost, _, _) :- L =:= R, L =:= RightMost,
    write("The computer weighs doubles above other tiles. The heaviest double which can legally be played is "),
    write(L),
    write(" - "),
    write(R), nl,
    write("However this double cannot be played on the left and so the computer recommends playing it on the right."), nl.
hintDisplay(_, [L | [R|_]], LeftMost, _, _, _) :- L =:= LeftMost,
    write("The heaviest tile which can legally be played is "),
    write(L),
    write(" - "),
    write(R), nl,
    write("And since the strategy is to play on your own side first the computer recommends playing this tile on the left."),nl.
hintDisplay(_, [L | [R|_]], LeftMost, _, _, _) :- R =:= LeftMost,
    write("The heaviest tile which can legally be played is "),
    write(L),
    write(" - "),
    write(R), nl,
    write("And since the strategy is to play on your own side first the computer recommends playing this tile on the left."),nl.
hintDisplay(_, [L | [R|_]], _, RightMost, true, _) :- L =:= RightMost,
    write("The heaviest tile which can legally be played is "),
    write(L),
    write(" - "),
    write(R), nl,
    write("However this tile cannot be played on the left but since the computer passed you can play this tile on the right."), nl.
hintDisplay(_, [L | [R|_]], _, RightMost, true, _) :- R =:= RightMost,
    write("The heaviest tile which can legally be played is "),
    write(L),
    write(" - "),
    write(R), nl,
    write("However this tile cannot be played on the left but since the computer passed you can play this tile on the right."), nl.
hintDisplay(State, _, LeftMost, RightMost, _, Rest) :- getHint(State, Rest, LeftMost, RightMost).

getHint(_, Hand, _, _) :- [] = Hand,
    write("You have no legal moves, the computer recommends you pass"), nl.
getHint(State, Hand, LeftMost, RightMost) :- [First | Rest] = Hand,
	getLastPassedFromState(State, LastPassed),
    hintDisplay(State, First, LeftMost, RightMost, LastPassed, Rest).

getHelp(State) :- [_ | _] = State,
    getHumanFromState(State, Human),
    makeBestTileOrder(Human, _, BestOrder),
    getBoardFromState(State, Board),
    getLeftMostPip(Board, LeftMost),
    length(Board, Size),
    getRightMostPip(Board, RightMost, Size),
    getHint(State, BestOrder, LeftMost, RightMost).

checkForEmptyPlayNext(PlayNext, _) :- PlayNext == computer.
checkForEmptyPlayNext(PlayNext, _) :- PlayNext == human.
checkForEmptyPlayNext(_, SAVEFILE) :-  nl(SAVEFILE),
    nl(SAVEFILE),
    tab(SAVEFILE, 2),
    write(SAVEFILE, "[]"),
    nl(SAVEFILE),
    write(SAVEFILE,"]."),
    close(SAVEFILE).

saveAndExit(State) :- write("Please enter filename to save to: "),
    read(FileName),
    string_concat(FileName, ".txt", NewFileName),
    with_output_to(atom(AFileName), write(NewFileName)),
    string_concat("c:/Users/emb14/Desktop/Barinberg/src/", AFileName, Path),
    open(Path, write, SAVEFILE),
    getTournScoreFromState(State, TS),
    write(SAVEFILE, "["),
    nl(SAVEFILE),  
    tab(SAVEFILE, 2),
    write(SAVEFILE, TS),
    write(SAVEFILE, ","),
    nl(SAVEFILE),
    nl(SAVEFILE),
    getRoundNoFromState(State, RN),
    tab(SAVEFILE, 2),
    write(SAVEFILE, RN),
    write(SAVEFILE, ","),
    nl(SAVEFILE),
    nl(SAVEFILE),
    getComputerFromState(State, Computer),
    getComputerScoreFromState(State, CS),
    tab(SAVEFILE, 2),
    write(SAVEFILE, Computer),
    write(SAVEFILE, ","),
    nl(SAVEFILE),
    tab(SAVEFILE, 2),
    write(SAVEFILE, CS),
    write(SAVEFILE, ","),
    getHumanFromState(State, Human),
    getHumanScoreFromState(State, HS),
    nl(SAVEFILE),
    nl(SAVEFILE),
    tab(SAVEFILE,2),
    write(SAVEFILE, Human),
    write(SAVEFILE, ","),
    nl(SAVEFILE),
    tab(SAVEFILE, 2),
    write(SAVEFILE, HS),
    write(SAVEFILE, ","),
    nl(SAVEFILE),
    nl(SAVEFILE),
    getBoardFromState(State, Board),
    append([l], Board, NewBoard),
    append(NewBoard, [r], NewNewBoard),
    tab(SAVEFILE, 2),
    write(SAVEFILE, NewNewBoard),
    write(SAVEFILE, ","),
    nl(SAVEFILE),
    nl(SAVEFILE),
    tab(SAVEFILE, 2),
    getStockFromState(State, Stock),
    write(SAVEFILE, Stock),
    write(SAVEFILE, ","),
    getLastPassedFromState(State, LastPassed), 
    nl(SAVEFILE),
    nl(SAVEFILE),
    tab(SAVEFILE, 2),
    write(SAVEFILE, LastPassed),
    write(SAVEFILE, ","),
    getPlayNextFromState(State, PlayNext),
    checkForEmptyPlayNext(PlayNext, SAVEFILE),
    nl(SAVEFILE),
    nl(SAVEFILE),
    tab(SAVEFILE, 2),
    write(SAVEFILE, PlayNext),
    nl(SAVEFILE),
    write(SAVEFILE,"]."),
    close(SAVEFILE), abort.

validateTileNumber(AnIndex, _, State, _) :- AnIndex = p, humanPass(State).
validateTileNumber(AnIndex, _, State, _) :- AnIndex = h, getHelp(State), humanMove(State).
validateTileNumber(AnIndex, _, State, _) :- AnIndex = s, saveAndExit(State).
validateTileNumber(AnIndex, _, State, Index) :- not(number(AnIndex)), getTileToPlay(State, Index).
validateTileNumber(AnIndex, _, State, Index) :- AnIndex < 1, getTileToPlay(State, Index).
validateTileNumber(AnIndex, Size, State, Index) :- AnIndex > Size, getTileToPlay(State, Index).
validateTileNumber(AnIndex, Size, _, Index) :- AnIndex < Size+1, AnIndex > 0,
    Index = AnIndex.

getTileToPlay(State, Index) :- getHumanFromState(State, Human),
    length(Human, Size),
    write("Please enter number corresponding to a tile from left to right, 1 - "),
    write(Size),
    write(","), nl,
    write("Or enter 'h' for hint, 'p' to pass, or 's' to save: "),
    read(AnIndex),
    validateTileNumber(AnIndex, Size, State, Index).

validateSide(ASide, State, Side) :- ASide \== l, ASide \== r,
    getSideToPlay(State, Side).
validateSide(ASide, _, Side) :- Side = ASide.

getSideToPlay(State, Side) :- write("Please enter which side to play (l/r)"),
    read(ASide),
    validateSide(ASide, State, Side).

getTileAtIndex(_, Index, Player, Tile) :- Index =:= 1,
    [First | _] = Player,
    Tile = First.
getTileAtIndex(State, Index, Player, Tile) :- [_ | Rest] = Player,
    Counter = Index - 1,
    getTileAtIndex(State, Counter, Rest, Tile).

getLeftMostPip(Board, _) :- [] = Board.
getLeftMostPip(Board, L) :- [First | _] = Board,
    [L | _] = First.

getRightMostPip(Board, _, _) :- [] = Board.
getRightMostPip(Board, R, Size) :- Size =:= 1, [First | _] = Board,
    [_ | R1] = First,
    [R | _] = R1.
getRightMostPip(Board, R, Size) :- Size > 1, [_ | Rest] = Board,
    Count is Size-1,
    getRightMostPip(Rest, R, Count).

isValidHumanMove(State, l, LeftMost, _, L, R, _) :- L =:= LeftMost,
    Tile = [R, L],
    getBoardFromState(State, Board),
    append([Tile], Board, NewBoard),
    getHumanFromState(State, Human),
    Tile1 = [L, R],
    delete(Human, Tile1, NewHuman),
    getTournScoreFromState(State, TS),
    getRoundNoFromState(State, RN),
    getHumanScoreFromState(State, HS),
    getComputerFromState(State, Computer),
    getComputerScoreFromState(State, CS),
    getStockFromState(State, Stock),
    NewState = [TS, RN, NewHuman, HS, Computer, CS, NewBoard, Stock, computer, false, 0],
    printStateToScreen(NewState),
    playRound(NewState).
isValidHumanMove(State, l, LeftMost, _, L, R, _) :- R =:= LeftMost,
    Tile = [L, R],
    getBoardFromState(State, Board),
    append([Tile], Board, NewBoard),
    getHumanFromState(State, Human),
    delete(Human, Tile, NewHuman),
    getTournScoreFromState(State, TS),
    getRoundNoFromState(State, RN),
    getHumanScoreFromState(State, HS),
    getComputerFromState(State, Computer),
    getComputerScoreFromState(State, CS),
    getStockFromState(State, Stock),
    NewState = [TS, RN, NewHuman, HS, Computer, CS, NewBoard, Stock, computer, false, 0],
    printStateToScreen(NewState),
    playRound(NewState).
isValidHumanMove(State, r, _, RightMost, L, R, _) :- L =:= R, L =:= RightMost,
    Tile = [L, R],
    getBoardFromState(State, Board),
    append(Board, [Tile], NewBoard),
    getHumanFromState(State, Human),
    delete(Human, Tile, NewHuman),
    getTournScoreFromState(State, TS),
    getRoundNoFromState(State, RN),
    getHumanScoreFromState(State, HS),
    getComputerFromState(State, Computer),
    getComputerScoreFromState(State, CS),
    getStockFromState(State, Stock),
    NewState = [TS, RN, NewHuman, HS, Computer, CS, NewBoard, Stock, computer, false, 0],
    printStateToScreen(NewState),
    playRound(NewState).
isValidHumanMove(State, r, _, RightMost, L, R, true) :- L =:= RightMost,
    Tile = [L, R],
    getBoardFromState(State, Board),
    append(Board, [Tile], NewBoard),
    getHumanFromState(State, Human),
    delete(Human, Tile, NewHuman),
    getTournScoreFromState(State, TS),
    getRoundNoFromState(State, RN),
    getHumanScoreFromState(State, HS),
    getComputerFromState(State, Computer),
    getComputerScoreFromState(State, CS),
    getStockFromState(State, Stock),
    NewState = [TS, RN, NewHuman, HS, Computer, CS, NewBoard, Stock, computer, false, 0],
    printStateToScreen(NewState),
    playRound(NewState).
isValidHumanMove(State, r, _, RightMost, L, R, true) :- R =:= RightMost,
    Tile = [R, L],
    getBoardFromState(State, Board),
    append(Board, [Tile], NewBoard),
    getHumanFromState(State, Human),
    Tile1 = [L, R],
    delete(Human, Tile1, NewHuman),
    getTournScoreFromState(State, TS),
    getRoundNoFromState(State, RN),
    getHumanScoreFromState(State, HS),
    getComputerFromState(State, Computer),
    getComputerScoreFromState(State, CS),
    getStockFromState(State, Stock),
    NewState = [TS, RN, NewHuman, HS, Computer, CS, NewBoard, Stock, computer, false, 0],
    printStateToScreen(NewState),
    playRound(NewState).
isValidHumanMove(State, _, _, _, _, _, _) :-
    write("Invalid move."), nl, humanMove(State).

validateHumanMove(State, Board, LastPassed, Move) :- getLeftMostPip(Board, LeftMost),
    length(Board, Size),
    getRightMostPip(Board, RightMost, Size),
    [Tile | [Side | _]] = Move,
    [L | [R | _]] = Tile,
    isValidHumanMove(State, Side, LeftMost, RightMost, L, R, LastPassed).

playHumanMove(State, Move) :- getBoardFromState(State, Board),
    getLastPassedFromState(State, LastPassed),
    validateHumanMove(State, Board, LastPassed, Move).

humanMove(State) :- State = [].
humanMove(State) :- [_ | _] = State,
    printStateToScreen(State),
    getTileToPlay(State, Index),
    getSideToPlay(State, Side),
    getHumanFromState(State, Human),
    getTileAtIndex(State, Index, Human, Tile),
    Move = [Tile, Side],
    playHumanMove(State, Move).

findBetterTile(LeftPip1, RightPip1, LeftPip2, RightPip2, _, _, Better, Worse) :- LeftPip1 == RightPip1, LeftPip2 \== RightPip2,
    Better = [LeftPip1, RightPip1],
    Worse = [LeftPip2, RightPip2].
findBetterTile(LeftPip1, RightPip1, LeftPip2, RightPip2, _, _, Better, Worse) :- LeftPip1 \= RightPip1, LeftPip2 == RightPip2,
    Better = [LeftPip2, RightPip2],
    Worse = [LeftPip1, RightPip1].
findBetterTile(LeftPip1, RightPip1, LeftPip2, RightPip2, Sum1, Sum2, Better, Worse) :- Sum1 >= Sum2,
    Better = [LeftPip1, RightPip1],
    Worse = [LeftPip2, RightPip2].
findBetterTile(LeftPip1, RightPip1, LeftPip2, RightPip2, Sum1, Sum2, Better, Worse) :- Sum1 < Sum2,
    Better = [LeftPip2, RightPip2],
    Worse = [LeftPip1, RightPip1].

insertIntoNewHand(Tile, NewHand, NewNewHand) :- [] = NewHand,
    append([Tile], NewHand, NewNewHand).
insertIntoNewHand(Tile, NewHand, NewNewHand) :- [First | Rest] = NewHand,
    [LeftPip1 | Rest1] = Tile,
    [RightPip1 | _ ] = Rest1,
    [LeftPip2 | Rest2] = First,
    [RightPip2 | _] = Rest2,
    TileSum = LeftPip1 + RightPip1,
    FirstSum = LeftPip2 + RightPip2,
    findBetterTile(LeftPip1, RightPip1, LeftPip2, RightPip2, TileSum, FirstSum, Better, Worse),
    insertIntoNewHand(Worse, Rest, NewHand1),
    append([Better], NewHand1, NewNewHand).

makeBestTileOrder(Computer, NewHand, AHand) :- [] = Computer, AHand = NewHand.
makeBestTileOrder(Computer, NewHand, AHand) :- [] = NewHand, [First | Rest] = Computer,
    append(NewHand, [First], NewNewHand),
    makeBestTileOrder(Rest, NewNewHand, AHand).
makeBestTileOrder(Computer, NewHand, AHand) :- [First | Rest] = Computer,
    insertIntoNewHand(First, NewHand, NewNewHand),
    makeBestTileOrder(Rest, NewNewHand, AHand).

playTheTile(State, _, RightMost, _, L, R) :- L =:= RightMost,
    write(L),
    write(" - "),
    write(R),
    write(" was the best tile the computer could play based on tile type and pip values (doubles before non-doubles and larger numbers before smaller numbers)"), nl,
    write("The computer prefers to play on the right and therefore will place the tile on the right."), nl,
    Tile = [L, R],
    getBoardFromState(State, Board),
    append(Board, [Tile], NewBoard),
    getComputerFromState(State, Computer),
    delete(Computer, Tile, NewComputer),
    getTournScoreFromState(State, TS),
    getRoundNoFromState(State, RN),
    getHumanScoreFromState(State, HS),
    getHumanFromState(State, Human),
    getComputerScoreFromState(State, CS),
    getStockFromState(State, Stock),
    NewState = [TS, RN, Human, HS, NewComputer, CS, NewBoard, Stock, human, false, 0],
    playRound(NewState).
playTheTile(State, _, RightMost, _, L, R) :- R =:= RightMost,
    write(L),
    write(" - "),
    write(R),
    write(" was the best tile the computer could play based on tile type and pip values (doubles before non-doubles and larger numbers before smaller numbers)"), nl,
    write("The computer prefers to play on the right and therefore will place the tile on the right."), nl,
    Tile = [R, L],
    getBoardFromState(State, Board),
    append(Board, [Tile], NewBoard),
    Tile1 = [L, R],
    getComputerFromState(State, Computer),
    delete(Computer, Tile1, NewComputer),
    getTournScoreFromState(State, TS),
    getRoundNoFromState(State, RN),
    getHumanScoreFromState(State, HS),
    getHumanFromState(State, Human),
    getComputerScoreFromState(State, CS),
    getStockFromState(State, Stock),
    NewState = [TS, RN, Human, HS, NewComputer, CS, NewBoard, Stock, human, false, 0],
    playRound(NewState).
playTheTile(State, LeftMost, _, true, L, R) :- R =:= LeftMost,
    write(L),
    write(" - "),
    write(R),
    write(" was the best tile the computer could play based on tile type and pip values (doubles before non-doubles and larger numbers before smaller numbers)"), nl,
    write("The computer prefers to play on the right however this tile could not be played on the right,"), nl,
    write("But since the human passed last move it can play it on the left and therefore the computer will play this tile on the left."),
    nl,
    Tile = [L, R],
    getBoardFromState(State, Board),
    append([Tile], Board, NewBoard),
    getComputerFromState(State, Computer),
    delete(Computer, Tile, NewComputer),
    getTournScoreFromState(State, TS),
    getRoundNoFromState(State, RN),
    getHumanScoreFromState(State, HS),
    getHumanFromState(State, Human),
    getComputerScoreFromState(State, CS),
    getStockFromState(State, Stock),
    NewState = [TS, RN, Human, HS, NewComputer, CS, NewBoard, Stock, human, false, 0],
    playRound(NewState).
playTheTile(State, LeftMost, _, true, L, R) :- L =:= LeftMost,
    write(L),
    write(" - "),
    write(R),
    write(" was the best tile the computer could play based on tile type and pip values (doubles before non-doubles and larger numbers before smaller numbers)"), nl,
    write("The computer prefers to play on the right however this tile could not be played on the right,"), nl,
    write("But since the human passed last move it can play it on the left and therefore the computer will play this tile on the left."),
    nl,
    Tile = [R, L],
    getBoardFromState(State, Board),
    append([Tile], Board, NewBoard),
    getComputerFromState(State, Computer),
    Tile1 = [L, R],
    delete(Computer, Tile1, NewComputer),
    getTournScoreFromState(State, TS),
    getRoundNoFromState(State, RN),
    getHumanScoreFromState(State, HS),
    getHumanFromState(State, Human),
    getComputerScoreFromState(State, CS),
    getStockFromState(State, Stock),
    NewState = [TS, RN, Human, HS, NewComputer, CS, NewBoard, Stock, human, false, 0],
    playRound(NewState).
playTheTile(State, LeftMost, _, false, L, R) :- L =:= R, L =:= LeftMost,
    write(L),
    write(" - "),
    write(R),
    write(" was the best tile the computer could play based on tile type and pip values (doubles before non-doubles and larger numbers before smaller numbers)"), nl,
    write("The computer prefers to play on the right however this tile could not be played on the right,"), nl,
    write("And even though the human did not pass last move it can play it on the left because the tile is a double and therefore the computer will play this tile on the left."),
    nl,
    Tile = [L, R],
    getBoardFromState(State, Board),
    append([Tile], Board, NewBoard),
    getComputerFromState(State, Computer),
    delete(Computer, Tile, NewComputer),
    getTournScoreFromState(State, TS),
    getRoundNoFromState(State, RN),
    getHumanScoreFromState(State, HS),
    getHumanFromState(State, Human),
    getComputerScoreFromState(State, CS),
    getStockFromState(State, Stock),
    NewState = [TS, RN, Human, HS, NewComputer, CS, NewBoard, Stock, human, false, 0],
    playRound(NewState).
playTheTile(_, _, _, _, _, _).

computerPlayTileAfterPassing(State, BestPlayOrder) :- [] = BestPlayOrder,
    write("After passing computer still has no legal moves, Human to play..."),nl,
    getTournScoreFromState(State, TS),
    getRoundNoFromState(State, RN),
    getHumanFromState(State, Human),
    getHumanScoreFromState(State, HS),
    getComputerFromState(State, Computer),
    getComputerScoreFromState(State, CS),
    getBoardFromState(State, Board),
    getStockFromState(State, Stock),
    getPassCountFromState(State, PassCount),
    NewState = [TS, RN, Human, HS, Computer, CS, Board, Stock, human, true, PassCount],
    playRound(NewState).
computerPlayTileAfterPassing(State, BestPlayOrder) :- [First | Rest] = BestPlayOrder,
    getBoardFromState(State, Board),
    getLastPassedFromState(State, LastPassed),
    getLeftMostPip(Board, LeftMost),
    length(Board, Size),
    getRightMostPip(Board, RightMost, Size),
    [L | [R | _]] = First,
    playTheTile(State, LeftMost, RightMost, LastPassed, L, R),
    computerPlayTileAfterPassing(State, Rest).

computerJustPassed(State) :-
    getComputerFromState(State, Computer),
    makeBestTileOrder(Computer, _, BestOrder),
    computerPlayTileAfterPassing(State, BestOrder).

computerPass(State) :- getStockFromState(State, Stock),
    [] = Stock,
    write("Computer has no legal moves, and the stock is empty so it is now human turn"), nl,
    getComputerFromState(State, Computer),
    getTournScoreFromState(State, TS),
    getRoundNoFromState(State, RN),
    getHumanFromState(State, Human),
    getHumanScoreFromState(State, HS),
    getComputerScoreFromState(State, CS),
    getBoardFromState(State, Board),
    getPassCountFromState(State, PassCount),
    NewPassCount = PassCount + 1,
    NewState = [TS, RN, Human, HS, Computer, CS, Board, Stock, human, true, NewPassCount],
    playRound(NewState).
computerPass(State) :- getComputerFromState(State, Computer),
    write("Computer has no legal moves, so he will pass and draw a tile."), nl,
    getStockFromState(State, Stock),
    [First | NewStock] = Stock,
    append(Computer, [First], NewComputer),
    getTournScoreFromState(State, TS),
    getRoundNoFromState(State, RN),
    getHumanFromState(State, Human),
    getHumanScoreFromState(State, HS),
    getComputerScoreFromState(State, CS),
    getBoardFromState(State, Board),
    getLastPassedFromState(State, LastPassed),
    getPassCountFromState(State, PassCount),
    NewPassCount = PassCount+1,
    NewState = [TS, RN, Human, HS, NewComputer, CS, Board, NewStock, computer, LastPassed, NewPassCount],
    computerJustPassed(NewState).

computerPlayTile(State, BestPlayOrder) :- [] = BestPlayOrder, computerPass(State).
computerPlayTile(State, BestPlayOrder) :- [First | Rest] = BestPlayOrder,
    getBoardFromState(State, Board),
    getLastPassedFromState(State, LastPassed),
    getLeftMostPip(Board, LeftMost),
    length(Board, Size),
    getRightMostPip(Board, RightMost, Size),
    [L | [R | _]] = First,
    playTheTile(State, LeftMost, RightMost, LastPassed, L, R),
    computerPlayTile(State, Rest).

computerMove(State) :- [_ | _] = State,
    getComputerFromState(State, Computer),
    makeBestTileOrder(Computer, _, BestOrder),
    computerPlayTile(State, BestOrder).

saveOrContinue(State, Input) :- Input == y,
    saveAndExit(State).
saveOrContinue(_, Input) :- Input == n.
saveOrContinue(State, _) :- offerSaveBeforeMove(State).

offerSaveBeforeMove(State) :- write("Would you like to save before the computer plays(y/n): "),
    read(Input),
    saveOrContinue(State, Input).

playerMove(State, PlayNext) :- PlayNext = human, humanMove(State).
playerMove(State, PlayNext) :- PlayNext = computer, offerSaveBeforeMove(State), computerMove(State).

sumPlayerPips(Player, Initial, Sum) :- [] = Player, Sum = Initial.
sumPlayerPips(Player, Initial, Sum) :- [First | Rest] = Player,
    [L|[R|_]] = First,
    Total is L+R,
    Sum1 is Initial + Total,
    sumPlayerPips(Rest, Sum1, Sum).

determineWinnerBySums(HS, CS, HumanSum, ComputerSum, NewHS, NewCS) :- HumanSum < ComputerSum,
    write("Human wins with "),
    write(HumanSum),
    write(" points in his hand, the computer only managed "),
    write(ComputerSum),
    nl,
    NewHS is HS + ComputerSum,
    NewCS is CS,
    write("The human score is now "),
    write(NewHS), nl,
    write("The computer score will remain "),
    write(NewCS), nl.
determineWinnerBySums(HS, CS, HumanSum, ComputerSum, NewHS, NewCS) :- ComputerSum > HumanSum,
    write("Computer wins with "),
    write(ComputerSum),
    write(" points in his hand, you only managed "),
    write(HumanSum),
    nl,
    NewHS is HS,
    NewCS is CS + HumanSum, 
    write("The human score will remain "),
    write(NewHS), nl,
    write("The computer score is now "),
    write(NewCS), nl.
determineWinnerBySums(HS, CS, HumanSum, ComputerSum, NewHS, NewCS) :- ComputerSum =:= HumanSum,
    write("Human ended with "),
    write(HumanSum),
    write(" points in his hand, and the computer had "),
    write(ComputerSum),
    nl,
    write("It is a TIE! Neither player will get points added to their score."),nl,
    NewHS is HS,
    NewCS is CS, 
    write("The human score will remain "),
    write(NewHS), nl,
    write("The computer score will remain "),
    write(NewCS), nl.

checkForWinnerByPoints(TS, HS, CS) :- HS>=TS,
    write("The tournament score was "),
    write(TS),
    nl,
    write("The Human player has achieved "),
    write(HS),
    write(" congradulations, you have won this tournament!"),
    nl,
    write("The computer was only able to amass "),
    write(CS),
    write(" points."), nl, abort.
checkForWinnerByPoints(TS, HS, CS) :- CS>=TS,
    write("The tournament score was "),
    write(TS),
    nl,
    write("The computer player has achieved "),
    write(CS),
    write(" unfortunetely, you have lost this tournament."),
    nl,
    write("You were only able to amass "),
    write(HS),
    write(" points."), nl, abort.
checkForWinnerByPoints(TS, HS, CS) :- CS < TS, HS < TS,
    write("The tournament score is "),
    write(TS), nl,
    write("Neither player has achieved the score yet"), nl.

doSaveOrContinue(State, Input) :- Input == y,
    saveAndExit(State).
doSaveOrContinue(_, Input) :- Input == n.
doSaveOrContinue(State, _) :- offerSaveBeforeStart(State).

offerSaveBeforeStart(State) :- write("Would you like to save before the round begins(y/n): "),
    read(Input),
    doSaveOrContinue(State, Input).

playRound(State) :- getPassCountFromState(State, PassCount),
    getStockFromState(State, Stock),
    [] = Stock,
    PassCount >= 2,
    write("Stock is empty and both players have passed, the round is over!"), nl,
    getHumanFromState(State, Human),
    getComputerFromState(State, Computer),
    getHumanScoreFromState(State, HS),
    getComputerScoreFromState(State, CS),
    sumPlayerPips(Computer, 0, ComputerSum),
    sumPlayerPips(Human, 0, HumanSum),
    determineWinnerBySums(HS, CS, HumanSum, ComputerSum, NewHS, NewCS),
    getTournScoreFromState(State, TS),
    checkForWinnerByPoints(TS, NewHS, NewCS),
    getRoundNoFromState(State, RN),
    NewRN is RN + 1,
    generateNums(6, Pips),
    generateTiles(Pips, Tiles),
    random_permutation(Tiles, AStock),
    givePlayerTiles(AStock, 8, Stock1, NewHuman),
    givePlayerTiles(Stock1, 8, Stock2, NewComputer),
    generateEngine(NewRN, Center),
    LastPassed = false,
    AState = [TS, NewRN, NewHuman, NewHS, NewComputer, NewCS, [], Stock2, [], LastPassed, 0],
    offerSaveBeforeStart(AState),
    Board = [Center],
    setFirstPlayer(NewHuman, NewComputer, Center, Stock2, PlayNext, NewHuman1, NewComputer1, NewStock),
    NewState = [TS, NewRN, NewHuman1, NewHS, NewComputer1, NewCS, Board, NewStock, PlayNext, LastPassed, 0],
    playRound(NewState).
playRound(State) :- getHumanFromState(State, Human), [] = Human,
    getComputerFromState(State, Computer),
    sumPlayerPips(Computer, 0, Sum),
    getHumanScoreFromState(State, HS),
    NewHS is HS+Sum,
    getTournScoreFromState(State, TS),
    getComputerScoreFromState(State, CS),
    write("Congradulations, you have won this round, "),
    write("Computer score will remain "),
    write(CS),
    write(" Human score was "),
    write(HS),
    write(" and is now "),
    write(NewHS), nl,
    checkForWinnerByPoints(TS, NewHS, CS),
    write("Tournament Score is "),
    write(TS), nl,
    getRoundNoFromState(State, RN),
    NewRN is RN + 1,
    generateNums(6, Pips),
    generateTiles(Pips, Tiles),
    random_permutation(Tiles, Stock),
    givePlayerTiles(Stock, 8, Stock1, NewHuman),
    givePlayerTiles(Stock1, 8, Stock2, NewComputer),
    generateEngine(NewRN, Center),
    PassCount = 0,
    LastPassed = false,
    AState = [TS, NewRN, NewHuman, NewHS, NewComputer, CS, [], Stock2, [], LastPassed, 0],
    offerSaveBeforeStart(AState),
    Board = [Center],
    setFirstPlayer(NewHuman, NewComputer, Center, Stock2, PlayNext, NewHuman1, NewComputer1, NewStock),
    NewState = [TS, NewRN, NewHuman1, NewHS, NewComputer1, CS, Board, NewStock, PlayNext, LastPassed, PassCount],
    playRound(NewState).
playRound(State) :- getComputerFromState(State, Computer), [] = Computer,
    getHumanFromState(State, Human),
    sumPlayerPips(Human, 0, Sum),
    getComputerScoreFromState(State, CS),
    NewCS is CS+Sum,
    getTournScoreFromState(State, TS),
    getHumanScoreFromState(State, HS),
    write("Computer has won this round, "),
    write("Human score will remain "),
    write(HS),
    write(" Computer score was "),
    write(CS),
    write(" and is now "),
    write(NewCS), nl,
    checkForWinnerByPoints(TS, HS, NewCS),
    write("Tournament Score is "),
    write(TS), nl,
    getRoundNoFromState(State, RN),
    NewRN is RN + 1,
    PassCount = 0,
    generateNums(6, Pips),
    generateTiles(Pips, Tiles),
    random_permutation(Tiles, Stock),
    givePlayerTiles(Stock, 8, Stock1, NewHuman),
    givePlayerTiles(Stock1, 8, Stock2, NewComputer),
    generateEngine(NewRN, Center),
    LastPassed = false,
    AState = [TS, NewRN, NewHuman, HS, NewComputer, NewCS, [], Stock2, [], LastPassed, 0],
    offerSaveBeforeStart(AState),
    Board = [Center],
    setFirstPlayer(NewHuman, NewComputer, Center, Stock2, PlayNext, NewHuman1, NewComputer1, NewStock),
    NewState = [TS, NewRN, NewHuman1, HS, NewComputer1, NewCS, Board, NewStock, PlayNext, LastPassed, PassCount],
    playRound(NewState).
playRound(State) :- getPlayNextFromState(State, PlayNext),
    playerMove(State, PlayNext).

startNewTournament() :- generateNums(6, Pips),
    generateTiles(Pips, Tiles),
    random_permutation(Tiles, Stock),
    givePlayerTiles(Stock, 8, Stock1, Human),
    givePlayerTiles(Stock1, 8, Stock2, Computer),
    getTournScoreFromUser(Score),
    RoundNo = 1,
    HumanScore = 0,
    ComputerScore = 0,
    LastPassed = false,
    PassCount = 0,
    AState = [Score, RoundNo, Human, HumanScore, Computer, ComputerScore, [], Stock2, [], LastPassed, 0],
    offerSaveBeforeStart(AState),
    generateEngine(RoundNo, Center),
    Board = [Center],
    setFirstPlayer(Human, Computer, Center, Stock2, PlayNext, NewHuman, NewComputer, NewStock),
    State = [Score, RoundNo, NewHuman, HumanScore, NewComputer, ComputerScore, Board, NewStock, PlayNext, LastPassed, PassCount],
    playRound(State).

checkIfItExists(FileName) :- access_file(FileName, exist).
checkIfItExists(_) :- write("Unable to find that file"), nl,
    startGame().

checkForEmptyBoard(Board, NewBoard, RemainingState, CurrentState) :- [First | [Rest | _]] = Board, First == l, Rest == r,
    [Stock | _] = RemainingState,
    getTournScoreFromState(CurrentState, TS),
    getRoundNoFromState(CurrentState, RN),
    getHumanFromState(CurrentState, Human),
    getHumanScoreFromState(CurrentState, HS),
    getComputerFromState(CurrentState, Computer),
    getComputerScoreFromState(CurrentState, CS),
    generateEngine(RN, Center),
    NewBoard = [Center],
    setFirstPlayer(Human, Computer, Center, Stock, PlayNext, NewHuman, NewComputer, NewStock),
    State = [TS, RN, NewHuman, HS, NewComputer, CS, NewBoard, NewStock, PlayNext, false, 0],
    playRound(State).
checkForEmptyBoard(Board, NewBoard, _, _) :-
    delete(Board, r, ABoard),
    [_ | NewBoard] = ABoard.

setPassCountFromLastPassed(LastPassed, PassCount) :- LastPassed = true, PassCount is 1.
setPassCountFromLastPassed(LastPassed, PassCount) :- LastPassed = false, PassCount is 0.
setPassCountFromLastPassed(_, _).

loadGame() :- write("Please enter the filename to load from: "),
    read(FileName),
    with_output_to(atom(AFileName), write(FileName)),
    string_concat(AFileName, ".txt", ANewFileName),
    string_concat("c:/Users/emb14/Desktop/Barinberg/src/", ANewFileName, NewFileName),
    checkIfItExists(NewFileName),
    open(NewFileName, read, READFILE),
    read(READFILE, SavedState),
    close(READFILE),
    [TS | Rest1] = SavedState,
    [RN | Rest2] = Rest1,
    [Computer | Rest3] = Rest2,
    [CS | Rest4] = Rest3,
    [Human | Rest5] = Rest4,
    [HS | Rest6] = Rest5,
    [Board | Rest7] = Rest6,
    CurrentState = [TS, RN, Human, HS, Computer, CS],
    checkForEmptyBoard(Board, NewBoard, Rest7, CurrentState),
    [Stock | Rest8] = Rest7,
    [LastPassed | Rest9] = Rest8,
    setPassCountFromLastPassed(LastPassed, PassCount),
    [PlayNext | _] = Rest9,
    State = [TS, RN, Human, HS, Computer, CS, NewBoard, Stock, PlayNext, LastPassed, PassCount],
    playRound(State).


loadOrNew(Input) :- Input == y,
    loadGame().
loadOrNew(Input) :- Input == n,
    startNewTournament().
loadOrNew(_) :- write("Invalid choice"), nl,
    startGame().

startGame() :- write("Would you like to load a game from saved state(y/n): "),
    read(Input),
    loadOrNew(Input).