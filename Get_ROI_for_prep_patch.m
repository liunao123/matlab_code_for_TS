clc
clear
close all

%% your AOI
% left down point
lonp = 113.34
latp = 22.51

dif_lon = 0.3;
dif_lat = 0.3;

%% prep for mt_prep_isce 0.6 num_ran num_azi 
% load whole coverage of ifgs

% work in 'INSAR_master' dir
lon = load_isce('lon.raw');
lat = load_isce('lat.raw');
scatter(lon(1:100000:end),lat(1:100000:end),1)
hold on 
rectangle('Position',[98.9,30.55,0.05,0.05])


%% load a patch coverage of ifgs
% work in 'PATCH_X' dir
temp = load('pscands.1.ij');
point_num = temp(end,1);

phname = 'pscands.1.ll';
fid=fopen(phname,'r');
[ph_bit,byte_count]=fread(fid,[2*point_num,1],'float');
lon1 = ph_bit(1:2:end);
lat1 = ph_bit(2:2:end);
step = 100;

% figure
scatter(lon1(1:step:end),lat1(1:step:end),100)
hold on
% rectangle('Position',[118.87,27.65,0.05,0.1]) % ZJ
%rectangle('Position',[98.4,30.9,0.4,0.3])  % ALOS2
rectangle('Position',[lonp,latp,dif_lon,dif_lat])


%% Write your AOI to Google earth file 'kml'
x = [lon,lon,lon + dif_lon,lon + dif_lon];
y = [lat,lat + dif_lat,lat + dif_lat,lat];

filename = './AOI_polygon.kml';

kmlwritepolygon(filename,y,x,0,'EdgeColor','r', ...
       'FaceColor','w','PolygonCutMeridian',0);

