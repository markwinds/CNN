function f = initSys(inputArg1)
%初始化函数，载入想要的网络

if nargin==0
    inputArg1='m4_100';
end
load('-mat',['E:\github\CNN\net\' inputArg1 '.mat']);

end

