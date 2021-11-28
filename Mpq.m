function [m] = Mpq(im,p,q);

 TS1=0;
 TS2=0;
 MS=0;
h=0;
m00=0;
 [a b]=size(im);
  for x=1:a
      for y=1:b
          TS1=TS1+x*im(x,y);
          TS2=TS2+y*im(x,y);
          MS=MS+im(x,y);
      end
  end
  xx=TS1/MS;
  yy=TS2/MS;
  for x=1:a
        for y=1:b
            h=h+((x-xx)^p) *((y-yy)^q) *im(x,y);
            m00=m00+((x-xx)^0) *((y-yy)^0) *im(x,y);
        end
  end
 
  m=h/mpower(m00,(p+q)/2+1);
  %m=h;
 
end