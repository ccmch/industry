function [I,Y] = findOutlier( X,deep )
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%   �����쳣�㣬��ɾ����ע
%   X��N*1ά����
%   deep,�޳������

if nargin==1
    deep=10000;%Ĭ��Ϊ�����
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

