function Num=FaceDetector(image)
%����ͼƬ
%���ͼƬ�е�����
faceDetector=vision.CascadeObjectDetector;
bboxes=step(faceDetector,image);
%I=insertObjectAnnotation(image,'rectangle',bboxes,'Face');
%figure,imshow(I),title('Detected Face');
[Num,~]=size(bboxes);
end