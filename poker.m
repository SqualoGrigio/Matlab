%Loads files and initializes some variables
clear
clc
shuffledDeck=randperm(52);
load CardDeck
set(0,'DefaultFigureWindowStyle','docked')
iptsetpref('ImshowInitialMagnification', 'fit')
y = audioread('cardPlace1.wav');
cardPlace = audioplayer(y,44100);

% Input Y for starting the game
startgame=input('Are you ready to start playing poker?(Y/N)','s');
startgame = upper(startgame);

%Whole loop to start game
while startgame=='Y'
    uiwait(msgbox({'Hands(in descending order)';'Five of a kind';'Four of a kind';'Full house';'Three of a kind';'Two pair';'One pair';'High Card'}))
    fprintf('\nThe game is under the rule of ace-to-five so flush and the straight will not be recongnized!\n')
% dealing cards
    hand=[0,0,0,0,0];
for i=1:5
    if hand(i)==0
        hand(i)=shuffledDeck(1);
        shuffledDeck(1)=[];
    end
end
close ALL
imshow([BlueDeck{hand}])
play(cardPlace)
%The Player can change the cards now
for k=1:5
    fprintf('For card %i,',k)
    redraw=input('do you want to redraw this card?(Y/N): ','s');
    redraw = upper(redraw);
    if redraw=='Y';
        hand(k)=shuffledDeck(1);
        shuffledDeck(1)=[];
        pause(.5)
        play(cardPlace)
        imshow([BlueDeck{hand}]);
    end
end
%count the cards by numbers
for k=1:14
counts(k)=0;
end

for k=1:14
    for i=1:5
        if hand(i)>=(4*k-3) && hand(i)<=(4*k)
            counts(k)=counts(k)+1;
        end
    end
end

%determining result
result=0;

for k=1:14
    if counts(k)==5
        result='Five of a kind!';
    elseif counts(k)==4
        result='Four of a kind!';
    elseif counts(k)==3
        for t=1:14
            if counts(t)==2
                result='Full House!';
            elseif counts(t)==1
                result='Three of a kind!';
            end
        end
    end
end

if result==0
    for k=1:14
        if counts(k)==2
        for t=[1:k-1,k+1:14]
            if counts(t)==2
                result='Two pair!';
break
            elseif counts(t)~=2
                result='One pair!';
            end
        end
        end
    end
end

if result==0
    result='High Card!';
end

%Prints result and prompts to start again
fprintf('\n%s\n',result)
startgame=input('Would you like to play again?(Y/N)','s');
startgame = upper(startgame);
end
fprintf('\nGoodbye')