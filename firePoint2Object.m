function firePoint2Object( shpPath,savePath,unionFlag,figureShow )
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%   ���Բ��趨����Kmeans����
%   �ɵ㵽����Ĺ�������

%   ���������
%           shpPath��shp�ļ���·����
%           savePath��Ŀ��object�洢·��
%           unionFlag���Ƿ�ϲ���
%           figureShow���Ƿ���ʾ��������
%           clusterNum: ����к��е�������
%   isodata_kmeans( shpPath )
%   firePoint2Object('\\10.6.20.85\c\cc\export\viirs_heatsource_hebei_handan.shp','D:\learning\fire\export\objects20180628',1,1);
%   firePoint2Object('D:\learning\fire\export\virrs_china_xian\850.shp','D:\learning\fire\export\wuanshi',1,1);
%   firePoint2Object('D:\learning\fire\export\virrs_china\viirs_heatsource_helongjiang8.shp','D:\learning\fire\export\china_objects20180702',1,1);

%% ���ݶ�ȡ
if nargin==2
    unionFlag=0;
    figureShow=0;
    clusterNum=10000;
elseif nargin==4
    clusterNum=10000;
end

data=shaperead(shpPath);
dd=[];%���������
date=[];%���������
sts.Geometry = 'Polygon';
for i=1:size(data,1)
   dd(i,:)=[data(i).LONGITUDE,data(i).LATITUDE,......
           data(i).BRIGHT_TI4,data(i).BRIGHT_TI5,data(i).SCAN,......
           data(i).TRACK,data(i).FRP,......
           datenum(datetime(data(i).ACQ_DATE,'InputFormat','yyyyMMdd'))];
end
[date, order]=sort(dd(:,end)); %����������������
dd=dd(order,:);
dd(1,end+1)=0;
dd(2:end,end)=diff(dd(:,end-1));

clear data date
%% Object�Ĺ���
maxNum=50000;%һ����������������
C0=fix(size(dd,1)/clusterNum);
if(C0<2)
    C0=2;
end

if(size(dd,1)<maxNum)
    [ clusterS,clusterSU]=isodata_kmean_4(dd,C0,unionFlag,figureShow,'handan',50);
else
     [ clusterS,clusterSU]=isodata_kmean_4(dd(1:maxNum,:),10,unionFlag,figureShow,'handan',50);
     for i=2:fix(size(dd,1)/maxNum)
         [ clusterC,clusterCU]=isodata_kmean_4(dd((i-1)*maxNum+1:i*maxNum,:),10,unionFlag,figureShow,'handan',50);   
         clusterS(size(clusterS,2)+1:size(clusterS,2)+size(clusterC,2))=clusterC;
         clusterSU(size(clusterSU,2)+1:size(clusterSU,2)+size(clusterCU,2))=clusterCU;
     end
     
     C0=fix((size(dd,1)-fix(size(dd,1)/maxNum)*maxNum)/clusterNum);
     if(C0<2)
        C0=2;
     end
     [ clusterC,clusterCU]=isodata_kmean_4(dd(fix(size(dd,1)/maxNum)*maxNum+1:end,:),C0,unionFlag,figureShow,'handan',50); 
     clusterS(size(clusterS,2)+1:size(clusterS,2)+size(clusterC,2))=clusterC;
     clusterSU(size(clusterSU,2)+1:size(clusterSU,2)+size(clusterCU,2))=clusterCU;
end

savefilename=regexp(shpPath, '\', 'split');

if ~exist(savePath)
    mkdir(savePath) % �������ڣ��ڵ�ǰĿ¼�в���һ����Ŀ¼��Figure��
end

fn=char(savefilename(end));
save([savePath,'\',fn(1:end-4),'_Object.mat'],'clusterS','clusterSU');
end
