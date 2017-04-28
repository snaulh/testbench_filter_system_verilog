echo on
REM /// XOA CAC FILE CU QUA TRINH TRUOC DO
del /Q *.log
del /Q work
REM del /Q text2img_source.txt
del /Q text2img_sink.txt
del /Q ..\data_inout\*.txt

REM ///DUNG MATLAB XU LI CHUYEN DOI HINH ANH SANG TEXT TXT
matlab  -wait -nosplash -nodesktop -minimize -r "cd ../matlab; RGB_i2t('../data_inout/edge_detection.png','../data_inout/text2img_source.txt'); exit" -logfile

REM /// COPY FILE TEXT SANG THU MUC HIEN HANH
copy /y ..\data_inout\text2img_source.txt text2img_source.txt

REM /// SIMULATE PROCESS
vlib work
vmap work work
vlog -f filelist.f
vsim -l testbench.log -c filter_system_tb -voptargs=+acc -novopt -assertdebug -do "log -r -d 6 /*; add wave -r /*; radix -h; run -all" 
REM /// COPY FILE TXT DA XU LI VE THU MUC DATA_INOUT
copy text2img_sink.txt ..\data_inout\text2img_sink.txt

REM ///DUNG MATLAB DE XEM KET QUA CUA QUA TRINH
echo "Simulation is completed. See result at matlab directory!!!"

REM ///THONG BAO KET THUC QUA TRINH
matlab -nosplash -nodesktop -minimize -r "cd ../matlab; RGB_t2i('../data_inout/text2img_sink.txt');"
matlab -nosplash -nodesktop -minimize -r "cd ../matlab; imshow('../data_inout/edge_detection.png'); title('Original picture view on Matlab');;"
matlab -nosplash -nodesktop -minimize -r "cd ../matlab; sobel_filter('../data_inout/edge_detection.png');"



