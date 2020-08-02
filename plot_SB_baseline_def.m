% work in 'INSAR_master' dir
clc

load('ps1.mat');
temp = load('./small_baselines.list');
M_date = datenum(string(temp(:,1)),'yyyymmdd');
S_date = datenum(string(temp(:,2)),'yyyymmdd');

figure
for i=1:length(M_date)
    t1 = M_date(i);
    t2 = S_date(i);
    Mp = find(day == t1);
    Sp = find(day == t2);
    l=line([day(Mp),day(Sp)],[bperp(Mp),bperp(Sp)],...
        'color','g','linewidth',2);
    text((day(Mp)+day(Sp))/2,(bperp(Mp)+bperp(Sp))/2,...
        num2str(i),'FontSize',16);
    hold on
end
scatter(day,bperp,120,'r','linewidth',3)

grid on
datetick('x','yyyymmdd')


xlabel('Time:yyyymmdd')
ylabel('Bperp:m')

set(gca,'FontSize',12)

print(gcf,'-djpeg','-r500','./sb_baseline.jpg');

% hold on
% s(1) = scatter(737573,180,50,'r','filled','DisplayName','SARӰ��')
% % legend(s,'FontSize',12)
% s(2) = line([737553,737593],[160,160],'color',[0 1 0],'linewidth',2,'DisplayName','�������');
% % legend(s,'FontSize',12)
% sb_find(0.6,100,200)
