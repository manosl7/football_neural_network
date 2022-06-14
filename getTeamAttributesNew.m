%Get new TeamAttributes array acording to MatchWithoutZeros array
%The attributes of each team are different from season to season
%We ignore the matches that we do not have the team attributes for the
%season they took place

function [TeamAttributesNew] = getTeamAttributesNew(MatchWithoutZeros,TeamAttributes)

    for i = 0:22467
        MatchWithoutZeros(i,6) = datetime(MatchWithoutZeros(i,6),'InputFormat','yyyy-MM-dd');
    end   



    TeamAttributesNew = zeros(22467,23);
    N = length(MatchWithoutZeros);
    K = length(TeamAttributes);
    
    for i = 1:K
        teamId = TeamAttributes(i,3); %position of team_api_id in TeamAttributes array
        for j = 1:N
            
            
            
        end    
        
        
        
    end
    

end