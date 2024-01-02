function [ feature,erroFiles ] = chinaHeavyIndustries_all( inputFilePath ,savefile,pointsNum_TH,density_TH,maxdate)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
%   形成中国区的重工业基地的shp结果
%   修改时间2019.3.1
%   chinaHeavyIndustries('\\10.6.20.85\c\cc\export\objects\objects20180625','\\10.6.20.85\c\cc\export\allChinaHeavyIndustries20180626.shp')
%   chinaHeavyIndustries('\\10.6.20.85\c\cc\heatSource_Object_handan\objects\objects2','\\10.6.20.85\c\cc\handan_ChinaHeavyIndustries20180625.shp')
%   chinaHeavyIndustries('\\10.6.20.85\c\cc\heatSource_Object_handan\objects\objects2','\\10.6.20.85\c\cc\handan_ChinaHeavyIndustries20180625.shp')
%   chinaHeavyIndustries_all('D:\learning\fire\export\objects20180628','D:\learning\fire\export\heavyIndustries\handan_ChinaHeavyIndustries20180628.shp')


Time_diff=datenum(datetime('20171231','InputFormat','yyyyMMdd'))-datenum(datetime('20120201','InputFormat','yyyyMMdd'));

if nargin==2
    pointsNum_TH=30;
    density_TH=100;
    maxdate='20171231';
elseif nargin==4
    maxdate='20171231';
end
Time_diff=datenum(datetime(maxdate,'InputFormat','yyyyMMdd'))-datenum(datetime('20120201','InputFormat','yyyyMMdd'));

