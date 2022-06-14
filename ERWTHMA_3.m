%clc
%clear

%Load database files
%EuropeanSoccerDatabaseRetriever;

%Generate array without zeros
%MatchWithoutZeros = removeZeros(Match);


%Bet365 odds in array
m1 = MatchWithoutZeros.B365H;
m2 = MatchWithoutZeros.B365D;
m3 = double(MatchWithoutZeros.B365A);
B365_odds = [m1,m2,m3];

clear m1; clear m2; clear m3;
m1 = MatchWithoutZeros.BWH;
m2 = MatchWithoutZeros.BWD;
m3 = double(MatchWithoutZeros.BWA);
BW_odds = [m1,m2,m3];

clear m1; clear m2; clear m3;
m1 = MatchWithoutZeros.LBH;
m2 = MatchWithoutZeros.LBD;
m3 = double(MatchWithoutZeros.LBA);
LB_odds = [m1,m2,m3];

clear m1; clear m2; clear m3;
m1 = MatchWithoutZeros.IWH;
m2 = MatchWithoutZeros.IWD;
m3 = double(MatchWithoutZeros.IWA);
IW_odds = [m1,m2,m3];


%buildUpPlaySpeed, buildUpPlayPassing, chanceCreationPassing, chanceCreationCrossing, 
%chanceCreationShooting, defencePressure, defenceAggregation, defenceTeamWidth

clear m1; clear m2; clear m3;

MatchDate = zeros(22467,1);
for i = 1:22467
    dateValue = datetime(MatchWithoutZeros{i,6}{1,1});
    MatchDate(i) = year(dateValue);
end  

TeamAttributesDate = zeros(1458,1);
for i = 1:1458
    dateValue = datetime(TeamAttributes{i,4}{1,1});
    TeamAttributesDate(i) = year(dateValue);
end

m1 = double(MatchDate);
m2 = double(MatchWithoutZeros.home_team_api_id);
m3 = double(MatchWithoutZeros.away_team_api_id);
m4 = double(MatchWithoutZeros.home_team_goal);
m5 = double(MatchWithoutZeros.away_team_goal);
m6 = [B365_odds,BW_odds,IW_odds,LB_odds];
m = [m1,m2,m3,m4,m5,m6];

m1 = double(TeamAttributesDate);
m2 = double(TeamAttributes.team_api_id);
%buildUpPlaySpeed, buildUpPlayPassing, chanceCreationPassing, chanceCreationCrossing, 
%chanceCreationShooting, defencePressure, defenceAggression, defenceTeamWidth
m3 = [TeamAttributes.buildUpPlaySpeed, TeamAttributes.buildUpPlayPassing,TeamAttributes.chanceCreationPassing,TeamAttributes.chanceCreationCrossing,TeamAttributes.chanceCreationShooting,TeamAttributes.defencePressure,TeamAttributes.defenceAggression,TeamAttributes.defenceTeamWidth];
n = [m1,m2,m3];
n = double(n);

M = length(m);
N = length(n);

TeamAttributesNew = zeros(22467,28);
goals = [];
for i = 1:M
   yearOfTheMatch = m(i,1);
   homeTeamId = m(i,2);
   awayTeamId = m(i,3);
   row1Id = i;
   for j = 1:N
      if ((n(j,1) == yearOfTheMatch) && (n(j,2) == homeTeamId))
          row2Id = j;
          
          for k = 1:N
              if ((n(k,1) == yearOfTheMatch) && (n(k,2) == awayTeamId))
                  row3Id = k;
                  break;
              else
                  row3Id = 0;
              end
          end
          break;
      else 
          row2Id = 0;
      end
   end
   if( (row2Id ~= 0) && (row3Id ~= 0) )
       row1 = m(row1Id,6:17);
       row2 = n(row2Id,3:10);
       row3 = n(row3Id, 3:10);
       rowGoals = m(row1Id,4:5);
       TeamAttributesNew(row1Id,:) = [row1,row2,row3];
       goals = [goals;rowGoals];
   end    
end

TeamAttributesNew = TeamAttributesNew(all(TeamAttributesNew,2),:);

TeamAttributesNew = scaleOdds(TeamAttributesNew);

TeamAttributesNew = TeamAttributesNew';


target = generate_target(goals);

results = generate_results(target);
target = target';


net= feedforwardnet([27 9]);
net = init(net);
net.numLayers = 3;
net.trainFcn = 'trainbr';
net.trainParam.goal= 0;
net.trainParam.epochs = 200;
net.trainParam.lr = 0.0001;
net.layers{1}.transferFcn = 'tansig';
net.layers{2}.transferFcn = 'tansig';
net.layers{3}.transferFcn = 'purelin';
net = train(net,TeamAttributesNew,target); 


outputs = net(TeamAttributesNew);
[values,pred_ind] = max(outputs,[],1);
[~,actual_ind] = max(target,[],1);
accuracy_erwthma_3 = sum(pred_ind==actual_ind)/size(TeamAttributesNew,2)*100;

    