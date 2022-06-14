%clc
%clear

%Load database files
EuropeanSoccerDatabaseRetriever;

%Generate array without zeros
MatchWithoutZeros = removeZeros(Match);


%Bet365 odds in array
m1 = MatchWithoutZeros.B365H;
m2 = MatchWithoutZeros.B365D;
m3 = double(MatchWithoutZeros.B365A);
B365_odds = [m1,m2,m3];
clear m1; clear m2; clear m3;

%BW odds in array
m1 = MatchWithoutZeros.BWH;
m2 = MatchWithoutZeros.BWD;
m3 = double(MatchWithoutZeros.BWA);
BW_odds = [m1,m2,m3];

%LB odds in array
clear m1; clear m2; clear m3;
m1 = MatchWithoutZeros.LBH;
m2 = MatchWithoutZeros.LBD;
m3 = double(MatchWithoutZeros.LBA);
LB_odds = [m1,m2,m3];
%IW odds in array
clear m1; clear m2; clear m3;
m1 = MatchWithoutZeros.IWH;
m2 = MatchWithoutZeros.IWD;
m3 = double(MatchWithoutZeros.IWA);
IW_odds = [m1,m2,m3];

%scale B365_odds
B365_odds = scaleOdds(B365_odds);
B365_odds = B365_odds';
%scale BW_odds
BW_odds = scaleOdds(BW_odds);
BW_odds = BW_odds';
%scale LB_odds
LB_odds = scaleOdds(LB_odds);
LB_odds = LB_odds';
%scale IW_odds
IW_odds = scaleOdds(IW_odds);
IW_odds = IW_odds';

%Take the goals of each match
goals = [MatchWithoutZeros.home_team_goal MatchWithoutZeros.away_team_goal];

%Make the target vector for the neural network
target = generate_target(goals);

%Get the result of each game in an one dimensional array (1=Home,2=Draw,3=Away)
results = generate_results(target);
target = target';

%Linear NN for B365
[netB365Linear,accuracyB365Linear] = LinearOdds(B365_odds,target);
%Linear NN for BW
[netBWLinear,accuracyBWLinear] = LinearOdds(BW_odds,target);
%Linear NN for LB
[netLBLinear,accuracyLBLinear] = LinearOdds(LB_odds,target);
%Linear NN for IW
[netIWLinear,accuracyIWLinear] = LinearOdds(IW_odds,target);
%MultiLayer NN for B365
[netB365Multi,accuracyB365Multi] = MultiOdds(B365_odds,target);
%MultiLayer NN for BW
[netBWMulti,accuracyBWMulti]=MultiOdds(BW_odds,target);
%MultiLayer NN for LB
[netLBMulti,accuracyLBMulti]=MultiOdds(LB_odds,target);
%MultiLayer NN for IW
[netIWMulti,accuracyIWMulti]=MultiOdds(IW_odds,target);
