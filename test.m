clear all;
clc;

i = 0;
for v = 481:500
%     if v >= 1 && v <= 100
%         im = imread(strcat('dataSet\gray_WhiteBackGround\g',num2str(v), '.jpg'));
%         i = i + 1;
%     elseif v > 100 && v <= 200
%         im = imread(strcat('dataSet\gray_WhiteBackGround\g',num2str(v), '.jpg'));
%         i = i + 1;
%     elseif v > 200 && v <= 300
%         im = imread(strcat('dataSet\gray_WhiteBackGround\g',num2str(v), '.jpg'));
%         i = i + 1;
%     elseif v > 300 && v <= 400
%         im = imread(strcat('dataSet\gray_WhiteBackGround\g',num2str(v), '.jpg'));
%         i = i + 1;
%     else
        im = imread(strcat('dataSet\gray_WhiteBackGround\g',num2str(v),'.jpg'));
        i = i + 1;
%     end
end