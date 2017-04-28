# XOA CAC FILE CU QUA TRINH TRUOC DO
rm -rf *.log
rm -rf work
rm -rf text2img_source.txt
rm -rf text2img_sink.txt
#rm -rf ../data_inout/*.txt

# DUNG MATLAB XU LI CHUYEN DOI HINH ANH SANG TEXT TXT
#matlab  -wait -nosplash -nodesktop -minimize -r "cd ../matlab; RGB_i2t('../data_inout/edge_detection.png','../data_inout/text2img_source.txt'); exit" -logfile

# COPY FILE TEXT SANG THU MUC HIEN HANH
cp -rf ../data_inout/text2img_source.txt ./text2img_source.txt

# SIMULATE PROCESS
vlib work
vmap work work
vlog -f filelist.f
vsim -l testbench.log -c filter_system_tb -voptargs=+acc -novopt -assertdebug -do "log -r -d 6 /*; add wave -r /*; radix -h; run -all" 

# COPY FILE TXT DA XU LI VE THU MUC DATA_INOUT
cp text2img_sink.txt ../data_inout/text2img_sink.txt

# DUNG MATLAB DE XEM KET QUA CUA QUA TRINH
echo "Simulation is completed. See result at matlab directory!!!"

# THONG BAO KET THUC QUA TRINH
#matlab -nosplash -nodesktop -minimize -r "cd ../matlab; RGB_t2i('../data_inout/text2img_sink.txt');"
#matlab -nosplash -nodesktop -minimize -r "cd ../matlab; imshow('../data_inout/edge_detection.png'); title('Original picture view on Matlab');;"
#matlab -nosplash -nodesktop -minimize -r "cd ../matlab; sobel_filter('../data_inout/edge_detection.png');"



