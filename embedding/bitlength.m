function [block,a,k,count]=bitlength(g,a,k,F,totalbits,count,len);

% g=45;
if g>=64;
    bits=6;
    s=192;
    h=32;
elseif g<64 & g>=32;
    bits=5;
    s=224;
    h=16;
elseif g<32 & g>=16;
    bits=4;
    s=240;
    h=8;
elseif g<16
    bits=3;
    s=248;
    h=4;
end
l=bits;
% ou_t=embe_d(g,l,s,F);


F1=F(k);

coeff=bitand(g,s);
for i=1:l;

    if bitand(F1,a)==a;
        coeff= bitor(coeff,h);
    end
    count=count+1;
    
    a=a/2;
    h=h/2;
    if a<1;
        k=k+1;
       
        a=128;
        if k>len;
            break;
        end
         F1=F(k);
    end
    if count>totalbits;
        break;
    end
end

block=coeff;






















%%%%%%%%%%% lsb embedding%%%%%%%%%%
% ff=bitand(g,248)
% if l==3;
% for i=1:3;
% 
%     data1=uint8(data(i));
%     ddd=bitget(ggg,i);
%     if ddd==data1;
%         ddd=ddd;
%     else
%         ddd=bitcmp(ddd,1);
%         coef_f1=bitset(ggg,i,ddd);
%     end
% 
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for i=1:length(data1);
%     data=F(i);
%     a=128;
% if l==5;
%     for ii=1:3;
%     getcoeff=g;
%     aa=bitand(getcoeff,248);
%        if bitand(data,a)==1;
%         aa=bitor(aa,4);
%         
%        end
%        a=a/2;
%     end
% end
% end 
