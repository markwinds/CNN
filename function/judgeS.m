function f = judgeS(inputArg1)
%载入图片并判别好坏，将数据传给单片机。好 49 坏 48
%参数： inputArg1：要识别图片所在的路径

Imgs=imread(inputArg1);
class = classify(netTransfer,Imgs);
if class=='good'
    outdata=1;
else
    outdata=0;
end

obj = serial('com4','BaudRate',115200); %第一个是串口号，后面是波特率
fclose(instrfind);  %清空前置状态
fopen(obj); %打开串口
A = outdata; %要发送的ascall码值矩阵
fwrite(obj,A); %把A写过去
% str = fscanf(obj);      %从串口obj读取字符或字符串(ASCII码)形式数据，以字符数组形式存于str
fclose(obj);            % 关闭串口
delete(obj);           % 释放串口对象占用的内存空间,
clear obj;              % 释放串口对象在Matlab工作区中占用的存储空间

end

