function [ output_args ] = getAllFeatures21( filPath,saveFile )
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
%   读取一个区域的mat文件,提取特征，并保存为shp文件
%   输入参数：
%           filePath:读取的shp文件路径
%           saveFile：要保存的文件路径
%  getAllFeatures2('D:\learning\fire\export\objects20180628\viirs_heatsource_hebei_handan_Object.mat','D:\learning\fire\export\objects20180628')
%  getAllFeatures2('D:\learning\fire\export\objects20180628_1\viirs_heatsource_hebei_handan_Object.mat','D:\learning\fire\export\objects20180628_1')

%openPool( 4);
load(filPath);
savefilename=regexp(filPath, '\', 'split');

%% 合并前
[ S(1)] = getObjectFeaturesFun2(clusterS{1}.Ori_data,1);
num=1;
for i=1:size(clusterS,2)
%     S(num)=getObjectFeaturesFun2(clusterS{i}.data,i);
    S(num)=getObjectFeaturesFun2(clusterS{i}.Ori_data,i);
    num=num+1;    
    %S(i).Geometry = 'Polygon';
    disp(['正在处理',filPath,'的第',num2str(i),'个数据......']);
%     Knum=Knum+1;
end

if ~exist(saveFile)
    mkdir(saveFile) % 若不存在，在当前目录中产生一个子目录‘Figure’
end

sf=char(savefilename(end));
try
    shapewrite(S,[saveFile,'\',sf(1:end-4),'_statics_m.shp']);
catch %是否存在Inf和NaN值
    for i=1:size(S,2)
        if(isinf(S(i).Std_date))
            S(i).Std_date=999999;
        end
        if(isinf(S(i).Min_BRIGHT_TI4))
            S(i).Min_BRIGHT_TI4=999999;
        end
        if(isinf(S(i).Max_BRIGHT_TI4))
            S(i).Max_BRIGHT_TI4=999999;
        end
        if(isinf(S(i).Mean_BRIGHT_TI4))
            S(i).Mean_BRIGHT_TI4=999999;
        end
        if(isinf(S(i).Std_BRIGHT_TI4))
            S(i).Std_BRIGHT_TI4=999999;
        end
        
        if(isinf(S(i).Min_BRIGHT_TI5))
            S(i).Min_BRIGHT_TI5=999999;
        end
        if(isinf(S(i).Max_BRIGHT_TI5))
            S(i).Max_BRIGHT_TI5=999999;
        end
        if(isinf(S(i).Mean_BRIGHT_TI5))
            S(i).Mean_BRIGHT_TI5=999999;
        end
        if(isinf(S(i).Std_BRIGHT_TI5))
            S(i).Std_BRIGHT_TI5=999999;
        end
        
         if(isinf(S(i).Min_SCAN))
            S(i).Min_SCAN=999999;
        end
        if(isinf(S(i).Max_SCAN))
            S(i).Max_SCAN=999999;
        end
        if(isinf(S(i).Mean_SCAN))
            S(i).Mean_SCAN=999999;
        end
        if(isinf(S(i).Std_SCAN))
            S(i).Std_SCAN=999999;
        end
        
         if(isinf(S(i).Min_TRACK))
            S(i).Min_TRACK=999999;
        end
        if(isinf(S(i).Max_TRACK))
            S(i).Max_TRACK=999999;
        end
        if(isinf(S(i).Mean_TRACK))
            S(i).Mean_TRACK=999999;
        end
        if(isinf(S(i).Std_TRACK))
            S(i).Std_TRACK=999999;
        end
        
        if(isinf(S(i).Min_FRP))
            S(i).Min_FRP=999999;
        end
        if(isinf(S(i).Max_FRP))
            S(i).Max_FRP=999999;
        end
        if(isinf(S(i).Mean_FRP))
            S(i).Mean_FRP=999999;
        end
        if(isinf(S(i).Std_FRP))
            S(i).Std_FRP=999999;
        end
    end  
    shapewrite(S,[saveFile,'\',sf(1:end-4),'_statics_m.shp']);
end

end