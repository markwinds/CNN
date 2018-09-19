function f = changeSize()
%将指定文件夹下的图片转化为训练网络需要的大小


inputSize=[227 227 3];          %目标图像矩阵的大小

file=dir('E:\github\CNN\data\bad\*.jpg');       %读取目标文件夹下的所有jpg文件
len=length(file);
for i=1:len                     %对每一个目标文件进行操作
    old_name=file(i).name;      %获取目标文件的文件名
    Img=imread(['E:\github\CNN\data\bad\' old_name]);   %读取对应的文件
    Img = imresize(Img,inputSize(1:2));                 %转化大小
    delete(['E:\github\CNN\data\bad\' old_name]);       %删除原文件
    new_name=num2str(i,'%04d');                                %将标号转化为字符作为文件名  这里注意一定要加%04d，不然inwrite产生的新图片可能会覆盖还未转化的同名的图片
    imwrite(Img,['E:\github\CNN\data\bad\' new_name '.jpg']);%存储图片
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

