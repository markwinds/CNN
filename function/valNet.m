function  f= valNet(inputArg1)
%读取Validation文件夹下的图片，用训练好的网络识别，输出判断错误图像
%参数： inputArg1：载入的网络
changeSize('Validation');       %将文件夹下的图像转化为需要的大小
digitDatasetPath = fullfile('E:','github','CNN','Validation');		%指定样本库的路径
imds = imageDatastore(digitDatasetPath,'IncludeSubfolders',true,'LabelSource','foldernames');%建立样本库
load('-mat',['E:\github\CNN\net\' inputArg1 '.mat']);

YPred = classify(netTransfer,imds);           %对测试样例进行识别
for i=1:length(YPred)
    if YPred(i) ~= imds.Labels(i)
        figure
        Img=imread(imds.Files{i,1});
        imshow(Img);
        titleRoad=imds.Files{i,1};
        location1=strfind(titleRoad,'.jpg');
        location2=strfind(titleRoad,'Validation');
        titleRoad1=titleRoad(location2+11:location1-5);
        titleRoad2=titleRoad(location1-4:end);
        title(['Picture ' titleRoad1 '\' titleRoad2 ' is wrong!!']);
    end
end
accuracy = mean(YPred == imds.Labels)         %输出最后识别的正确率

end

