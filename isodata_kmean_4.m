function [ clusterS,clusterSU] = isodata_kmean_4( dd,C,unionFlag,figureShow,figureTitle,intersect_TH )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
%   具体分类方法
%   1.首次采用Kmeans聚类；
%   2.只针对符合分类的类别进行再次分类
%   输入数据：
%           dd，输入数据，其中第一维和第二维为x、y坐标；
%           unionFlag，是否合并；
%           figureShow，是否显示聚类结果；
%           figureTitle，聚类结果figure名称；
%           figureTitle，聚类结果figure名称；
%           intersect_TH:相交边距百分比
%   isodata_kmean_4(dd,20,1,1);
%   isodata_kmean_4(dd,20,1,1,'handan',50);

%   问题：

%       2.合并过程中，只进行了部分合并，新建基于最近距离的合并

if nargin==1
    C=2;
    unionFlag=0;
    figureShow=0;
    figureTitle='当前分类结果';
    intersect_TH=0;
elseif nargin==2
    unionFlag=0;
    figureShow=0;
    figureTitle='当前分类结果';
    intersect_TH=0;
 elseif nargin==3
    figureShow=0;
    figureTitle='当前分类结果';
    intersect_TH=0;
elseif nargin==4
    figureTitle='当前分类结果';
    intersect_TH=0;
end

% max_boder_TH=1500;%边界阈值
max_boder_TH=800;%边界阈值
numP_TH=10;%点数阈值
add_C=1;
dd_new=dd;

%% 初次聚类
if(size(dd,1)<C)
    C=min(2,size(dd,1));
    [idx,ctrs,Dinner] = kmeans(dd(:,1:2),C,'Replicates',5);
else
    ops = statset('MaxIter',50);
    [idx,ctrs,Dinner] = kmeans(dd(:,1:2),C,'Replicates',5);
end

clusterS=[];
max_width=0;
max_hight=0;
add_C=2;%每次裂变的数目
for (j=1:C)
    curr_Cluster.data=dd(idx(:)==j,:);
    
    I=findOutlier(curr_Cluster.data(:,1),1); % 按照经纬度剔除异常点,进行一次剔除
    curr_Cluster.data(I,:)=[];
    I=findOutlier(curr_Cluster.data(:,2),1);
    curr_Cluster.data(I,:)=[];

    curr_Cluster.BoundingBox=[min(curr_Cluster.data(:,1)),min(curr_Cluster.data(:,2)); max(curr_Cluster.data(:,1)),max(curr_Cluster.data(:,2))];
    curr_Cluster.Width= distance(min(curr_Cluster.data(:,2)),min(curr_Cluster.data(:,1)),min(curr_Cluster.data(:,2)),max(curr_Cluster.data(:,1)),6371000);
    curr_Cluster.Height= distance(min(curr_Cluster.data(:,2)),min(curr_Cluster.data(:,1)),max(curr_Cluster.data(:,2)),min(curr_Cluster.data(:,1)),6371000);
    curr_Cluster.centerP=ctrs(j,:);
%     curr_Cluster.BoundingBox=[min(dd(idx(:)==j,1)),min(dd(idx(:)==j,2)); max(dd(idx(:)==j,1)),max(dd(idx(:)==j,2))];
%     curr_Cluster.Width= distance(min(dd(idx(:)==j,2)),min(dd(idx(:)==j,1)),min(dd(idx(:)==j,2)),max(dd(idx(:)==j,1)),6371000);
%     curr_Cluster.Height= distance(min(dd(idx(:)==j,2)),min(dd(idx(:)==j,1)),max(dd(idx(:)==j,2)),min(dd(idx(:)==j,1)),6371000);
%     curr_Cluster.data=dd(idx(:)==j,:);
    
     if(size(curr_Cluster.data,1)>numP_TH & max(max(curr_Cluster.Width,max_width),max(curr_Cluster.Height,max_hight))>max_boder_TH)
         clusterC= isodata_kmean_4(dd(idx(:)==j,:),add_C);%尽量保留足够的原始数据
         if(size(clusterS,2)==0)
             clusterS=clusterC;
         else
             clusterS(size(clusterS,2)+1:size(clusterS,2)+size(clusterC,2))=clusterC;
         end       
     else
         curr_Cluster.Ori_data=dd(idx(:)==j,:);
         clusterS{size(clusterS,2)+1}=curr_Cluster;
     end
end

% %% 是否显示图形
% if(figureShow ==1)
%     clusterFigure( clusterS,ctrs,figureTitle);    
% end

%% 相交矩形合并
clusterSU=[];
if(unionFlag==1)
    clusterS(cellfun(@isempty,clusterS))=[];
    clusterSU=union_cluster( clusterS,intersect_TH,1);
end

if(size(clusterS,2)==1)
    clusterS{1}.data=dd(:,:);   
    
    I=findOutlier(clusterS{1}.data(:,1)); % 按照经纬度剔除异常点
    clusterS{1}.data(I,:)=[];
    I=findOutlier(clusterS{1}.data(:,2));
    clusterS{1}.data(I,:)=[];
end
end

