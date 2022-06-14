%Scale with the maximum odd of each line
function scaleOdds = scaleOdds(Array)
    
    maxOdd = max(Array,[],2);
    scaleOdds = Array./maxOdd;
end