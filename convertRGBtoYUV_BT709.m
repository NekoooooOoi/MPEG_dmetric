function YUV = convertRGBtoYUV_BT709(RGB)
trans = [0.2126,-0.1146,0.5;0.7152,-0.3854,-0.4542;0.0722,0.5000,-0.0458];
YUV = RGB * trans/255;
YUV = [YUV(:,1),YUV(:,2)+0.5,YUV(:,3)+0.5];
end