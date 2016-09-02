function out=comp2(v1,v2)
i=1;%¼ÆÊýÆ÷
%out=zeros(1,ceil(v2.Duration/4));
t1=v1.CurrentTime;
t2=v2.CurrentTime;
while (t1<=v1.Duration&&t2<=v2.Duration)
    out(i)=0;
    v1.CurrentTime=t1;
    v2.CurrentTime=t2;
    Fr2=readFrame(v2);
    if(t1>1)&&(t2>1)&&(FaceDetector(Fr2)>1)
        t3=t1-1;
        t4=t2-1;
        v1.CurrentTime=t3;
        v2.CurrentTime=t4;
        for j=1:10
            Fr1=readFrame(v1);
            Fr2=readFrame(v2);
            if(com_gray(Fr1,Fr2)==1)
                figure;imshow(Fr1);
                figure;imshow(Fr2);
                out(i)=1;
                break;
            end
            t3=t3+0.2;
            t4=t4+0.2;
            v1.CurrentTime=t3;
            v2.CurrentTime=t4;
        end
    end
    t1=t1+2;
    t2=t2+2;
    i=i+1;
end
end