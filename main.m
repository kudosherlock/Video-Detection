clear;clc;
%������
%%
%��������
Des1=60;%��Ϊɸѡ�����û��棬������Ƶʵ����������޸�
Des2=10;%ͬ����ʼ�㣬��λΪs���ɸ���ʵ�ʶ�λ�������������ֵΪ10~��Ƶ����-20֮��
Len_Des=50;%ͬ��֡����֡��Խ�࣬ͬ��Խ׼ȷ����ʱ�临�Ӷ�Խ�ߣ����鲻����100
t=10;%ȥ�ڱ�ʱ����ֵ������Ϊ8~20
%%
%������Ƶ
% ��������:
%             Name: '1.mp4'
%             Path: 'D:\ʵϰ'
%         Duration: 3.6035e+03
%      CurrentTime: 0
%              Tag: ''
%         UserData: []
% 
%    ��Ƶ����:
%            Width: 768
%           Height: 576
%        FrameRate: 24.9976
%     BitsPerPixel: 24
%      VideoFormat: 'RGB24'
%     ��������:
%             Name: '2.mp4'
%             Path: 'D:\ʵϰ'
%         Duration: 3.2278e+03
%      CurrentTime: 0
%              Tag: ''
%         UserData: []
% 
%    ��Ƶ����:
%            Width: 768
%           Height: 576
%        FrameRate: 25
%     BitsPerPixel: 24
%      VideoFormat: 'RGB24'
v1=VideoReader('3.mp4');%query video
v2=VideoReader('6.mp4');%target video
% if(v1.Duration<v2.Duration)%get the shorter one as target
%     v0=v1;
%     v1=v2;
%     v2=v0;
% end
%%
%��Ƶͬ��
[t1,t2]=start(v1,v2,Des1,Des2,Len_Des,t);
start1=t1-Des2;
start2=t2-Des2;
v1.CurrentTime=start1;
v2.CurrentTime=start2;
%%
%��ʼ���бȶ�
out=comp2(v1,v2);
%%
%������������
SH=zeros(2,1);
for i=1:size(out')
    if out(1,i)
        SH=[SH,[round((i-1)*2+start1);round((i-1)*2+start2)]];
    end
end
save('SH.mat','SH');