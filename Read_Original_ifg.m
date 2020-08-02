clear;
close all;
clc;
%% ifg folder
% % work in 'SMALL_BASELINES' dir
ifg_path = '/media/l/000030F50000BE48/S1_SLC/NO_19_LandSlide/TS_des_201911_202004/INSAR_20200121/SMALL_BASELINES'

ifg_num = 13;
subplotRows = 3;
subplotCols = 5;

%% ifg range
r_index = 2501:4100;
z_index = 201:1100;

% r_index = 2901:3500;
% z_index = 601:1100;

%%
foldernum = dir(ifg_path);
figure
for num = 3:ifg_num+2
    subplot_tight(subplotRows, subplotCols,num-2,0.01)
    ifg = foldernum(num).name;
    intfile = [ifg_path,'/',ifg,'/isce_minrefdem.int']
    ph = load_isce(intfile);
   
    phROI = ph(r_index,z_index);    
%     clear ph
    imagesc(angle(phROI'));    
    colormap(jet);    
    axis off
    text(300,50,ifg,'Interpreter','none'...
        ,'FontSize',12,'Color','r','BackgroundColor','k')
end

%% set colorbar
c = colorbar(gca,'Ticks',[-3  3],'TickLabels',{'-\pi','\pi'},...
    'FontWeight','bold',...
    'FontSize',20,...
    'Location' ,'southoutside'); 
    %'Direction','reverse'   %colormap(flipud(jet));

c.Label.String = 'Rad';
c.Label.FontSize = 18
% c.Label.Position = [2.2349 4.7684e-05 0]

%save pic ,resize figure manual
export_fig int.jpg -native

%% Amp
figure
imagesc(sqrt(abs(phROI')),[0 255]);
colormap(gray);


%%
intfile = 'filt_topophase.flat.geo'

intfile = 'isce_minrefdem.int'
ph = load_isce(intfile);
imagesc(angle(ph'));
colormap(jet);
print(gcf,'-djpeg','-r500','20200323_20200522test.jpg');
close all
ph_out=goldstein_filt(ph,64,0.9);
imagesc(angle(ph_out'));
colormap(jet);
print(gcf,'-djpeg','-r500','20200323_20200522filt_test.jpg');

[ref_x,ref_y] = ginput(1);
ref_x = floor(ref_x);
ref_y = floor(ref_y);
figure
imagesc((angle(ph)-angle(ph(ref_x,ref_y)))');
colormap(jet);
