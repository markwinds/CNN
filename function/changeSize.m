function f = changeSize(inputArg1,inputArg2)
%����:    ��ָ���ļ����µ�ͼƬת��Ϊѵ��������Ҫ�Ĵ�С
%�������:  inputArg1�� ��Ҫת�����ļ��С�Ĭ�ϲ�������Ĭ���ļ��У�Ϊ�����ļ��µ�data�ļ���
%           inputArg2: Ŀ�����Ĵ�С��Ĭ��ֵΪ [227 227 3]
%������ changeSize('temp',[400 400 3]) �������ļ��µ�temp�ļ����µ�jpg���д�Сת��
%���䣺 1.���ֻ����һ����������ôĬ����������ļ��в��������Ҫָ��Ŀ�����Ĵ�С�����������������
%      2.һ��Ҫ�ڹ����ļ����µ��ô˺��� (  https://blog.csdn.net/vansy666/article/details/53200009  )

if nargin==0        %�������������ȱʧ
    inputArg1='data';
    inputArg2=[227 227 3];
elseif nargin==1    %ֻ��һ������ȱʧ
    inputArg2=[227 227 3];
end
    
dirsBad=['.\' inputArg1 '\bad\'];   %����Ŀ��·��
dirsGood=['.\' inputArg1 '\good\'];
inputSize=inputArg2;          %Ŀ��ͼ�����Ĵ�С

file=dir([dirsBad '*.jpg']);       %��ȡĿ���ļ����µ�����jpg�ļ�
len=length(file);
for i=1:len                     %��ÿһ��Ŀ���ļ����в���
    old_name=file(i).name;      %��ȡĿ���ļ����ļ���
    Img=imread([dirsBad old_name]);   %��ȡ��Ӧ���ļ�
    Img = imresize(Img,inputSize(1:2));                 %ת����С
    delete([dirsBad old_name]);       %ɾ��ԭ�ļ�
    new_name=num2str(i,'%04d');       %�����ת��Ϊ�ַ���Ϊ�ļ���  ����ע��һ��Ҫ��%04d����Ȼinwrite��������ͼƬ���ܻḲ�ǻ�δת����ͬ����ͼƬ
    imwrite(Img,[dirsBad new_name '.jpg']);%�洢ͼƬ
end

file=dir([dirsGood '*.jpg']);       %��ȡĿ���ļ����µ�����jpg�ļ�
len=length(file);
for i=1:len                     %��ÿһ��Ŀ���ļ����в���
    old_name=file(i).name;      %��ȡĿ���ļ����ļ���
    Img=imread([dirsGood old_name]);   %��ȡ��Ӧ���ļ�
    Img = imresize(Img,inputSize(1:2));                 %ת����С
    delete([dirsGood old_name]);       %ɾ��ԭ�ļ�
    new_name=num2str(i,'%04d');       %�����ת��Ϊ�ַ���Ϊ�ļ���  ����ע��һ��Ҫ��%04d����Ȼinwrite��������ͼƬ���ܻḲ�ǻ�δת����ͬ����ͼƬ
    imwrite(Img,[dirsGood new_name '.jpg']);%�洢ͼƬ
end


end