clear feature;
Files = dir(strcat([inputFilePath ,'\'],'*.shp'));
Knum=1;
erroFiles=Files(1);
num=1;
for j=1:length(Files)
    clear data;
    if(strfind(Files(j).name,'U'))
%     if(strcmp(Files(j).name,'850_Ob_staticsU_m.shp'))
         try  
             filename=[inputFilePath ,'\',Files(j).name];
             disp(['正在处理',Files(j).name,'数据......']);
             data=shaperead(filename);
             for i=1:size(data,1)
        %          if(data(i).Points_num>100 & data(i).Date_diff>30 & data(i).Mean_date<30 & data(i).Std_date<30)
        %          if(data(i).Points_num>50 & data(i).Date_diff>30 & data(i).Mean_date<30 & data(i).Std_date<30 & max(data(i).Width,data(i).Height1)<50000) 
        %          if(data(i).Points_num>50 & data(i).Date_diff>30 & data(i).Mean_date<30 & data(i).Date_diff90<10 & data(i).density>100 ) 
                   percent=Time_diff/data(i).Date_diff;
                   percent=percent*cos(35/180*pi)/cos((data(i).BoundingBox(1,2)+data(i).BoundingBox(2,2))/360*pi);
%                    if(data(i).Points_num*percent>pointsNum_TH  & data(i).density*percent>density_TH & ......
%                      data(i).Date_diff>90 & data(i).Points_num>=9 & data(i).density>50) 
                 if(data(i).Points_num*percent>pointsNum_TH  & data(i).density*percent>density_TH & ......
                     data(i).Date_diff>90 & data(i).Date_diff1>30 & data(i).Points_num>=9 & data(i).density>50 &......
                     data(i).Points_num_>=5 & data(i).density_D>30 &......
                     (data(i).Points_num_>=10 | (data(i).Points_num_<10 & data(i).Points_num_/data(i).Points_num>0.8))) 
%                   if(data(i).Points_num_>=5 & data(i).density_D>30) 
                     feature(Knum).ID_num=Knum;
                     feature(Knum).ID=data(i).ID;
                     feature(Knum).Datasource=Files(j).name;
                     feature(Knum).Points_num=data(i).Points_num;
                     feature(Knum).Points_num_D=data(i).Points_num_;
                     feature(Knum).Points_percent=data(i).Points_num_/data(i).Points_num;
                     feature(Knum).Mean_date=data(i).Mean_date;
                     feature(Knum).Std_date=data(i).Std_date;
                     feature(Knum).Mean_date_1=data(i).Mean_date*feature(Knum).Points_num/feature(Knum).Points_num_D;
                     feature(Knum).Std_date_1=data(i).Std_date;
                     feature(Knum).density=data(i).density;
                     feature(Knum).density_D=data(i).density_D;
                     feature(Knum).Min_date=data(i).Min_date;
                     feature(Knum).Max_date=data(i).Max_date;
                     feature(Knum).Date_diff=data(i).Date_diff;
                     feature(Knum).Date_diff1=data(i).Date_diff1;
                     feature(Knum).Date_maxdif=data(i).Date_maxdif;
                     feature(Knum).Date_diff60=data(i).Date_diff60;
                     feature(Knum).Date_diff90=data(i).Date_diff90;
                     feature(Knum).Min_BRIGHT_TI4=data(i).Min_BRIGHT_;
                     feature(Knum).Max_BRIGHT_TI4=data(i).Max_BRIGHT_;
                     feature(Knum).Mean_BRIGHT_TI4=data(i).Mean_BRIGHT;
                     feature(Knum).Std_BRIGHT_TI4=data(i).Std_BRIGHT_;
                     feature(Knum).Min_BRIGHT_TI5=data(i).Min_BRIGHT_1;
                     feature(Knum).Max_BRIGHT_TI5=data(i).Max_BRIGHT_1;
                     feature(Knum).Mean_BRIGHT_TI5=data(i).Mean_BRIGHT1;
                     feature(Knum).Std_BRIGHT_TI5=data(i).Std_BRIGHT_1;
                     feature(Knum).Min_SCAN=data(i).Min_SCAN;
                     feature(Knum).Max_SCAN=data(i).Max_SCAN;
                     feature(Knum).Mean_SCAN=data(i).Mean_SCAN;
                     feature(Knum).Std_SCAN=data(i).Std_SCAN;
                     feature(Knum).Min_TRACK=data(i).Min_TRACK;
                     feature(Knum).Max_TRACK=data(i).Max_TRACK;
                     feature(Knum).Mean_TRACK=data(i).Mean_TRACK;
                     feature(Knum).Std_TRACK=data(i).Min_FRP;
                     feature(Knum).Min_FRP=data(i).Min_FRP;
                     feature(Knum).Max_FRP=data(i).Max_FRP;
                     feature(Knum).Mean_FRP=data(i).Mean_FRP;
                     feature(Knum).Std_FRP=data(i).Std_FRP;
                      %字符串属性
                     feature(Knum).Geometry = 'Polygon';
                     feature(Knum).BoundingBox=data(i).BoundingBox;
                     feature(Knum).X=data(i).X;
                     feature(Knum).Y=data(i).Y;
                     feature(Knum).minLon=data(i).BoundingBox(1,1);
                     feature(Knum).maxLon=data(i).BoundingBox(2,1);
                     feature(Knum).minLat=data(i).BoundingBox(1,2);
                     feature(Knum).maxLat=data(i).BoundingBox(2,2);
                     feature(Knum).Width=data(i).Width;
                     feature(Knum).Height=data(i).Height1;
                     
                     feature(Knum).date2012_pointNum=data(i).date2012_po;
                     feature(Knum).date2013_pointNum=data(i).date2013_po;
                     feature(Knum).date2014_pointNum=data(i).date2014_po;
                     feature(Knum).date2015_pointNum=data(i).date2015_po;
                     feature(Knum).date2016_pointNum=data(i).date2016_po;
                     feature(Knum).date2017_pointNum=data(i).date2017_po;
                     feature(Knum).date2018_pointNum=data(i).date2018_po;
                     Knum=Knum+1;          
                 end
            end   
         catch
            disp([filename,'数据出错！！！！！！']);
            erroFiles(num)=Files(j);
            
            %移动文件
            tofile=[savefile,'_erroFiles'];
            if ~exist(tofile)
                mkdir(tofile) % 若不存在，在当前目录中产生一个子目录‘Figure’
            end
            movefile(filename, [tofile,'\',Files(j).name]); 
            
            num=num+1;           
         end
    end
end

% shapewrite(feature,savefile);
shapewrite(feature,[savefile(1:end-4),'_',num2str(Knum),'.shp']);

feature_xlsx=rmfield(feature,{'BoundingBox','X','Y'}); %保存xlst
writetable(struct2table(feature_xlsx), [savefile(1:end-4),'_',num2str(Knum),'.xlsx']);
end

