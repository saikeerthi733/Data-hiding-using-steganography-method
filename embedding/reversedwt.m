function rima=reversedwt(a,h,v,d);
f2llow=a;
f2lhigh=h;
f2hlow=v;
f2hhigh=d;
% [f2llow,f2lhigh,f2hlow,f2hhigh]=split(imgdata);
[ rlen2r rlen2c  ]=size(f2llow);

len12r=rlen2r;
len12c=rlen2c;

    for j = 1:1:len12r;
        for k =1:1:len12c;
           rf2ll(j,k)=f2llow(j,k)-round(f2lhigh(j,k)/2);
           rf2lh(j,k)=rf2ll(j,k)+f2lhigh(j,k);
           rf2hl(j,k)=f2hlow(j,k)-round(f2hhigh(j,k)/2);
           rf2hh(j,k)=f2hhigh(j,k)+rf2hl(j,k);
        end
   end
   
   
   disp(rf2ll);
   disp(rf2lh);
   disp(rf2hl);
   disp(rf2hh);
   
   
%1d reconstruction
[ rlen1r rlen1c  ]=size(rf2ll);
rlen2r=rlen2r+rlen2r;
 %even separation
   k=1;
   for j= 2:2:rlen2r;
      rl(j,:)=rf2ll(k,:);
      rh(j,:)=rf2hl(k,:);
      k=k+1;
   end
   %end
 %odd separation
   k=1;
   for j= 1:2:rlen2r;
      rl(j,:)=rf2lh(k,:);
      rh(j,:)=rf2hh(k,:);
      k=k+1;
   end
[ rlenr rlenc  ]=size(rl);
%1d 
   for j= 1:1:rlenr;
      for k = 1:1:rlenc;
         r(j,k)=rl(j,k)-round(rh(j,k)/2);
         h(j,k)=r(j,k)+rh(j,k);
      end
   end
%1d interpolation
[ rlr rlc ]=size(r);
rlc=rlc+rlc;
   for j = 1:1:rlr;
        a=1;
      for k=2:2:rlc;
         rima(j,k)=r(j,a);
         a=a+1;
      end
   end
   for j = 1:1:rlr;
        a=1;
      for k=1:2:rlc;
         rima(j,k)=h(j,a);
         a=a+1;     
      end
   end
return

