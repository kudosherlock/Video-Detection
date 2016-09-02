function out=im216grays(in)
%输入灰度矩阵，输出16平均灰度
[x,y]=size(in);
out=zeros(4,4);
x2=floor(x/2);
x1=floor(x2/2);
x3=x2+floor((x-x2)/2);
y2=floor(y/2);
y1=floor(y2/2);
y3=y2+floor((y-y2)/2);
z=mat2cell(in,[x1,x2-x1,x3-x2,x-x3],[y1,y2-y1,y3-y2,y-y3]);
for i=1:4
    for j=1:4
        out(i,j)=mean2(z{i,j});
    end
end
out=out-mean2(out);
end