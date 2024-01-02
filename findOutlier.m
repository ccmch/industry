function [I,Y] = findOutlier( X,deep )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
%   发现异常点，并删除标注
%   X：N*1维数据
%   deep,剔除的深度

if nargin==1
    deep=10000;%默认为无穷大
end

I=[];
Y=X;
m=mean(Y);
s=std(Y);
I=find(abs(X-m)>3*s);
Y(I)=[];
num=1;
while (num<deep & sum(abs(Y-m)>3*s)>0)
    I=find(abs(X-m)>3*s);
    Y=X;
    Y(I)=[];
    m=mean(Y);
    s=std(Y);
    num=num+1;
end
end

