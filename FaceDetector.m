function Num=FaceDetector(image)
%输入图片
%输出图片中的脸数
faceDetector=vision.CascadeObjectDetector;
bboxes=step(faceDetector,image);
%I=insertObjectAnnotation(image,'rectangle',bboxes,'Face');
%figure,imshow(I),title('Detected Face');
[Num,~]=size(bboxes);
end