function [t1,t2]=start(v1,v2,Des1,Des2,Len_Des,t)
%ͬ������Ƶ�����ͬ�������ʼ��
%����֡�����������Ѱ���������֡
count=0;%ͬ����λ��
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
%���Զ�λ
v1.CurrentTime=Des1;
if hasFrame(v1)
    FrQ=readFrame(v1);
end
gray_Q=im216grays(preblack(rgb2gray(FrQ),t));
while (norm(gray_T-gray_Q)>=100)&&hasFrame(v1)%��ֵΪ100
    v1.CurrentTime=v1.CurrentTime+1;%�ƶ�����Ϊ1
    FrQ=readFrame(v1);
    gray_Q=im216grays(preblack(rgb2gray(FrQ),t));
end
%��ȷ��λ
while (norm(gray_T-gray_Q)>=30)&&hasFrame(v1)%��ֵΪ30
    FrQ=readFrame(v1);
    gray_Q=im216grays(preblack(rgb2gray(FrQ),t));
end
vec_T=im2vec(preblack(rgb2gray(FrT),t));
mat_T=zeros(16,Len_Des);
%���ɲ�־���
for i=1:Len_Des
    FrT=readFrame(v2);
    vec_T_next=im2vec(preblack(rgb2gray(FrT),t));
    mat_T(:,i)=vec_T_next-vec_T;
    vec_T=vec_T_next;
end
vec_Q=im2vec(preblack(rgb2gray(FrQ),t));
mat_Q=zeros(16,Len_Des);
%���ɲ�־���
for i=1:Len_Des
    FrQ=readFrame(v1);
    vec_Q_next=im2vec(preblack(rgb2gray(FrQ),t));
    mat_Q(:,i)=vec_Q_next-vec_Q;
    vec_Q=vec_Q_next;
end
%��֮��18֡��ʹ��corr������ø���֮֡������ϵ��
corrs(:)=corr(mat_T(:,1),mat_Q(:,:));
[M,I]=max(corrs,[],2);
while (M(1)<0.99||I(1)==50)%0.99Ϊƥ����ֵ������ƥ����������Ѱ��
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
        disp('ƥ��ʧ��');
        exit(0);
    end
end
Sh_Fr=I(1)-1;%�õ�ƥ��֡����
t1=v1.CurrentTime-Len_Des*(count+1)/25+Sh_Fr/25;
t2=v2.CurrentTime-Len_Des/25;
end