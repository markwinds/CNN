
% net = alexnet;

changeSize;                %将库中的图片转化为需要的大小
digitDatasetPath = fullfile('E:','github','CNN','data');		%指定样本库的路径
imds = imageDatastore(digitDatasetPath,'IncludeSubfolders',true,'LabelSource','foldernames');%建立样本库
%[imdsTrain,imdsValidation] = splitEachLabel(imds,0.1,'randomized');     %随机将样本库70%归入训练用例，剩余作为测试用例

%clear all;
load('-mat','E:\github\CNN\net\m3.mat');

% Img=imread('E:\github\CNN\data\good\0004.jpg');
% class=classify(netTransfer,Img);
% class


YPred = classify(netTransfer,imds);           %对测试样例进行识别
for i=1:length(YPred)
    if YPred(i) ~= imds.Labels(i)
        figure
        Img=imread(imds.Files{i,1});
        imshow(Img);
        titleRoad=imds.Files{i,1};
        location1=strfind(titleRoad,'.jpg');
        location2=strfind(titleRoad,'data');
        titleRoad1=titleRoad(location2+5:location1-5);
        titleRoad2=titleRoad(location1-4:end);
        title(['Picture ' titleRoad1 '\' titleRoad2 ' is wrong!!']);
    end
end
accuracy = mean(YPred == imds.Labels)         %输出最后识别的正确率













