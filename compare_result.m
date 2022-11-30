function result = compare_result(result1,result2)
result.p2point_MSE = max(result1.p2point_MSE,result2.p2point_MSE);
result.p2point_MSE_PSNR = min(result1.p2point_MSE_PSNR,result2.p2point_MSE_PSNR);
result.p2point_Hausdroff = max(result1.p2point_Hausdroff,result2.p2point_Hausdroff);
result.p2point_Hausdroff_PNSR = min(result1.p2point_Hausdroff_PNSR,result2.p2point_Hausdroff_PNSR);
result.p2plane_MSE = max(result1.p2plane_MSE,result2.p2plane_MSE);
result.p2plane_MSE_PSNR = min(result1.p2plane_MSE_PSNR,result2.p2plane_MSE_PSNR);
result.p2plane_Hausdroff = max(result1.p2plane_Hausdroff,result2.p2plane_Hausdroff);
result.p2plane_Hausdroff_PNSR = min(result1.p2plane_Hausdroff_PNSR,result2.p2plane_Hausdroff_PNSR);
result.yuv_PSNR = min(result1.yuv_PSNR,result2.yuv_PSNR);

end