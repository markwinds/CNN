function f = changeSize(inputArg1,inputArg2)
%功能:    将指定文件夹下的图片转化为训练网络需要的大小
%输入参数:  inputArg1： 需要转化的文件夹。默认参数（即默认文件夹）为工程文件下的data文件夹
%           inputArg2: 目标矩阵的大小。默认值为 [227 227 3]
%举例： changeSize('temp',[400 400 3]) 将工程文件下的temp文件夹下的jpg进行大小转换
%补充： 1.如果只输入一个参数，那么默认输入的是文件夹参数，如果要指定目标矩阵的大小则必须输入两个参数
%      2.一定要在工程文件夹下调用此函数 (  https://blog.csdn.net/vansy666/article/details/53200009  )

if nargin==0        %如果两个参数都缺失
    inputArg1='data';
    inputArg2=[227 227 3];
elseif nargin==1    %只有一个参数缺失
    inputArg2=[227 227 3];
end
    
dirsBad=['.\' inputArg1 '\bad\'];   %生成目标路径
dirsGood=['.\' inputArg1 '\good\'];
inputSize=inputArg2;          %目标图像矩阵的大小

file=dir([dirsBad '*.jpg']);       %读取目标文件夹下的所有jpg文件
len=length(file);
for i=1:len                     %对每一个目标文件进行操作
    old_name=file(i).name;      %获取目标文件的文件名
    Img=imread([dirsBad old_name]);   %读取对应的文件
    Img = imresize(Img,inputSize(1:2));                 %转化大小
    delete([dirsBad old_name]);       %删除原文件
    new_name=num2str(i,'%04d');       %将标号转化为字符作为文件名  这里注意一定要加%04d，不然inwrite产生的新图片可能会覆盖还未转化的同名的图片
    imwrite(Img,[dirsBad new_name '.jpg']);%存储图片
end

file=dir([dirsGood '*.jpg']);       %读取目标文件夹下的所有jpg文件
len=length(file);
for i=1:len                     %对每一个目标文件进行操作
    old_name=file(i).name;      %获取目标文件的文件名
    Img=imread([dirsGood old_name]);   %读取对应的文件
    Img = imresize(Img,inputSize(1:2));                 %转化大小
    delete([dirsGood old_name]);       %删除原文件
    new_name=num2str(i,'%04d');       %将标号转化为字符作为文件名  这里注意一定要加%04d，不然inwrite产生的新图片可能会覆盖还未转化的同名的图片
    imwrite(Img,[dirsGood new_name '.jpg']);%存储图片
end


end

