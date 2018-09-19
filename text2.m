net = alexnet;

changeSize;                %�����е�ͼƬת��Ϊ��Ҫ�Ĵ�С
digitDatasetPath = fullfile('E:','github','CNN','data');		%ָ���������·��
imds = imageDatastore(digitDatasetPath,'IncludeSubfolders',true,'LabelSource','foldernames');%����������
[imdsTrain,imdsValidation] = splitEachLabel(imds,0.7,'randomized');     %�����������70%����ѵ��������ʣ����Ϊ��������

layersTransfer = net.Layers(1:end-3);               %����ԭ����������3�������������
numClasses = numel(categories(imdsTrain.Labels));   %��ȡ�������
layers = [                  %������Ĳ���ṹ
    layersTransfer
    fullyConnectedLayer(numClasses,'WeightLearnRateFactor',10,'BiasLearnRateFactor',10)
    softmaxLayer
    classificationLayer];

options = trainingOptions('sgdm', ...   %�������ѵ������
    'MiniBatchSize',10, ...
    'MaxEpochs',6, ...
    'InitialLearnRate',1e-4, ...
    'ValidationData',imdsValidation, ...
    'ValidationFrequency',3, ...
    'Verbose',false, ...
    'Plots','training-progress');

netTransfer = trainNetwork(imdsTrain,layers,options);   %ѵ��������

YPred = classify(netTransfer,imdsValidation);           %�Բ�����������ʶ��
accuracy = mean(YPred == imdsValidation.Labels)         %������ʶ�����ȷ��




