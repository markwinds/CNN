function f = trainNet(inputArg1,inputArg2,inputArg3)
%���ܣ� ��ָ���ļ����µ�ͼƬѵ������
%������ inputArg1�����������ڵ��ļ��У�Ĭ����data
%       inputArg2�� ��Ҫ�������磬��˴���д��������ƣ�����Ĭ�ϴ洢Ϊtemp���磬����һ�����г���ʱ�ᱻ����
%       inputArg3�� Ŀ��ͼƬ����Ĵ�С��Ĭ��[227 227 3]

if nargin==0        %���3��������ȱʧ
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
changeSize(inputArg1,inputArg3);                %�����е�ͼƬת��Ϊ��Ҫ�Ĵ�С
digitDatasetPath = fullfile('.\',inputArg1);		%ָ���������·��
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
savefig('ssdd.fig');
save(['.\net\' inputArg2 '.mat'],'netTransfer');





end

