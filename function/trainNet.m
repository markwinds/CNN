function f = trainNet(inputArg1,inputArg2,inputArg3,inputArg4,inputArg5)
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


if inputArg4==1
	functionLayer=reluLayer;
elseif inputArg4==2
	functionLayer=leakyReluLayer;
elseif inputArg4==3
	functionLayer=clippedReluLayer(10);
end

learnRate=inputArg5;

replaceLayer=[3 7 11 13 15 18 21];


net = alexnet;
changeSize(inputArg1,inputArg3);                %�����е�ͼƬת��Ϊ��Ҫ�Ĵ�С
digitDatasetPath = fullfile('.\',inputArg1);		%ָ���������·��
imds = imageDatastore(digitDatasetPath,'IncludeSubfolders',true,'LabelSource','foldernames');%����������
[imdsTrain,imdsValidation] = splitEachLabel(imds,0.7,'randomized');     %�����������70%����ѵ��������ʣ����Ϊ��������


layersTransfer = net.Layers(1:end-3);               %����ԭ����������3�������������
for i=1:length(reluLayer)
	layersTransfer(replaceLayer(i))=functionLayer;
end
numClasses = numel(categories(imdsTrain.Labels));   %��ȡ�������
layers = [                  %������Ĳ���ṹ
    layersTransfer
    fullyConnectedLayer(numClasses,'WeightLearnRateFactor',10,'BiasLearnRateFactor',10)
    softmaxLayer
    classificationLayer];

options = trainingOptions('sgdm', ...   %�������ѵ������
    'MiniBatchSize',10, ...
    'MaxEpochs',8, ...					%�������������ֵ
    'InitialLearnRate',learnRate, ...
    'ValidationData',imdsValidation, ...
    'ValidationFrequency',3, ...
    'Verbose',false);

%'OutputFcn',@(info)stopIfAccuracyNotImproving(info,2)
%��ѡ�õ����������������������������鿴ѵ��ʱ���м����

netTransfer = trainNetwork(imdsTrain,layers,options);   %ѵ��������

YPred = classify(netTransfer,imdsValidation);           %�Բ�����������ʶ��
accuracy = mean(YPred == imdsValidation.Labels)         %������ʶ�����ȷ��
% resPic=findall(groot, 'Type', 'Figure');                %�ҳ��������ͼƬ�ľ��
% saveas(resPic,['.\picture\' inputArg2 '.jpg']);                      %����ѵ����ͼƬ
% save(['.\net\' inputArg2 '.mat'],'netTransfer');        %����ѵ���õ�����

f=accuracy;



end



% %-------------------------------------------------���Ը��칹������--------------------------------------------
% 
% function f = trainNet(inputArg1,inputArg2,inputArg3)
% %���ܣ� ��ָ���ļ����µ�ͼƬѵ������
% %������ inputArg1�����������ڵ��ļ��У�Ĭ����data
% %       inputArg2�� ��Ҫ�������磬��˴���д��������ƣ�����Ĭ�ϴ洢Ϊtemp���磬����һ�����г���ʱ�ᱻ����
% %       inputArg3�� Ŀ��ͼƬ����Ĵ�С��Ĭ��[227 227 3]
% 
% if nargin==0        %���3��������ȱʧ
%     inputArg1='data';
%     inputArg2='temp';
%     inputArg3=[227 227 3];
% elseif nargin==1    
%     inputArg2='temp';
%     inputArg3=[227 227 3];
% elseif nargin==2 
%     inputArg3=[227 227 3];
% end
% 
% net = alexnet;
% changeSize(inputArg1,inputArg3);                %�����е�ͼƬת��Ϊ��Ҫ�Ĵ�С
% digitDatasetPath = fullfile('.\',inputArg1);		%ָ���������·��
% imds = imageDatastore(digitDatasetPath,'IncludeSubfolders',true,'LabelSource','foldernames');%����������
% [imdsTrain,imdsValidation] = splitEachLabel(imds,0.7,'randomized');     %�����������70%����ѵ��������ʣ����Ϊ��������
% 
% replace=[3 7 11 13 15 18 21];
% layersTransfer = net.Layers(1:end-3);               %����ԭ����������3�������������
% numClasses = numel(categories(imdsTrain.Labels));   %��ȡ�������
% layers = [                  %������Ĳ���ṹ
%     layersTransfer
%     fullyConnectedLayer(numClasses,'WeightLearnRateFactor',10,'BiasLearnRateFactor',10)
%     softmaxLayer
%     classificationLayer];
% for i=1:length(replace)
%     layers(replace(i))=clippedReluLayer(10);
% end
% 
% 
% 
% 
% 
% 
% options = trainingOptions('sgdm', ...   %�������ѵ������
%     'MiniBatchSize',10, ...
%     'MaxEpochs',20, ...					%�������������ֵ
%     'InitialLearnRate',1e-4, ...
%     'ValidationData',imdsValidation, ...
%     'ValidationFrequency',3, ...
%     'Verbose',false, ...
%     'Plots','training-progress');
% %'OutputFcn',@(info)stopIfAccuracyNotImproving(info,2)
% %��ѡ�õ����������������������������鿴ѵ��ʱ���м����
% 
% netTransfer = trainNetwork(imdsTrain,layers,options);   %ѵ��������
% 
% YPred = classify(netTransfer,imdsValidation);           %�Բ�����������ʶ��
% accuracy = mean(YPred == imdsValidation.Labels)         %������ʶ�����ȷ��
% resPic=findall(groot, 'Type', 'Figure');                %�ҳ��������ͼƬ�ľ��
% saveas(resPic,['.\picture\' inputArg2 '.jpg']);                      %����ѵ����ͼƬ
% save(['.\net\' inputArg2 '.mat'],'netTransfer');        %����ѵ���õ�����
% 
% 
% 
% 
% 
% end





















