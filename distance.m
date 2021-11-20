function h = distance(huTrain, huTest)
    result = 0;
    
    [m,n] = size(huTrain);
    
    for t = 1 : m
        for g = 1: n
            result = result + abs(huTrain(t,g) - huTest(t,g));
        end
    end
    
    h = result;
end