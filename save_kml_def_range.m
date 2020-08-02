clear
close all
clc

%% load data
data = [] % the AOI point data

% load('ps_plot_ts_v-do.mat')
load ps_plot_ts_v-o.mat lonlat ph_mm
ph_disp = (ph_mm(:,end) - ph_mm(:,1))/((day(end)-day(1))/365.25);

%% get AOI

% one : Get AOI from kml file
% kmlname = 'ROI_LQ.kml';
% [lon_range,lat_range,~] = read_kml(kmlname);
% two : ginput on figure
scatter(lonlat(:,1),lonlat(:,2),1,ph_disp)
caxis([-100 100])
[lon_range,lat_range] = ginput(4);

%% 
hold on
plot(lon_range,lat_range)

%% get point in AOI
in = 0;
[in,~]= inpolygon(lonlat(:,1),lonlat(:,2),lon_range,lat_range);
lon = lonlat(in,1);
lat = lonlat(in,2);
acc_disp = ph_disp(in);

temp = [lon lat acc_disp + 0.5];
data(length(data)+1:length(data)+length(temp),1:3) = temp;


%% how many point ,you want to write kml,

step = 1:1:length(data);  % all point 
% step = 1:10:length(data);  % 1/10 point 
% step = 1:100:length(data);  % 1/100 point 

% Mean Filter
data = Mean_filter_InSAR_Data(data,50);

% write kml
scatter(data(:,1),data(:,2),1,data(:,3))
colormap(flipud(jet));caxis([-100 100])

% write kml with colorbar 
filename = './SYD_f_50.kml';
filecolorbar = 'E:\InSAR_package\TS_code\colorbar\cb100.png';              %must be png file
viS_gescatter(filename,filecolorbar,data(step,1),data(step,2),...
    data(step,3),...
    'scale',0.8,...
    'colormap','jet',...
    'opacity',1,...    
    'clims',[-100 100]);
% zip('temp.zip',{filename,filecolorbar});
% filename(end-2:end) = 'kmz';
% movefile('temp.zip', filename)


