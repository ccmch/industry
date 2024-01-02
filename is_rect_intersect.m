function [ out ] = is_rect_intersect(BoundingBoxA, BoundingBoxB,intersect_TH)  
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
%   检验矩形是否相交
%   intersect_TH:相交边距百分比
%   0，不相交；1，相交
if nargin==2
    intersect_TH=0;
end
    

zx = abs(BoundingBoxA(1,1) + BoundingBoxA(2,1)  -BoundingBoxB(1,1)  - BoundingBoxB(2,1));  
x  = abs(BoundingBoxA(1,1)  - BoundingBoxA(2,1)) + abs(BoundingBoxB(1,1) - BoundingBoxB(2,1));  
zy = abs(BoundingBoxA(1,2) + BoundingBoxA(2,2) - BoundingBoxB(1,2) - BoundingBoxB(2,2));  
y  = abs(BoundingBoxA(1,2)  - BoundingBoxA(2,2) ) + abs(BoundingBoxB(1,2) - BoundingBoxB(2,2));  
if(zx <= x && zy <= y) 
    if(intersect_TH==0)
        out=1;  
    elseif((BoundingBoxA(1,1)  - BoundingBoxB(1,1))*(BoundingBoxA(2,1)  - BoundingBoxB(2,1))<0 ......%内包含某一边
            | (BoundingBoxA(1,2)  - BoundingBoxB(1,2))*(BoundingBoxA(2,2)  - BoundingBoxB(2,2))<0)   
        out=1; 
    else
        inter_x=(x-zx)*50/min(abs(BoundingBoxA(1,1)  - BoundingBoxA(2,1)),abs(BoundingBoxB(1,1) - BoundingBoxB(2,1)));
        inter_y=(y-zy)*50/min(abs(BoundingBoxA(1,2)  - BoundingBoxA(2,2) ),abs(BoundingBoxB(1,2) - BoundingBoxB(2,2)));
        
        if(max(inter_x,inter_y)>=intersect_TH)
            out=1; 
        else
            out=0;  
        end        
    end
    
else  
    out=0;  
end

end

