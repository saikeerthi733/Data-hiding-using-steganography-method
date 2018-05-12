function [PSNR MSE] = psnrmse(Image1,Image2)
x = double(Image1);
y = double(Image2);
[r c p] = size(x);
MSE = (sum(sum((x - y) .^ 2)))/(r*c*p);
PSNR = 10*log10((255*255)/MSE);
 if p==3
     PSNR = sum(PSNR);
     MSE = sum(MSE);
 end