function [temp]=forward_lift(fim1)
% if level==1
%     temp=fim1;
%     return;
% end 
[ r c ] = size(fim1);
even=zeros(r,(c/2));
%first level decomposition
%one even dimension
      for j = 1:1:r
        a=2;
        for k =1:1:(c/2)
            even(j,k)=fim1(j,a);
            a=a+2;
        end
    end
 %one odd dim
odd=zeros(r,(c/2));
   for j = 1:1:r
        a=1;
        for k =1:1:(c/2)
            odd(j,k)=fim1(j,a);
            a=a+2;
        end
    end
[ lenr lenc  ]=size(odd) ;
%one dim lifting 
     for j = 1:1:lenr
       for k =1:1:lenc
          fhigh(j,k)=odd(j,k)-even(j,k);
          flow(j,k)=even(j,k)+round(fhigh(j,k)/2);
      end
    end
%2nd dimension
[len2r len2c ]=size(flow);
        for j = 1:1:(len2c)
        a=2;
        for k =1:1:(len2r/2)
           %even separation of one dim 
           leven(k,j)=flow(a,j);
           heven(k,j)=fhigh(a,j);
            a=a+2;
        end
    end
%odd separtion of one dim 
      for j = 1:1:(len2c)
        a=1;
        for k =1:1:(len2r/2)
           lodd(k,j)=flow(a,j);
           hodd(k,j)=fhigh(a,j);
            a=a+2;
        end
    end
 %2d haar
[ len12r len12c  ]=size(lodd) ;
     for j = 1:1:len12r
        for k =1:1:len12c
           %2nd level lh 
           f2lhigh(j,k)=lodd(j,k)-leven(j,k);
           %2nd level ll
           f2llow(j,k)=leven(j,k)+round(f2lhigh(j,k)/2);
           %2nd level hh
           f2hhigh(j,k)=hodd(j,k)-heven(j,k);
           %2nd level hl
          f2hlow(j,k)=heven(j,k)+round(f2hhigh(j,k)/2);
      end
    end
% level=level-1;
temp=[f2llow f2lhigh;f2hlow f2hhigh];
return;