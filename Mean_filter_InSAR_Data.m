function insar_Fit = Mean_filter_InSAR_Data(insar_data,radius)
%将insar监测点附近,的求均值
lon = insar_data(:,1);
lat = insar_data(:,2);
def = insar_data(:,3);

mean_vel = zeros(length(lon),1);
for n=1:length(lon)
        t = linspace(0,2*pi,114); 
        h=lon(n); k=lat(n);  % center cn for the circle
        % change radius if you want to include more points
        x = radius*cos(t);        y = radius*sin(t);        
        % SELECT POINTS based on LONLAT
        xy=llh2local([lon lat]',[h,k])'*1000;        
        in = inpolygon(xy(:,1),xy(:,2),x,y);        
        mean_vel(n) = mean(def(in));        
end
insar_Fit = [lon lat mean_vel];
end


