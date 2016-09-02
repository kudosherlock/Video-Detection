function out=preblack(in,t)
%预处理图片，去除黑边，t为阈值,注意输入图片应为灰度值
x1=1;
y1=1;
[x2,y2]=size(in);
a1=round(x2/2);
b1=round(y2/2);
while(in(a1,y1)<t)&&(y1<=b1)
    y1=y1+1;
end
while(in(a1,y2)<t)&&(y2>=b1)
    y2=y2-1;
end
while(in(x1,b1)<t)&&(x1<=a1)
    x1=x1+1;
end
while(in(x2,b1)<t)&&(x2>=a1)
    x2=x2-1;
end
out=in(x1:x2,y1:y2);
%figure;
%imshow(out);
end


