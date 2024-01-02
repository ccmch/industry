function [names,class_num] = GetFiles(SamplePath1, toPath)
%指定一个文件夹，返回这个文件夹下所有文件夹的名字，以及文件夹的个数。
%[names,class_num] = GetFiles( '\\10.6.20.85\c\cc\heatSource_Object_handan\','\\10.6.20.85\c\cc\heatSource_Object_handan\objects\objects3');
% toPath='D:\learning\fire\export\objects';
% GetFiles('\\10.6.20.85\c\cc\export\','\\10.6.20.85\c\cc\export\objects\objects20180625')
openPool( 4);
files = dir(SamplePath1);
size0 = size(files);
length = size0(1);
class_num=0;
parfor i=3:length;
     if(files(i,1).isdir==1 & strcmp(files(i,1).name,'objects')==0 & exist([toPath,'\',files(i,1).name,'_statics_m.shp'],'file')==0 )%是否是文件夹
%     if(files(i,1).isdir==1 & .......
%             (strcmp(files(i,1).name,'viirs_heatsource_hebei3_object')==1 ||  strcmp(files(i,1).name,'viirs_heatSource_neimenggu5_object') || strcmp(files(i,1).name,'viirs_heatSource_liaoning6_object')......
%             & exist([toPath,'\',files(i,1).name,'_statics_m.shp'],'file')==0 )%是否是文件夹
        fileName = strcat(SamplePath1,files(i,1).name); 
        getAllFeatures(fileName,toPath);
         %class_num=class_num+1;
         %names{class_num} = fileName;
    end  
end
%class_num = size(names);
end
