function flag=com_LBP(image1,image2)
flag=0;
A1=rgb2gray(image1);
A2=rgb2gray(image2);
% B1=rgb2gray(imread('Data\LFW3D.0.1.1\Zhang_Ziyi\Zhang_Ziyi_0001.jpg'));
%将图片进行LBP特征提取
lbpA1=extractLBPFeatures(A1);
lbpA2=extractLBPFeatures(A2);
%lbpB1=extractLBPFeatures(B1);
%计算图片之间的特征空间距离
dA1A2=norm(lbpA1-lbpA2);
if(dA1A2>0.015)
    flag=1;
end
end