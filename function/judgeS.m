function f = judgeS(inputArg1)
%����ͼƬ���б�û��������ݴ�����Ƭ������ 49 �� 48
%������ inputArg1��Ҫʶ��ͼƬ���ڵ�·��

Imgs=imread(inputArg1);
class = classify(netTransfer,Imgs);
if class=='good'
    outdata=1;
else
    outdata=0;
end

obj = serial('com4','BaudRate',115200); %��һ���Ǵ��ںţ������ǲ�����
fclose(instrfind);  %���ǰ��״̬
fopen(obj); %�򿪴���
A = outdata; %Ҫ���͵�ascall��ֵ����
fwrite(obj,A); %��Aд��ȥ
% str = fscanf(obj);      %�Ӵ���obj��ȡ�ַ����ַ���(ASCII��)��ʽ���ݣ����ַ�������ʽ����str
fclose(obj);            % �رմ���
delete(obj);           % �ͷŴ��ڶ���ռ�õ��ڴ�ռ�,
clear obj;              % �ͷŴ��ڶ�����Matlab��������ռ�õĴ洢�ռ�

end

