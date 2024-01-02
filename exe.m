% % orishp='\\10.6.20.85\c\cc\export\viirs_heatsource_hebei_handan.shp';
% % filename='viirs_heatsource_hebei_handan';
% orishp='\\10.6.20.85\c\cc\export\viirs_heatsource_hebei3.shp';
% filename='viirs_heatsource_hebei3';
% savefile='D:\learning\fire\export\hebei_objects20180702';
% firePoint2Object(orishp,savefile,1,1);
% getAllFeatures2([savefile,'\',filename,'_Object.mat'],savefile);
% chinaHeavyIndustries2(savefile,......
%                       'D:\learning\fire\export\heavyIndustries\hebei_ChinaHeavyIndustries20180702.shp');
%                   
% load([savefile,'\',filename,'_Object.mat']);
% dd0=[];dd1=[];
% pointnum=0;Imax=0;
% for i=1:size(clusterS,2)
%     dd1=[dd1;clusterS{i}.data];
%     dd0=[dd0;clusterS{i}.Ori_data];
%     if(pointnum<size(clusterS{i}.Ori_data,1))
%         pointnum=size(clusterS{i}.Ori_data,1);
%         Imax=i;
%     end
% end


%% china
% oriFile='D:\learning\fire\export\virrs_china';
% savefile='D:\learning\fire\export\china_objects20180702';
% oriFile='D:\learning\fire\export\virrs_word';
% oriFile='\\10.6.11.201\f\mach\learning\fire\export\virrs_word20180709';
% savefile='\\10.6.11.201\f\mach\learning\fire\export\virrs_word_objects20180709_0.5';
% orishp='D:\learning\fire\export\virrs_china_xian\2687.shp';
% oriFile='D:\learning\fire\export\virrs_china_xian_2012_2018';
% savefile='D:\learning\fire\export\china_2012_2018_objects20190201';

% oriFile='D:\learning\fire\export\virrs_usa_xian_2012_2018';
% savefile='D:\learning\fire\export\usa_2012_2018_objects20190201';

oriFile='D:\learning\fire\export\virrs_word_2012_2018_0.5';
oriFile='D:\learning\fire\export\a';
savefile='D:\learning\fire\export\virrs_word_2012_2018_0.5_objects20190326_a';
% 一、用分类的方式，形成对象实体(mat)
% openPool(4);
tic
Files = dir(strcat([oriFile,'\'],'*.shp'));
% erroFiles=Files(1);
% num=1;
parfor i=1:length(Files)
    filename=Files(i).name(1:end-4);
    orishp=[oriFile,'\',Files(i).name];
    try   
        if ~exist([savefile,'\',filename,'_Object.mat'],'file')
            disp(['正在处理',orishp,'数据......']);
            firePoint2Object(orishp,savefile,1,0);
        end
    catch
        disp([orishp,'数据出错！！！！！！']);
%         erroFiles(num)=Files(i);
    end
end
t1=toc

% 二、提取特征
tic
savefile='D:\learning\fire\export\china_xian_objects20180703';
saveShp='D:\learning\fire\export\china_xian_objects20180703_feature20181205';

Files = dir(strcat([savefile,'\'],'*.mat'));
erroFiles=Files(1);
num=1;
parfor i=1:length(Files)
    filename=Files(i).name(1:end-4);
    orishp=[savefile,'\',Files(i).name];
    try        
         if ~exist([saveShp,'\',filename(1:end-4),'_statics_m.shp'],'file')
             getAllFeatures21([savefile,'\',filename],saveShp);
         end
         
         if ~exist([saveShp,'\',filename(1:end-4),'_staticsU_m.shp'],'file')
             getAllFeatures22([savefile,'\',filename],saveShp);
         end      
    catch
        disp([savefile,'\',filename,'数据出错！！！！！！']);      
    end   
end
t2=toc

%% 三、提取重工业
saveShp='D:\learning\fire\export\china_2012_2018_objects20190201_feature20190301';
industr_shp='D:\learning\fire\export\heavyIndustries\virrs_china2018_HeavyIndustries20190320_30_100_all.shp';


[feature,erroFiles]=chinaHeavyIndustries_all(saveShp,industr_shp,30,100,'20181231');

[feature,erroFiles]=chinaHeavyIndustries_all(saveShp,industr_shp,30,100);










