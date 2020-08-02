<<<<<<< HEAD
# matlab_code_for_TS
=======
matlab code tested on matlab2018a and matlab2018b

1-gescatter.m
 stamps function, write kml
 
2-viS_gescatter.m
 function to write kml with a colorbar(a png picture) you define
 
3-get_30m_dem_url.m
 get 30m dem datalink,then you can used IDM to download dem
 
4-Mean_filter_InSAR_Data.m
 Do Mean filter for data on spatial with define radius
 
5-read_kml.m
get lon, lat, ati from a kml file

6-save_kml_def_range.m
 used with 1,2,4

7-Read_Original_ifg.m
 Read Original ifg generate by isce,
 need other funtion:
 1,load_isce(stamps m code);
 2,subplot_tight;
 3,export_fig (export_fig code)
 
8-Split_des_asc_datalink.m
 if you get a lot of S1A datalink in one txt file,
 this function can Split datalink to different orbit
 
9-successful_download_POD.py
this py file can download orbit file with 2 ways;
1, if you not explanatory(不注释)  69th line(  download(savefile,eof)  ) 
   it can download orbit directly and print every orbit file datalink
   
2,if you explanatory(注释)   69th line(  download(savefile,eof)  ) 
  it only print every orbit file datalink,so you can copy all orbit file datalink to IDM,this should be faster than 1
>>>>>>> first matlab code add to github
