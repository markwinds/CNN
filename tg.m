% 
% inputSize=[227 227 3];          %目标图像矩阵的大小
% 
% file=dir('E:\github\CNN\data\bad\*.jpg');       %读取目标文件夹下的所有jpg文件
% len=length(file);
% for i=1:len                     %对每一个目标文件进行操作
%     old_name=file(i).name;      %获取目标文件的文件名
%     Img=imread(['E:\github\CNN\data\bad\' old_name]);   %读取对应的文件
%     Img = imresize(Img,inputSize(1:2));                 %转化大小
%     delete(['E:\github\CNN\data\bad\' old_name]);       %删除原文件
%     new_name=num2str(i,'%04d');                                %将标号转化为字符作为文件名  这里注意一定要加%04d，不然inwrite产生的新图片可能会覆盖还未转化的同名的图片
%     imwrite(Img,['E:\github\CNN\data\bad\' new_name '.jpg']);%存储图片
% end
% 
% file=dir('E:\github\CNN\data\good\*.jpg');
% len=length(file);
% for i=1:1:len
%     old_name=file(i).name;
%     Img=imread(['E:\github\CNN\data\good\' old_name]);
%     Img = imresize(Img,inputSize(1:2));
%     delete(['E:\github\CNN\data\good\' old_name]);
%     new_name=num2str(i,'%04d');
%     imwrite(Img,['E:\github\CNN\data\good\' new_name '.jpg']);
% end


% net = alexnet;

changeSize;                %将库中的图片转化为需要的大小
digitDatasetPath = fullfile('E:','github','CNN','data');		%指定样本库的路径
imds = imageDatastore(digitDatasetPath,'IncludeSubfolders',true,'LabelSource','foldernames');%建立样本库
[imdsTrain,imdsValidation] = splitEachLabel(imds,0.1,'randomized');     %随机将样本库70%归入训练用例，剩余作为测试用例

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
%     'Plots','training-progress');
% 
% netTransfer = trainNetwork(imdsTrain,layers,options);   %训练神经网络
%clear all;
load('-mat','E:\github\CNN\net\m3.mat');

% file=dir('E:\github\CNN\Validation\good\*.jpg');       %读取目标文件夹下的所有jpg文件
% len=length(file);
% for i=1:len                     %对每一个目标文件进行操作
%     old_name=file(i).name;      %获取目标文件的文件名
%     Img=imread(['E:\github\CNN\Validation\good\' old_name]);   %读取对应的文件
%     Img = imresize(Img,inputSize(1:2));                 %转化大小
%     delete(['E:\github\CNN\data\bad\' old_name]);       %删除原文件
%     new_name=num2str(i,'%04d');                                %将标号转化为字符作为文件名  这里注意一定要加%04d，不然inwrite产生的新图片可能会覆盖还未转化的同名的图片
%     imwrite(Img,['E:\github\CNN\data\bad\' new_name '.jpg']);%存储图片
% end

YPred = classify(netTransfer,imdsValidation);           %对测试样例进行识别
for i=1:length(YPred)
    if YPred(i) ~= imdsValidation.Labels(i)
        figure
        ko=imdsValidation.Files{i,1};
        Img=imread(ko)
        imshow(Img)
    end
end
accuracy = mean(YPred == imdsValidation.Labels)         %输出最后识别的正确率













