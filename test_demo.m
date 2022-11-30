clear all
pcA = pcread('bag.ply');
pcB = pcread('bag_gQP_2_tQP_3.ply');
resolution = 2047;
result = mpeg_pcc_metrics(pcA,pcB,resolution);
% pcA reference pcB distorted
% pcA has to contain normals