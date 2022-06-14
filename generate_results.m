%Get the result of each game in an one dimensional array (1=Home,2=Draw,3=Away)

function results = generate_results(target)

N = length(target);
results = zeros(N,1);

for i = 1:N
    x = find(target(i,:)==1);
    results(i) = x;
end