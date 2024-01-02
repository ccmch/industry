function [ sts ] = getObjectFeaturesFun2( dd,type_ID )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
%   读取一个object对象的shp文件，并形成相应的对象矢量
%   输入文件：shpPath，object对象的的shp文件路径
%   [sts ]=getObjectFeaturesFun2('D:\learning\fire\export\virrs_word_2012_2018_0.5_objects20190326\-104_31_Object.mat',1)
%   [ feature,sts ]=getObjectFeaturesFun1('\\10.6.20.85\c\cc\export\viirs_heatSource_anhui12_object\117762.shp',1)
%   data=shaperead('\\10.6.20.85\c\cc\export\heatSource_Object_beijing\5123.shp','1');
%   load('D:\learning\fire\export\virrs_word_2012_2018_0.5_objects20190326\-104_31_Object.mat')
%   data=clusterSU(14);
%   dd=data{1,1}.data(:,:);
%   type_ID=1;

sts.Geometry = 'Polygon';

dd(1,end)=0;
dd=sortrows(dd,size(dd,2)-1);%按照日期的先后顺序进行排序
dd(2:end,end)=diff(dd(:,end-1));

I=findOutlier(dd(:,1)); % 按照经纬度剔除异常点
dd(I,:)=[];
I=findOutlier(dd(:,2));
dd(I,:)=[];

 sts.ID=num2str(type_ID);
 sts.Points_num=size(dd,1);
 sts.Points_num_D=sum(dd(:,end)>0)+1;%统计所有时间段,发生火点的日期数目
 sts.Date_diff=max(dd(:,end-1))-min(dd(:,end-1));
 
ii=find(dd(:,end)>250);
 if size(ii,1)==0
     sts.Date_diff1=sts.Date_diff;%每250间隔天内，连续生产的最大天数
 else
     if ii(1)==1
         ii=[ii;size(dd,1)+1];
     else
         ii=[1;ii;size(dd,1)+1];
     end
     
     date_diff1=0;
     for i=1:size(ii)-1
         diff0=dd(ii(i+1)-1,end-1)-dd(ii(i),end-1);
         if(diff0>date_diff1)
             date_diff1=diff0;
         end
     end
     sts.Date_diff1=date_diff1;%每250间隔天内，连续生产的最大天数
 end
 
 sts.Date_maxdiff=max(dd(:,end));
 sts.Date_diff60=sum(dd(:,end)>60);
 sts.Date_diff90=sum(dd(:,end)>90);
 sts.Mean_date=mean(dd(:,end));
 sts.Std_date=std(dd(:,end));
 sts.Min_BRIGHT_TI4=min(dd(:,3));
 sts.Max_BRIGHT_TI4=max(dd(:,3));
 sts.Mean_BRIGHT_TI4=mean(dd(:,3));
 sts.Std_BRIGHT_TI4=std(dd(:,3));
 sts.Min_BRIGHT_TI5=min(dd(:,4));
 sts.Max_BRIGHT_TI5=max(dd(:,4));
 sts.Mean_BRIGHT_TI5=mean(dd(:,4));
 sts.Std_BRIGHT_TI5=std(dd(:,4));
 sts.Min_SCAN=min(dd(:,5));
 sts.Max_SCAN=max(dd(:,5));
 sts.Mean_SCAN=mean(dd(:,5));
 sts.Std_SCAN=std(dd(:,5));
 sts.Min_TRACK=min(dd(:,6));
 sts.Max_TRACK=max(dd(:,6));
 sts.Mean_TRACK=mean(dd(:,6));
 sts.Std_TRACK=std(dd(:,6));
 sts.Min_FRP=min(dd(:,7));
 sts.Max_FRP=max(dd(:,7));
 sts.Mean_FRP=mean(dd(:,7));
 sts.Std_FRP=std(dd(:,7));
  %字符串属性
 sts.BoundingBox=[min(dd(:,1)),min(dd(:,2)); max(dd(:,1)),max(dd(:,2))];
 sts.X=[min(dd(:,1)),max(dd(:,1)),max(dd(:,1)),min(dd(:,1)),min(dd(:,1)),NaN];
 sts.Y=[max(dd(:,2)),max(dd(:,2)),min(dd(:,2)),min(dd(:,2)),max(dd(:,2)),NaN];
 sts.Width= distance(min(dd(:,2)),min(dd(:,1)),min(dd(:,2)),max(dd(:,1)),6371000);
 sts.Height= distance(min(dd(:,2)),min(dd(:,1)),max(dd(:,2)),min(dd(:,1)),6371000);
 if(sts.Width*sts.Height>0)
     sts.density=sts.Points_num*1000*1000/(sts.Width*sts.Height);%每平方公里的点密度
     sts.density_D=sts.Points_num_D*1000*1000/(sts.Width*sts.Height);%每平方公里的点密度
 else
     sts.density=0;
     sts.density_D=0;
 end
 sts.Min_date=datestr(min(dd(:,end-1)),29);
 sts.Max_date=datestr(max(dd(:,end-1)),29);
 
 sts.date2012_pointNum=sum(datetime(datestr(dd(:,end-1),29))<'2013-01-01');
 sts.date2013_pointNum=sum(datetime(datestr(dd(:,end-1),29))<'2014-01-01' & datetime(datestr(dd(:,end-1),29))>='2013-01-01'); 
 sts.date2014_pointNum=sum(datetime(datestr(dd(:,end-1),29))<'2015-01-01'& datetime(datestr(dd(:,end-1),29))>='2014-01-01');
 sts.date2015_pointNum=sum(datetime(datestr(dd(:,end-1),29))<'2016-01-01'& datetime(datestr(dd(:,end-1),29))>='2015-01-01');
 sts.date2016_pointNum=sum(datetime(datestr(dd(:,end-1),29))<'2017-01-01'& datetime(datestr(dd(:,end-1),29))>='2016-01-01');
 sts.date2017_pointNum=sum(datetime(datestr(dd(:,end-1),29))<'2018-01-01'& datetime(datestr(dd(:,end-1),29))>='2017-01-01');
 sts.date2018_pointNum=sum(datetime(datestr(dd(:,end-1),29))<'2019-01-01'& datetime(datestr(dd(:,end-1),29))>='2018-01-01');
end



