%Get records in Match array without zero values for odds
function [MatchWithoutZeros] = removeZeros(Match)

MatchWithoutZeros=[];
for i = 1:size(Match,1)
    row = Match(i,:);%This syntax gets the  llabels and the a=values in a table
    for j = 12:23
        odds= Match{i,j}; %This syntax gets the values only in an array
          if odds==0 
              break;
          elseif odds~=0 && j==23
              MatchWithoutZeros = [MatchWithoutZeros;row];
          end
    end
end