%load('-mat',['E:\github\CNN\net\' 'm4_100' '.mat']);
%changeSize;
picRoad='.\data\bad\0097.jpg';

Imgs=imread(picRoad);
class = classify(netTransfer,Imgs)
% if class=='good'
%     outdata='good';
% else
%     outdata='bad';
% end
% 
% obj = serial('com5','BaudRate',115200); %��һ���Ǵ��ںţ������ǲ�����
% fclose(instrfind);  %���ǰ��״̬
% fopen(obj); %�򿪴���
% A = outdata; %Ҫ���͵�ascall��ֵ����
% fwrite(obj,A); %��Aд��ȥ
% % str = fscanf(obj);      %�Ӵ���obj��ȡ�ַ����ַ���(ASCII��)��ʽ���ݣ����ַ�������ʽ����str
% fclose(obj);            % �رմ���
% delete(obj);           % �ͷŴ��ڶ���ռ�õ��ڴ�ռ�,
% clear obj;              % �ͷŴ��ڶ�����Matlab��������ռ�õĴ洢�ռ�


