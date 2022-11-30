function result = findMetric(pcA,pcB,pcB_nor,pPSNR)
% pcA = pcread('bag.ply');
% pcB = pcread('bag_gQP_2_tQP_3.ply');
% pPSNR = 2048;
% pcB_nor = scaleNormals(pcA,pcB);

pcA_cor = pcA.Location;
pcA_col = pcA.Color;
pcA_col = double(pcA_col);
pcA_col = convertRGBtoYUV_BT709(pcA_col);
pcB_cor = pcB.Location;
pcB_col = pcB.Color;
pcB_col = double(pcB_col);

p2point_distance = zeros(pcA.Count,1); 
p2plane_distance = zeros(pcA.Count,1);
weighted_color = zeros(pcA.Count,3);
%p2point/p2plane/YUV
[idx,idt] = knnsearch(pcB_cor,pcA_cor,'K',10); 
err_vector = single(zeros(pcA.Count,3));
for i = 1:pcA.Count
    j = idx(i,1);
    err_vector(i,:) = pcA_cor(i,:) - pcB_cor(j,:);
    p2point_distance(i) = err_vector(i,:) * err_vector(i,:)'; 
    disproJ = err_vector(i,:) * pcB_nor(j,:)';
    p2plane_distance(i) = disproJ * disproJ;
    %average color
    lable = find(idt(i,:)==idt(i,1));
    lable = idx(i,lable);
    [~,colums] = size(lable);
    if (colums==1)
        weighted_color(i,:) = pcB_col(lable,:);
    else
        weighted_color(i,:) = mean(pcB_col(lable,:));
    end
    
    
end
weighted_color = convertRGBtoYUV_BT709(weighted_color);
YUV_distance = pcA_col - weighted_color;
YUV_distance = YUV_distance.^2;

YUV = mean(YUV_distance);
Y_PSNR = getPSNR(1,YUV(1),1);
U_PSNR = getPSNR(1,YUV(2),1);
V_PSNR = getPSNR(1,YUV(3),1);
result.p2point_MSE = mean(p2point_distance);
result.p2point_MSE_PSNR = getPSNR(pPSNR,result.p2point_MSE,3);
result.p2point_Hausdroff = max(p2point_distance);
result.p2point_Hausdroff_PNSR = getPSNR(pPSNR,result.p2point_Hausdroff,3);
result.p2plane_MSE = mean(p2plane_distance);
result.p2plane_MSE_PSNR = getPSNR(pPSNR,result.p2plane_MSE,3);
result.p2plane_Hausdroff = max(p2plane_distance);
result.p2plane_Hausdroff_PNSR = getPSNR(pPSNR,result.p2plane_Hausdroff,3);
result.yuv_PSNR = (6*Y_PSNR+U_PSNR+V_PSNR)/8;
end

