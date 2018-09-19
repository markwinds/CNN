% 
% inputSize=[227 227 3];          %Ŀ��ͼ�����Ĵ�С
% 
% file=dir('E:\github\CNN\data\bad\*.jpg');       %��ȡĿ���ļ����µ�����jpg�ļ�
% len=length(file);
% for i=1:len                     %��ÿһ��Ŀ���ļ����в���
%     old_name=file(i).name;      %��ȡĿ���ļ����ļ���
%     Img=imread(['E:\github\CNN\data\bad\' old_name]);   %��ȡ��Ӧ���ļ�
%     Img = imresize(Img,inputSize(1:2));                 %ת����С
%     delete(['E:\github\CNN\data\bad\' old_name]);       %ɾ��ԭ�ļ�
%     new_name=num2str(i,'%04d');                                %�����ת��Ϊ�ַ���Ϊ�ļ���  ����ע��һ��Ҫ��%04d����Ȼinwrite��������ͼƬ���ܻḲ�ǻ�δת����ͬ����ͼƬ
%     imwrite(Img,['E:\github\CNN\data\bad\' new_name '.jpg']);%�洢ͼƬ
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

changeSize;                %�����е�ͼƬת��Ϊ��Ҫ�Ĵ�С
digitDatasetPath = fullfile('E:','github','CNN','data');		%ָ���������·��
imds = imageDatastore(digitDatasetPath,'IncludeSubfolders',true,'LabelSource','foldernames');%����������
[imdsTrain,imdsValidation] = splitEachLabel(imds,0.1,'randomized');     %�����������70%����ѵ��������ʣ����Ϊ��������

% layersTransfer = net.Layers(1:end-3);               %����ԭ����������3�������������
% numClasses = numel(categories(imdsTrain.Labels));   %��ȡ�������
% layers = [                  %������Ĳ���ṹ
%     layersTransfer
%     fullyConnectedLayer(numClasses,'WeightLearnRateFactor',10,'BiasLearnRateFactor',10)
%     softmaxLayer
%     classificationLayer];
% 
% options = trainingOptions('sgdm', ...   %�������ѵ������
%     'MiniBatchSize',10, ...
%     'MaxEpochs',6, ...
%     'InitialLearnRate',1e-4, ...
%     'ValidationData',imdsValidation, ...
%     'ValidationFrequency',3, ...
%     'Verbose',false, ...
%     'Plots','training-progress');
% 
% netTransfer = trainNetwork(imdsTrain,layers,options);   %ѵ��������
%clear all;
load('-mat','E:\github\CNN\net\m3.mat');

% file=dir('E:\github\CNN\Validation\good\*.jpg');       %��ȡĿ���ļ����µ�����jpg�ļ�
% len=length(file);
% for i=1:len                     %��ÿһ��Ŀ���ļ����в���
%     old_name=file(i).name;      %��ȡĿ���ļ����ļ���
%     Img=imread(['E:\github\CNN\Validation\good\' old_name]);   %��ȡ��Ӧ���ļ�
%     Img = imresize(Img,inputSize(1:2));                 %ת����С
%     delete(['E:\github\CNN\data\bad\' old_name]);       %ɾ��ԭ�ļ�
%     new_name=num2str(i,'%04d');                                %�����ת��Ϊ�ַ���Ϊ�ļ���  ����ע��һ��Ҫ��%04d����Ȼinwrite��������ͼƬ���ܻḲ�ǻ�δת����ͬ����ͼƬ
%     imwrite(Img,['E:\github\CNN\data\bad\' new_name '.jpg']);%�洢ͼƬ
% end

YPred = classify(netTransfer,imdsValidation);           %�Բ�����������ʶ��
for i=1:length(YPred)
    if YPred(i) ~= imdsValidation.Labels(i)
        figure
        ko=imdsValidation.Files{i,1};
        Img=imread(ko)
        imshow(Img)
    end
end
accuracy = mean(YPred == imdsValidation.Labels)         %������ʶ�����ȷ��













