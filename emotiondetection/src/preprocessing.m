% %Preprocessing of the single image
clear all;
for k=1:1
phase1_img_path=sprintf('G:\\fyproject\\test_images_input\\test_img2.jpg',k);
phase1_img=imread(phase1_img_path);
phase1_img_path_detector = vision.CascadeObjectDetector;
phase1_img_bboxes = step(phase1_img_path_detector, phase1_img);
IFaces = insertObjectAnnotation(phase1_img, 'rectangle', phase1_img_bboxes, 'Face');
imshow(phase1_img);
phase1_img_subimage=imcrop(phase1_img,phase1_img_bboxes);
phase1_path_crop=sprintf('G:\\fyproject\\test_images_output\\test_img2',k);
phase1_figure=figure,imshow(phase1_img_subimage);
options.Format = 'tiff';
hgexport(phase1_figure,phase1_path_crop,options);
end
% %Multiple images preprocessing
% clear all;
% for k=1:1
% phase1_img_path=sprintf('G:\\fyproject\\jaffeimages\\jaffe\\%d.tiff',k);
% phase1_img=imread(phase1_img_path);
% phase1_img_path_detector = vision.CascadeObjectDetector;
% phase1_img_bboxes = step(phase1_img_path_detector, phase1_img);
% %IFaces = insertObjectAnnotation(phase1_img, 'rectangle', phase1_img_bboxes, 'Face');
% phase1_img_subimage=imcrop(phase1_img,phase1_img_bboxes);
% phase1_path_crop=sprintf('G:\\fyproject\\jaffeimages\\jaffe\\%d.tiff',k);
% phase1_figure=figure,imshow(phase1_img_subimage);
% options.Format = 'tiff';
% hgexport(phase1_figure,phase1_path_crop,options);
% end

% saveas(h,path_crop);
% image2=imread('G:\fyproject\jaffeimages\jaffecrop\1.tiff');
% for i=1:size(temp,1)
%     for j=1:size(temp,2)
%         if(temp(i,j)~=255)
%              new_image(k,l)=temp(i,j);
%              l=l+1;
%         end 
%     end
%     k=k+1;
% end
% imshow(uint8(new_image));
           

% imshow(image3);
%  end
