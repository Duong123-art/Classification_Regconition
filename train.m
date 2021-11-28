clear all;
clc;

format long


%---------------------------------STEP 1----------------------------------
%---------------------------------------------------------------------------
data = [];
classification= [];
for v = 1:400
    if v >= 1 && v <= 80
      im = imread(strcat('dataSet\gray_WhiteBackGround\g',num2str(v), '.jpg'));
    elseif v > 80 && v <= 160
        im = imread(strcat('dataSet\gray_WhiteBackGround\g',num2str(20 + v), '.jpg'));
    elseif v > 160 && v <= 240
        im = imread(strcat('dataSet\gray_WhiteBackGround\g',num2str(40 + v), '.jpg'));
    elseif v > 240 && v <= 320
        im = imread(strcat('dataSet\gray_WhiteBackGround\g',num2str(60 + v), '.jpg'));
    else
      im = imread(strcat('dataSet\gray_WhiteBackGround\g',num2str(80 + v),'.jpg'));
   
    end

    
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


%---------------------------------STEP 4----------------------------------
%---------------------------------------------------------------------------

    cell88 = [];

    for i = 1:(width/8)
        for j = 1 : (height/8)
            cell88 = [cell88 ; [HOG_vector(imgray(8*i - 7: 8*i ,8*j - 7 : 8*j), Gabs(8*i - 7: 8*i ,8*j - 7 : 8*j),  Gtheta(8*i - 7: 8*i ,8*j - 7 : 8*j))]];
        end
    end

    his_normTrain = [];

    for wid = 1 : 119
        if rem(wid, 8) == 0
           continue;
        end
        his_normTrain = [his_normTrain ; [cell88(wid,:) cell88(wid + 1, :) cell88(wid + 8, :) cell88(wid + 9, :)]];
    end
    
    data = [data; his_normTrain];
end

csvwrite('trainData.csv', data);



