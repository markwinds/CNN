function f = trainNet(inputArg1,inputArg2,inputArg3)
%功能： 用指定文件夹下的图片训练网络
%参数： inputArg1：样本库所在的文件夹，默认是data
%       inputArg2： 若要保存网络，则此处填写网络的名称，否则默认存储为temp网络，在下一次运行程序时会被覆盖
%       inputArg3： 目标图片矩阵的大小，默认[227 227 3]

if nargin==0        %如果3个参数都缺失
    inputArg1='data';
    inputArg2='temp';
    inputArg3=[227 227 3];
elseif nargin==1    
    inputArg2='temp';
    inputArg3=[227 227 3];
elseif nargin==2 
    inputArg3=[227 227 3];
end

net = alexnet;
changeSize(inputArg1,inputArg3);                %将库中的图片转化为需要的大小
digitDatasetPath = fullfile('.\',inputArg1);		%指定样本库的路径
imds = imageDatastore(digitDatasetPath,'IncludeSubfolders',true,'LabelSource','foldernames');%建立样本库
[imdsTrain,imdsValidation] = splitEachLabel(imds,0.7,'randomized');     %随机将样本库70%归入训练用例，剩余作为测试用例

layersTransfer = net.Layers(1:end-3);               %保留原神经网络除最后3层外的其他部分
numClasses = numel(categories(imdsTrain.Labels));   %获取类的数量
layers = [                  %神经网络的层序结构
    layersTransfer
    fullyConnectedLayer(numClasses,'WeightLearnRateFactor',10,'BiasLearnRateFactor',10)
    softmaxLayer
    classificationLayer];

options = trainingOptions('sgdm', ...   %神经网络的训练参数
    'MiniBatchSize',10, ...
    'MaxEpochs',6, ...
    'InitialLearnRate',1e-4, ...
    'ValidationData',imdsValidation, ...
    'ValidationFrequency',3, ...
    'Verbose',false, ...
    'Plots','training-progress');

netTransfer = trainNetwork(imdsTrain,layers,options);   %训练神经网络

YPred = classify(netTransfer,imdsValidation);           %对测试样例进行识别
accuracy = mean(YPred == imdsValidation.Labels)         %输出最后识别的正确率
savefig('ssdd.fig');
save(['.\net\' inputArg2 '.mat'],'netTransfer');





end

