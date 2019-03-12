%load('-mat',['E:\github\CNN\net\' 'm4_100' '.mat']);
picRoad='.\data\bad\0004.jpg';

Imgs=imread(picRoad);
class = classify(netTransfer,Imgs);
if class=='good'
    outdata='good';
else
    outdata='bad';
end

obj = serial('com5','BaudRate',115200); %第一个是串口号，后面是波特率
fclose(instrfind);  %清空前置状态
fopen(obj); %打开串口
A = outdata; %要发送的ascall码值矩阵
fwrite(obj,A); %把A写过去
% str = fscanf(obj);      %从串口obj读取字符或字符串(ASCII码)形式数据，以字符数组形式存于str
% fclose(obj);            % 关闭串口
% delete(obj);           % 释放串口对象占用的内存空间,
% clear obj;              % 释放串口对象在Matlab工作区中占用的存储空间


