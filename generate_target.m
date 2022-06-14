function [target] = generate_target(goals)

N = length(goals);
target = zeros(N,3);

for k = 0:1:N-1
    x = goals(k+1,1);
    y = goals(k+1,2);
    if (x-y>0)
        target(k+1,1) = 1;
        
    elseif (x-y == 0)
        target(k+1,2) = 1;
    
    else
        target(k+1,3) = 1;
    end
    
end