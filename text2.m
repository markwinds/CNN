net = alexnet;

changeSize;                %将库中的图片转化为需要的大小
digitDatasetPath = fullfile('E:','github','CNN','data');		%指定样本库的路径
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




