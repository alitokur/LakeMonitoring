uiwait(msgbox('Select a ROI'));
[filename, pathname]= uigetfile({'*.jpg;*.png;*.tif;*.jp2'},'Select The TCI Image');
path=fullfile(pathname, filename);
im=imread(path);
disp('congratulations! Water Extraction Process in Running');
imshow(im);
r1 = drawrectangle('Label','Double Click to Select','Color',[1 0 0],'Selected',true);
pos = customWait(r1);