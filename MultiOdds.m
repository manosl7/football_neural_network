%Multi Layer NN

function [net,accuracy] = MultiOdds(oddsArray,target)
    
    net= feedforwardnet([27 9]);
    %net= feedforwardnet([4 4]);
    net = init(net);
    net.numLayers = 3;
    net.trainFcn = 'trainbr';
    net.trainParam.goal= 0;
    net.trainParam.epochs = 150;
    net.trainParam.lr = 0.0001;
    net.layers{1}.transferFcn = 'tansig';
    net.layers{2}.transferFcn = 'tansig';
    net.layers{3}.transferFcn = 'purelin';
    net = train(net,oddsArray,target); 
    
    %Accuracy
    outputs=net(oddsArray);
    [values,pred_ind]=max(outputs,[],1);
    [~,actual_ind]=max(target,[],1);
    accuracy=sum(pred_ind==actual_ind)/size(oddsArray,2)*100;
        
end