% clear all;
% % global zbt;
% net = alexnet;

% changeSize;                %将库中的图片转化为需要的大小
% digitDatasetPath = fullfile('.\','data');		%指定样本库的路径
% imds = imageDatastore(digitDatasetPath,'IncludeSubfolders',true,'LabelSource','foldernames');%建立样本库
% [imdsTrain,imdsValidation] = splitEachLabel(imds,0.7,'randomized');     %随机将样本库70%归入训练用例，剩余作为测试用例
% 
% layersTransfer = net.Layers(1:end-3);               %保留原神经网络除最后3层外的其他部分
% numClasses = numel(categories(imdsTrain.Labels));   %获取类的数量
% layers = [                  %神经网络的层序结构
%     layersTransfer
%     fullyConnectedLayer(numClasses,'WeightLearnRateFactor',10,'BiasLearnRateFactor',10)
%     softmaxLayer
%     classificationLayer];
% 
% options = trainingOptions('sgdm', ...   %神经网络的训练参数
%     'MiniBatchSize',10, ...
%     'MaxEpochs',6, ...
%     'InitialLearnRate',1e-4, ...
%     'ValidationData',imdsValidation, ...
%     'ValidationFrequency',3, ...
%     'Verbose',false, ...
%     'Plots','training-progress',...
%     'OutputFcn',@(info)stopIfAccuracyNotImproving(info,2));
% 
% netTransfer = trainNetwork(imdsTrain,layers,options);   %训练神经网络
% 
% %     zbt=findall(groot, 'Type', 'Figure');
% %     saveas(zbt,'hh.jpg');
% YPred = classify(netTransfer,imdsValidation);           %对测试样例进行识别
% accuracy = mean(YPred == imdsValidation.Labels)         %输出最后识别的正确率
% % save('E:\github\CNN\net\temp1.mat','netTransfer');


% x=[0.001 0.0002 0.0001 0.00008 0.00005 0.00003 0.00001 0.000005 0.000001];
% y=[0.5170 0.8980 0.9728 0.9796	0.9932 0.9932 0.9728 1 0.9632];
% semilogx(x,y);
% xlabel('学习率');
% ylabel('正确率');
% title('正确率与学习率的对数关系图');

rata=[1e-6,5e-6,1e-5,3e-5,5e-5,8e-5,1e-4,5e-4,1e-3,5e-3];
ans1=[0.870748 0.918367 0.952381 0.952381 0.979592 0.986395 0.979592 0.761905 0.945578 0.517007];
ans2=[0.925170 0.925170 0.986395 0.986395 0.979592 0.945578 0.959184 0.653061 0.517007 0.482993];
ans3=[0.979592 0.986395 0.965986 0.979592 1.000000 0.972789 0.993197 0.904762 0.517007 0.000000];

semilogx(rata,ans1);
hold on;
semilogx(rata,ans2);
hold on;
semilogx(rata,ans3);
hold on;
xlabel('学习率');
ylabel('正确率');
title('正确率与学习率的对数关系图');
hold off







