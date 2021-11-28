function [h1 h2 h3 h4 h5 h hu_moments] = Recognition_Hu(im,k);
im= im2bw(im);
[s1,s2,s3,s4,s5,s6,s7] = Hu(im);

hu_moments = [s1,s2,s3,s4,s5,s6,s7]

h(400,1)=1;

for i=1:400
%     im2=imread(sprintf('n%d.jpg',i));
%     im2= im2bw(im2);
%     [ss1,ss2,ss3,ss4,ss5,ss6,ss7] = Hu(im2);
%     h(i)=abs(ss1-s1)+abs(ss2-s2)+abs(ss3-s3)+abs(ss4-s4)+abs(ss5-s5)+abs(ss6-s6)+abs(ss7-s7);
    %%
    h(i,1)=abs(s1-k(i,1))+abs(s2-k(i,2))+abs(s3-k(i,3))+abs(s4-k(i,4))+abs(s5-k(i,5))+abs(s6-k(i,6))+abs(s7-k(i,7));
end

h1=h(i,1);
for i=1:400
    if(h(i,1)<h1) h1=h(i,1);
    end
end
h1;
h2=h(i,1);
for i=1:400
    if(h(i,1)<h2 && h(i,1)>h1) h2=h(i,1);
    end
end
h2;
h3=h(i,1);
for i=1:400
    if(h(i,1)<h3 && h(i,1)>h2) h3=h(i,1);
    end
end
h3;
h4=h(i,1);
for i=1:400
    if(h(i,1)<h4 && h(i,1)>h3) h4=h(i,1);
    end
end
h4;
h5=h(i,1);
for i=1:400
    if(h(i,1)<h5 && h(i,1)>h4) h5=h(i,1);
    end
end
h5;
end