function [ output_args ] = getAllFeatures22( filPath,saveFile )
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%   ��ȡһ�������mat�ļ�,��ȡ������������Ϊshp�ļ�
%   ���������
%           filePath:��ȡ��shp�ļ�·��
%           saveFile��Ҫ������ļ�·��
%  getAllFeatures2('D:\learning\fire\export\objects20180628\viirs_heatsource_hebei_handan_Object.mat','D:\learning\fire\export\objects20180628')
%  getAllFeatures2('D:\learning\fire\export\objects20180628_1\viirs_heatsource_hebei_handan_Object.mat','D:\learning\fire\export\objects20180628_1')
%  getAllFeatures2('\\10.6.11.201\f\mach\learning\fire\export\virrs_word_objects20180709_0.5\-62(0)_-18_Object.mat','\\10.6.11.201\f\mach\learning\fire\export\virrs_word_objects20180709_0.5')
%  getAllFeatures22('D:\learning\fire\export\virrs_word_2012_2018_0.5_objects20190326\-104_31_Object.mat','1');

%openPool( 4);
load(filPath);
savefilename=regexp(filPath, '\', 'split');

%% �ϲ���
[ SU(1)] = getObjectFeaturesFun2(clusterSU{1}.Ori_data,1);
num=1;
for i=1:size(clusterSU,2)
%     SU(num)=getObjectFeaturesFun2(clusterSU{i}.data,i);
     SU(num)=getObjectFeaturesFun2(clusterSU{i}.Ori_data,i);
    num=num+1;    
    %S(i).Geometry = 'Polygon';
    disp(['���ڴ���',filPath,'�ĵ�',num2str(i),'������......']);
%     Knum=Knum+1;
end

if ~exist(saveFile)
    mkdir(saveFile) % �������ڣ��ڵ�ǰĿ¼�в���һ����Ŀ¼��Figure��
end

sf=char(savefilename(end));
try
    shapewrite(SU,[saveFile,'\',sf(1:end-4),'_staticsU_m.shp']);
catch %�Ƿ����Inf��NaNֵ
    for i=1:size(SU,2)
        if(isinf(SU(i).Std_date))
            SU(i).Std_date=999999;
        end
        if(isinf(SU(i).Min_BRIGHT_TI4))
            SU(i).Min_BRIGHT_TI4=999999;
        end
        if(isinf(SU(i).Max_BRIGHT_TI4))
            SU(i).Max_BRIGHT_TI4=999999;
        end
        if(isinf(SU(i).Mean_BRIGHT_TI4))
            SU(i).Mean_BRIGHT_TI4=999999;
        end
        if(isinf(SU(i).Std_BRIGHT_TI4))
            SU(i).Std_BRIGHT_TI4=999999;
        end
        
        if(isinf(SU(i).Min_BRIGHT_TI5))
            SU(i).Min_BRIGHT_TI5=999999;
        end
        if(isinf(SU(i).Max_BRIGHT_TI5))
            SU(i).Max_BRIGHT_TI5=999999;
        end
        if(isinf(SU(i).Mean_BRIGHT_TI5))
            SU(i).Mean_BRIGHT_TI5=999999;
        end
        if(isinf(SU(i).Std_BRIGHT_TI5))
            SU(i).Std_BRIGHT_TI5=999999;
        end
        
         if(isinf(SU(i).Min_SCAN))
            SU(i).Min_SCAN=999999;
        end
        if(isinf(SU(i).Max_SCAN))
            SU(i).Max_SCAN=999999;
        end
        if(isinf(SU(i).Mean_SCAN))
            SU(i).Mean_SCAN=999999;
        end
        if(isinf(SU(i).Std_SCAN))
            SU(i).Std_SCAN=999999;
        end
        
         if(isinf(SU(i).Min_TRACK))
            SU(i).Min_TRACK=999999;
        end
        if(isinf(SU(i).Max_TRACK))
            SU(i).Max_TRACK=999999;
        end
        if(isinf(SU(i).Mean_TRACK))
            SU(i).Mean_TRACK=999999;
        end
        if(isinf(SU(i).Std_TRACK))
            SU(i).Std_TRACK=999999;
        end
        
        if(isinf(SU(i).Min_FRP))
            SU(i).Min_FRP=999999;
        end
        if(isinf(SU(i).Max_FRP))
            SU(i).Max_FRP=999999;
        end
        if(isinf(SU(i).Mean_FRP))
            SU(i).Mean_FRP=999999;
        end
        if(isinf(SU(i).Std_FRP))
            SU(i).Std_FRP=999999;
        end
    end  
    
    shapewrite(SU,[saveFile,'\',sf(1:end-4),'_staticsU_m.shp']);
end
end