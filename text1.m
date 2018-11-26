% 
% 
% 
% 
% 
% digitDatasetPath = fullfile('E:','CNN','origin_data');		%指定样本库的路径
% imds = imageDatastore(digitDatasetPath, ...
%     'IncludeSubfolders',true,'LabelSource','foldernames');	%创建�?个样本库
% 
% labelCount = countEachLabel(imds)		%显示库中�?有的样本类名�?
% 
% numTrainFiles = 750;					%指定每个类中用于训练用的个数，其余的用来做样例检测，修正参数
% [imdsTrain,imdsValidation] = splitEachLabel(imds,numTrainFiles,'randomize');%将样本库切分为训练库和校验库
% 
% 
% 
% layers = [
%     imageInputLayer([28 28 1])		%输入图像的大小和通道数，灰度图为1，rgb三色图为3
%     
%     convolution2dLayer(3,8,'Padding','same')		%3是筛选器的大小（3*3），8是筛选器的数�?
%     batchNormalizationLayer
%     reluLayer
%     
%     maxPooling2dLayer(2,'Stride',2)
%     
%     convolution2dLayer(3,16,'Padding','same')
%     batchNormalizationLayer
%     reluLayer
%     
%     maxPooling2dLayer(2,'Stride',2)
%     
%     convolution2dLayer(3,32,'Padding','same')
%     batchNormalizationLayer
%     reluLayer
%     
%     fullyConnectedLayer(10)			%2是样本中类的数量
%     softmaxLayer
%     classificationLayer];
% 
% 
% options = trainingOptions('sgdm', ...
%     'InitialLearnRate',0.01, ...
%     'MaxEpochs',4, ...
%     'Shuffle','every-epoch', ...
%     'ValidationData',imdsValidation, ...
%     'ValidationFrequency',30, ...
%     'Verbose',false, ...
%     'Plots','training-progress');
% 
% 
% net = trainNetwork(imdsTrain,layers,options);
% 
% %save('d:\forFun\zbt\aaa.mat','net');
% 
% %load('-mat','aa')
% 
% %S=imds.Files{5};
% 
% %inputSize = net.Layers(1).InputSize;
% % I = imread('E:/forFun/num.jpg');
% % I = imresize(I,inputSize(1:2));
% % I=I(:,:,1);
% % I = imread('E:/forFun/0.png');
% % [label,scores] = classify(net,I);
% % figure
% % imshow(I)
% % title(string(label) + ", ");
% 
% 
% % YPred = classify(net,imdsValidation);
% % YValidation = imdsValidation.Labels;
% % %disp(YValidation);
% % accuracy = sum(YPred == YValidation)/numel(YValidation);
% % display(accuracy);
% 
% 
% % img = readimage(imds,1);
% % size(img)
% 
% % labelCount = countEachLabel(imds)
% 
% 
% % figure;
% % perm = randperm(10000,20);
% % for i = 1:20
% %     subplot(4,5,i);
% %     imshow(imds.Files{perm(i)});
% % end
% 
% 
% 





rata=[1e-6,5e-6,1e-5,3e-5,5e-5,8e-5,1e-4,5e-4,1e-3,5e-3];
% ans1=zeros(length(rata));
% ans2=zeros(length(rata));
% ans3=zeros(length(rata));

for j=1:length(rata)
    fid = fopen('./dataTable.txt','a');
    fprintf(fid,'%f ',trainNet('data','temp',[227 227 3],3,rata(j))); 
    fclose(fid);
    clearvars -except j rata
end

fid = fopen('./dataTable.txt','a');
fprintf(fid,'\r\n');  
fclose(fid);

for j=1:length(rata)
    fid = fopen('./dataTable.txt','a');
    fprintf(fid,'%f ',trainNet('data','temp',[227 227 3],2,rata(j))); 
    fclose(fid);
    clearvars -except j rata
end

fid = fopen('./dataTable.txt','a');
fprintf(fid,'\r\n');  
fclose(fid);

for j=1:length(rata)
    fid = fopen('./dataTable.txt','a');
    fprintf(fid,'%f ',trainNet('data','temp',[227 227 3],1,rata(j))); 
    fclose(fid);
    clearvars -except j rata
end


% semilogx(rata,ans1);
% hold on;
% semilogx(rata,ans2);
% hold on;
% semilogx(rata,ans3);
% hold on;
% xlabel('ѧϰ��');
% ylabel('��ȷ��');
% title('��ȷ����ѧϰ�ʵĶ�����ϵͼ');
% hold off




% fid = fopen('./dataTable.txt','a');
% fprintf(fid,'%d ',34); 
% fprintf(fid,'\r\n%d',93);  
% fclose(fid);
% clearvars -except fid












