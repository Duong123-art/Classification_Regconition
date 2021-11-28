clear all;
clc;

format long

trainData = csvread('trainData.csv');


%---------------------------------STEP 1----------------------------------
%---------------------------------------------------------------------------
all_distance = [];
classification= [];
for v = 491:500
    im = imread(strcat('dataSet\gray_WhiteBackGround\g',num2str(v), '.jpg'));
        
    imgray = imresize(im, [64 128]);

    [width, height] = size(imgray);

%---------------------------------STEP 2----------------------------------
%---------------------------------------------------------------------------

    hx = [-1, 0 ,+1];
    hy = hx';

    fx = imfilter(imgray, hx);
    fy = imfilter(imgray, hy);



%---------------------------------STEP 3----------------------------------
%---------------------------------------------------------------------------

   Gabs = sqrt(double(fx.^2 +fy.^2));
   Gtheta = atand(double(fy./fx));
% subplot(1,2,1);
% imshow(Gabs);
% subplot(1,2,2);
% imshow(Gtheta);

%---------------------------------STEP 4----------------------------------
%---------------------------------------------------------------------------
 %Tao cell 8x8
    cell88 = [];

    for i = 1:(width/8)
        for j = 1 : (height/8)
            cell88 = [cell88 ; [HOG_vector(imgray(8*i - 7: 8*i ,8*j - 7 : 8*j), Gabs(8*i - 7: 8*i ,8*j - 7 : 8*j),  Gtheta(8*i - 7: 8*i ,8*j - 7 : 8*j))]];
        end
    end

    his_norm = [];
    
    %normlize histogram 16x16
    for wid = 1 : 119
        if rem(wid, 8) == 0
           continue;
        end
        his_norm = [his_norm ; [cell88(wid,:) cell88(wid + 1, :) cell88(wid + 8, :) cell88(wid + 9, :)]]
   
    end

    for in = 1: 400
        all_distance = [all_distance distance(trainData((105 * in - 104):105*in ,:), his_norm)];
    end
end


%Sort and choose k of minimum and decision
for i = 1:10
    each_image_distance = all_distance(1,400*i - 399 : i*400);
    minIndex = [1:1:length(each_image_distance)];
 
  for i = 1 : length(each_image_distance)
      for j = 1: length(each_image_distance) - i
          if each_image_distance(1,j) >= each_image_distance(1,j+1)
              temp = each_image_distance(1,j);
              each_image_distance(1,j) = each_image_distance(1,j+1);
              each_image_distance(1,j + 1) = temp;
              
              temp1 = minIndex(1,j);
              minIndex(1,j) = minIndex(1,j + 1);
              minIndex(1,j+ 1) = temp1;
          end
      end
      
  end
      
 k_mins = minIndex(1:7);
chili = 0;
oni = 0;
ginger = 0;
lemongrass = 0;
starAnise = 0;
% 1-Ot  2-Hanh tay
    for iter = 1 : 7
        if k_mins(1,iter) >= 1 && k_mins(1,iter) <= 100
            chili = chili + 1;
        elseif k_mins(1,iter) > 100 && k_mins(1,iter) <= 200
            starAnise = starAnise + 1;
        elseif k_mins(1,iter) > 200 && k_mins(1,iter) <= 300
            ginger = ginger + 1;
        elseif k_mins(1,iter) > 300 && k_mins(1,iter) <= 400
            lemongrass = lemongrass + 1;
        else
            oni = oni + 1;
        end
        
    end
    
    maxAmount = max([chili oni lemongrass starAnise ginger]);
    
    switch maxAmount
        case chili
            classification = [classification [1]];
        case starAnise
            classification = [classification [2]];
        case ginger
            classification = [classification [3]];
        case lemongrass
            classification = [classification [4]];
        case oni
            classification = [classification [5]];
    end
  end
  
