function [ clusterSU] = union_cluster( clusterS,intersect_TH,figureShow,figureTitle)
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%   ������෽��
%   �ϲ�������

%   �������ݣ�
%           clusterS��
%           intersect_TH:�ཻ�߾�ٷֱ�
%           figureShow���Ƿ���ʾ��������
%           figureTitle��������figure���ƣ�
%           figureTitle��������figure���ƣ�

%    union_cluster(clusterS,50,1)

%   ���⣺

%       2.�ϲ������У�ֻ�����˲��ֺϲ����½������������ĺϲ�

if nargin==1
    figureShow=0;
    figureTitle='��ǰ�ϲ���ķ�����';
    intersect_TH=0;
elseif nargin==2
    figureShow=0;
    figureTitle='��ǰ�ϲ���ķ�����';
elseif nargin==3
    figureTitle='��ǰ�ϲ���ķ�����';
end


 clusterS(cellfun(@isempty,clusterS))=[];
 ctrs=[];
 for (i=1:size(clusterS,2))
     ctrs(i,:)= clusterS{i}.centerP;      
 end

 num=0;
for (i=1:size(clusterS,2))
    empty=cellfun(@isempty,clusterS);
    if(empty(i)==0)
        [d,near_I]=sort(sqrt((ctrs(:,1)-ctrs(i,1)).^2+(ctrs(:,2)-ctrs(i,2)).^2));
        
        if (max(clusterS{i}.Width,clusterS{i}.Height)<10000)
            C1=min(3,size(near_I));
            for j=2:C1%һ�����ϲ�����        
                if(empty(near_I(j))==0 & is_rect_intersect(clusterS{i}.BoundingBox, clusterS{near_I(j)}.BoundingBox,intersect_TH))
                    clusterS_C=[];
                    clusterS_C.Ori_data=[clusterS{i}.Ori_data;clusterS{near_I(j)}.Ori_data];
                    
                    clusterS_C.data=clusterS_C.Ori_data;
                    I=findOutlier(clusterS_C.data(:,1),3); % ���վ�γ���޳��쳣�㣬��ԭʼ���ݽ���3���޳�
                    clusterS_C.data(I,:)=[];
                    I=findOutlier(clusterS_C.data(:,2),3);
                    clusterS_C.data(I,:)=[];

                    clusterS_C.BoundingBox=[min(clusterS_C.data(:,1)),min(clusterS_C.data(:,2)); max(clusterS_C.data(:,1)),max(clusterS_C.data(:,2))];
                    clusterS_C.Width= distance(min(clusterS_C.data(:,2)),min(clusterS_C.data(:,1)),min(clusterS_C.data(:,2)),max(clusterS_C.data(:,1)),6371000);
                    clusterS_C.Height= distance(min(clusterS_C.data(:,2)),min(clusterS_C.data(:,1)),max(clusterS_C.data(:,2)),min(clusterS_C.data(:,1)),6371000);
                    
                    clusterS_C.centerP=[mean(clusterS_C.data(:,1)),mean(clusterS_C.data(:,2))];
                    
                    if(max(clusterS_C.Width,clusterS_C.Height)<10000) %����������ϲ�
                        ctrs(i,:)=clusterS{i}.centerP; 
%                         ctrs(near_I(j),:)=[];
                        clusterS{i}=clusterS_C;
                        clusterS{near_I(j)}=[];
                        num=num+1;
                        break;
                    end
                    
                    
%                     clusterS{i}.Ori_data=[clusterS{i}.Ori_data;clusterS{near_I(j)}.Ori_data];
% 
%                     clusterS{i}.data=clusterS{i}.Ori_data;
%                     I=findOutlier(clusterS{i}.data(:,1),2); % ���վ�γ���޳��쳣�㣬��ԭʼ���ݽ���3���޳�
%                     clusterS{i}.data(I,:)=[];
%                     I=findOutlier(clusterS{i}.data(:,2),2);
%                     clusterS{i}.data(I,:)=[];
% 
%                     clusterS{i}.BoundingBox=[min(clusterS{i}.data(:,1)),min(clusterS{i}.data(:,2)); max(clusterS{i}.data(:,1)),max(clusterS{i}.data(:,2))];
%                     clusterS{i}.centerP=[mean(clusterS{i}.data(:,1)),mean(clusterS{i}.data(:,2))];
%                     ctrs(i,:)=clusterS{i}.centerP; 
%     %                 ctrs(j,:)=[0,0];
%                     clusterS{near_I(j)}=[];
%                     num=num+1;
%                     break;
                end
            end
        end       
    end    
end

if(num)
     clusterS(cellfun(@isempty,clusterS))=[];
     clusterSU=union_cluster(clusterS,intersect_TH);
else
     clusterSU=clusterS;
end
%% �Ƿ���ʾͼ��
% if(figureShow ==1)
%     clusterSU(cellfun(@isempty,clusterSU))=[];
%     clusterFigure( clusterSU,ctrs,figureTitle);    
% end
end

