function f = changeSize()
%��ָ���ļ����µ�ͼƬת��Ϊѵ��������Ҫ�Ĵ�С


inputSize=[227 227 3];          %Ŀ��ͼ�����Ĵ�С

file=dir('E:\github\CNN\data\bad\*.jpg');       %��ȡĿ���ļ����µ�����jpg�ļ�
len=length(file);
for i=1:len                     %��ÿһ��Ŀ���ļ����в���
    old_name=file(i).name;      %��ȡĿ���ļ����ļ���
    Img=imread(['E:\github\CNN\data\bad\' old_name]);   %��ȡ��Ӧ���ļ�
    Img = imresize(Img,inputSize(1:2));                 %ת����С
    delete(['E:\github\CNN\data\bad\' old_name]);       %ɾ��ԭ�ļ�
    new_name=num2str(i,'%04d');                                %�����ת��Ϊ�ַ���Ϊ�ļ���  ����ע��һ��Ҫ��%04d����Ȼinwrite��������ͼƬ���ܻḲ�ǻ�δת����ͬ����ͼƬ
    imwrite(Img,['E:\github\CNN\data\bad\' new_name '.jpg']);%�洢ͼƬ
end

file=dir('E:\github\CNN\data\good\*.jpg');
len=length(file);
for i=1:1:len
    old_name=file(i).name;
    Img=imread(['E:\github\CNN\data\good\' old_name]);
    Img = imresize(Img,inputSize(1:2));
    delete(['E:\github\CNN\data\good\' old_name]);
    new_name=num2str(i,'%04d');
    imwrite(Img,['E:\github\CNN\data\good\' new_name '.jpg']);
end


end

