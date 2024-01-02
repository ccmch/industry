function [ clusterS,clusterSU] = isodata_kmean_4( dd,C,unionFlag,figureShow,figureTitle,intersect_TH )
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%   ������෽��
%   1.�״β���Kmeans���ࣻ
%   2.ֻ��Է��Ϸ�����������ٴη���
%   �������ݣ�
%           dd���������ݣ����е�һά�͵ڶ�άΪx��y���ꣻ
%           unionFlag���Ƿ�ϲ���
%           figureShow���Ƿ���ʾ��������
%           figureTitle��������figure���ƣ�
%           figureTitle��������figure���ƣ�
%           intersect_TH:�ཻ�߾�ٷֱ�
%   isodata_kmean_4(dd,20,1,1);
%   isodata_kmean_4(dd,20,1,1,'handan',50);

%   ���⣺

%       2.�ϲ������У�ֻ�����˲��ֺϲ����½������������ĺϲ�

if nargin==1
    C=2;
    unionFlag=0;
    figureShow=0;
    figureTitle='��ǰ������';
    intersect_TH=0;
elseif nargin==2
    unionFlag=0;
    figureShow=0;
    figureTitle='��ǰ������';
    intersect_TH=0;
 elseif nargin==3
    figureShow=0;
    figureTitle='��ǰ������';
    intersect_TH=0;
elseif nargin==4
    figureTitle='��ǰ������';
    intersect_TH=0;
end

% max_boder_TH=1500;%�߽���ֵ
max_boder_TH=800;%�߽���ֵ
numP_TH=10;%������ֵ
add_C=1;
dd_new=dd;

%% ���ξ���
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
add_C=2;%ÿ���ѱ����Ŀ
for (j=1:C)
    curr_Cluster.data=dd(idx(:)==j,:);
    
    I=findOutlier(curr_Cluster.data(:,1),1); % ���վ�γ���޳��쳣��,����һ���޳�
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
         clusterC= isodata_kmean_4(dd(idx(:)==j,:),add_C);%���������㹻��ԭʼ����
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

% %% �Ƿ���ʾͼ��
% if(figureShow ==1)
%     clusterFigure( clusterS,ctrs,figureTitle);    
% end

%% �ཻ���κϲ�
clusterSU=[];
if(unionFlag==1)
    clusterS(cellfun(@isempty,clusterS))=[];
    clusterSU=union_cluster( clusterS,intersect_TH,1);
end

if(size(clusterS,2)==1)
    clusterS{1}.data=dd(:,:);   
    
    I=findOutlier(clusterS{1}.data(:,1)); % ���վ�γ���޳��쳣��
    clusterS{1}.data(I,:)=[];
    I=findOutlier(clusterS{1}.data(:,2));
    clusterS{1}.data(I,:)=[];
end
end

