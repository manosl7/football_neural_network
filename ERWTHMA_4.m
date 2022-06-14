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

%BW odds in array
m1 = MatchWithoutZeros.BWH;
m2 = MatchWithoutZeros.BWD;
m3 = double(MatchWithoutZeros.BWA);
BW_odds = [m1,m2,m3];

clear m1; clear m2; clear m3;

%LB odds in array
m1 = MatchWithoutZeros.LBH;
m2 = MatchWithoutZeros.LBD;
m3 = double(MatchWithoutZeros.LBA);
LB_odds = [m1,m2,m3];

clear m1; clear m2; clear m3;

%IW odds in array
m1 = MatchWithoutZeros.IWH;
m2 = MatchWithoutZeros.IWD;
m3 = double(MatchWithoutZeros.IWA);
IW_odds = [m1,m2,m3];


%fuzzy c-means clustering on B365_odds and return of 3 cluster centers
[center_B365, U_B365] = fcm(B365_odds, 3);
maxU_B365 = max(U_B365);
index1_B365 = find(U_B365(1, :) == maxU_B365);
index2_B365 = find(U_B365(2, :) == maxU_B365);
index3_B365 = find(U_B365(3, :) == maxU_B365);

%fuzzy c-means clustering on BW_odds and return of 3 cluster centers
[center_BW, U_BW] = fcm(BW_odds, 3);
maxU_BW = max(U_BW);
index1_BW = find(U_BW(1, :) == maxU_BW);
index2_BW = find(U_BW(2, :) == maxU_BW);
index3_BW = find(U_BW(3, :) == maxU_BW);

%fuzzy c-means clustering on LB_odds and return of 3 cluster centers
[center_LB, U_LB] = fcm(LB_odds, 3);
maxU_LB = max(U_LB);
index1_LB = find(U_LB(1, :) == maxU_LB);
index2_LB = find(U_LB(2, :) == maxU_LB);
index3_LB = find(U_LB(3, :) == maxU_LB);

%fuzzy c-means clustering on IW_odds and return of 3 cluster centers
[center_IW, U_IW] = fcm(IW_odds, 3);
maxU_IW = max(U_IW);
index1_IW = find(U_IW(1, :) == maxU_IW);
index2_IW = find(U_IW(2, :) == maxU_IW);
index3_IW = find(U_IW(3, :) == maxU_IW);
