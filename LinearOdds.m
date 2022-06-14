%Single Layer NN

function [net,accuracy] = LinearOdds(oddsArray,target) 
    
    net= feedforwardnet(3);
    net = init(net);
    net.numLayers = 1;
    net.trainParam.goal= 0;
    net.trainParam.epochs = 150;
    net.trainParam.lr = 0.0001;
    net.outputConnect = 1;
    net.trainFcn = 'trainlm';
    net.layers{net.numLayers}.transferFcn = 'tansig';
    net = train(net,oddsArray,target); 
   
    %accuracy
    outputs = net(oddsArray);
    [values,pred_ind] = max(outputs,[],1);
    [~,actual_ind] = max(target,[],1);
    accuracy = sum(pred_ind==actual_ind)/size(oddsArray,2)*100;
end