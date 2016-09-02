clear;clc;
%主程序
%%
%常量定义
Des1=60;%认为筛选掉无用画面，根据视频实际情况进行修改
Des2=10;%同步起始点，单位为s，可根据实际定位情况修正，建议值为10~视频长度-20之间
Len_Des=50;%同步帧数，帧数越多，同步越准确，但时间复杂度越高，建议不超过100
t=10;%去黑边时的阈值，建议为8~20
%%
%读入视频
% 常规属性:
%             Name: '1.mp4'
%             Path: 'D:\实习'
%         Duration: 3.6035e+03
%      CurrentTime: 0
%              Tag: ''
%         UserData: []
% 
%    视频属性:
%            Width: 768
%           Height: 576
%        FrameRate: 24.9976
%     BitsPerPixel: 24
%      VideoFormat: 'RGB24'
%     常规属性:
%             Name: '2.mp4'
%             Path: 'D:\实习'
%         Duration: 3.2278e+03
%      CurrentTime: 0
%              Tag: ''
%         UserData: []
% 
%    视频属性:
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
%视频同步
[t1,t2]=start(v1,v2,Des1,Des2,Len_Des,t);
start1=t1-Des2;
start2=t2-Des2;
v1.CurrentTime=start1;
v2.CurrentTime=start2;
%%
%开始进行比对
out=comp2(v1,v2);
%%
%结果整理与输出
SH=zeros(2,1);
for i=1:size(out')
    if out(1,i)
        SH=[SH,[round((i-1)*2+start1);round((i-1)*2+start2)]];
    end
end
save('SH.mat','SH');