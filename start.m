function [t1,t2]=start(v1,v2,Des1,Des2,Len_Des,t)
%同步两视频，输出同步后的起始点
%若该帧有人像，则向后寻找无人像的帧
count=0;%同步移位数
t1=0;
t2=0;
v2.CurrentTime=Des2;
if hasFrame(v2)
    FrT=readFrame(v2);
end
while hasFrame(v2)&&(FaceDetector(FrT)>0)
    v2.CurrentTime=Des2+1;
    if hasFrame(v2)
        FrT=readFrame(v2);
    end
end
gray_T=im216grays(preblack(rgb2gray(FrT),t));
%粗略定位
v1.CurrentTime=Des1;
if hasFrame(v1)
    FrQ=readFrame(v1);
end
gray_Q=im216grays(preblack(rgb2gray(FrQ),t));
while (norm(gray_T-gray_Q)>=100)&&hasFrame(v1)%阈值为100
    v1.CurrentTime=v1.CurrentTime+1;%移动步长为1
    FrQ=readFrame(v1);
    gray_Q=im216grays(preblack(rgb2gray(FrQ),t));
end
%精确定位
while (norm(gray_T-gray_Q)>=30)&&hasFrame(v1)%阈值为30
    FrQ=readFrame(v1);
    gray_Q=im216grays(preblack(rgb2gray(FrQ),t));
end
vec_T=im2vec(preblack(rgb2gray(FrT),t));
mat_T=zeros(16,Len_Des);
%生成差分矩阵
for i=1:Len_Des
    FrT=readFrame(v2);
    vec_T_next=im2vec(preblack(rgb2gray(FrT),t));
    mat_T(:,i)=vec_T_next-vec_T;
    vec_T=vec_T_next;
end
vec_Q=im2vec(preblack(rgb2gray(FrQ),t));
mat_Q=zeros(16,Len_Des);
%生成差分矩阵
for i=1:Len_Des
    FrQ=readFrame(v1);
    vec_Q_next=im2vec(preblack(rgb2gray(FrQ),t));
    mat_Q(:,i)=vec_Q_next-vec_Q;
    vec_Q=vec_Q_next;
end
%总之差18帧，使用corr函数求得各个帧之间的相关系数
corrs(:)=corr(mat_T(:,1),mat_Q(:,:));
[M,I]=max(corrs,[],2);
while (M(1)<0.99||I(1)==50)%0.99为匹配阈值，若不匹配则继续向后寻找
    if hasFrame(v1)
        count=count+1;
        for i=1:Len_Des
            FrQ=readFrame(v1);
            vec_Q_next=im2vec(preblack(rgb2gray(FrQ),t));
            mat_Q(:,i)=vec_Q_next-vec_Q;
            vec_Q=vec_Q_next;
        end
        corrs(:,:)=corr(mat_T(:,:),mat_Q(:,:));
        [M,I]=max(corrs,[],2);
    else
        disp('匹配失败');
        exit(0);
    end
end
Sh_Fr=I(1)-1;%得到匹配帧数差
t1=v1.CurrentTime-Len_Des*(count+1)/25+Sh_Fr/25;
t2=v2.CurrentTime-Len_Des/25;
end