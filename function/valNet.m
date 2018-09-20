function  f= valNet(inputArg1)
%��ȡValidation�ļ����µ�ͼƬ����ѵ���õ�����ʶ������жϴ���ͼ��
%������ inputArg1�����������
changeSize('Validation');       %���ļ����µ�ͼ��ת��Ϊ��Ҫ�Ĵ�С
digitDatasetPath = fullfile('E:','github','CNN','Validation');		%ָ���������·��
imds = imageDatastore(digitDatasetPath,'IncludeSubfolders',true,'LabelSource','foldernames');%����������
load('-mat',['E:\github\CNN\net\' inputArg1 '.mat']);

YPred = classify(netTransfer,imds);           %�Բ�����������ʶ��
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
accuracy = mean(YPred == imds.Labels)         %������ʶ�����ȷ��

end

