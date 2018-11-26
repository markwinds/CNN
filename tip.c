options = trainingOptions('sgdm', ...				//采用有动量的随机梯度下降算法来寻找最优解
    'InitialLearnRate',0.01, ...					//学习率是不是就是每次改变自变量的幅度，这个值越小则训练越慢
    'MaxEpochs',4, ...								//最大的迭代次数，一次迭代指完整的一次神经网络的训练
    'Shuffle','every-epoch', ...					//每次迭代训练前都自动混淆训练集和测试集
    'ValidationData',imdsValidation, ...			//指定训练用的测试集
    'ValidationFrequency',30, ...					//
    'Verbose',false, ...
    'Plots','training-progress');