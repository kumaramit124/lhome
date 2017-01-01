LIB= -loc -loctbstack -loc_logger -lconnectivity_abstraction -lcoap -ldigicloud  -lrt -lpthread -lc -ldl -lz -lc_common  
#LIB= -loc -loctbstack -loc_logger -lconnectivity_abstraction -lcoap -ldigicloud  -lrt -lxml2 -lpthread -lc -ldl -lz -lc_common -luuid  
#INCLUDELIB= -Llib  -Lernal/iotivity-1.1.1/out/linux/x86/release
INCLUDELIB= -Llib 
INCLUDEHEADER = -I/home/user/rpi/build/tmp/sysroots/raspberrypi/lib -I/home/user/rpi/build/tmp/sysroots/raspberrypi/usr/include -I/home/user/rpi/build/tmp/sysroots/raspberrypi/usr/include/iotivity/resource -I/home/user/rpi/build/tmp/sysroots/raspberrypi/usr/include/iotivity/resource/include/ -I/home/user/rpi/build/tmp/sysroots/raspberrypi/usr/include/iotivity/resource/csdk/stack/include -I/home/user/rpi/build/tmp/sysroots/raspberrypi/usr/include/iotivity/resource/csdk/ocrandom/include -I/home/user/rpi/build/tmp/sysroots/raspberrypi/usr/include/iotivity/resource/csdk/logger/include -I/home/user/rpi/build/tmp/sysroots/raspberrypi/usr/include/iotivity/resource/oc_logger/include -I/home/user/rpi/build/tmp/sysroots/raspberrypi/usr/include/iotivity/resource/c_common/ -Itestclient/cloud/digi_connector -Itestclient/resourcemgr -Itestclient/core -Itestclient/uimgr -Itestclient/databasemgr -Itestclient/intelligence -I/home/user/rpi/build/tmp/sysroots/raspberrypi/usr/include/iotivity/resource/stack -I/home/user/rpi/build/tmp/sysroots/raspberrypi/usr/include/iotivity/resource/oc_logger 
flag = -Wall -pthread -g -Wall -fPIC -DTB_LOG -DWITH_POSIX -D__linux__ -DIP_ADAPTER -DNO_EDR_ADAPTER -DNO_LE_ADAPTER

help:
	@cat README 
build_all:iotlib cloudlib client server uiapp
clean_all:clean_iotlib clean_cloudlib clean_client clean_server clean_uiapp

iotlib:
	sh install/iotivity_install.sh
cloudlib:
	make -C testclient/cloud/digi_connector

client:clean_client out/resource_xml.o out/client.o out/resource_list.o out/error_response_handler.o out/Main.o out/configuration.o out/MulticastRecv.o out/process_ui_request.o out/UiReceiver.o out/resource_database.o out/schedule_res.o out/power_analysys.o
	${CXX} -std=c++11 -o binary/ihome out/client.o out/resource_list.o out/Main.o  out/configuration.o out/MulticastRecv.o out/error_response_handler.o out/process_ui_request.o out/UiReceiver.o out/resource_xml.o  out/resource_database.o out/schedule_res.o out/power_analysys.o ${INCLUDELIB}  ${LIB} 	
out/resource_xml.o:
	${CXX} -std=c++11 ${flag} ${INCLUDELIB} ${INCLUDEHEADER} ${LIB} -o out/resource_xml.o -c testclient/databasemgr/resource_xml.cpp
out/resource_database.o:
	${CXX} -std=c++11 ${flag} ${INCLUDELIB} ${INCLUDEHEADER} ${LIB} -o out/resource_database.o -c testclient/databasemgr/resource_database.cpp
out/client.o:
	${CXX} -std=c++11 ${flag} ${INCLUDELIB} ${INCLUDEHEADER} ${LIB} -o out/client.o -c testclient/resourcemgr/client.cpp
out/resource_list.o:
	${CXX} -std=c++11 ${flag} ${INCLUDELIB} ${INCLUDEHEADER} ${LIB} -o out/resource_list.o -c testclient/resourcemgr/resource_list.cpp
out/error_response_handler.o:
	${CXX} -std=c++11 ${flag} ${INCLUDELIB} ${INCLUDEHEADER} ${LIB} -o out/error_response_handler.o -c testclient/resourcemgr/error_response_handler.cpp
out/Main.o:
	${CXX} -std=c++11 ${flag} ${INCLUDELIB} ${INCLUDEHEADER} ${LIB} -o out/Main.o -c testclient/core/Main.cpp
out/configuration.o:
	${CXX} -std=c++11 ${flag} ${INCLUDELIB} ${INCLUDEHEADER} ${LIB} -o out/configuration.o -c testclient/core/configuration.cpp
out/MulticastRecv.o:
	${CXX} -std=c++11 ${flag} ${INCLUDELIB} ${INCLUDEHEADER} ${LIB} -o out/MulticastRecv.o -c testclient/core/MulticastRecv.cpp
out/process_ui_request.o:
	${CXX} -std=c++11 ${flag} ${INCLUDELIB} ${INCLUDEHEADER} ${LIB} -o out/process_ui_request.o -c testclient/uimgr/process_ui_request.cpp
out/UiReceiver.o:
	${CXX} -std=c++11 ${flag} ${INCLUDELIB} ${INCLUDEHEADER} ${LIB} -o out/UiReceiver.o -c testclient/uimgr/UiReceiver.cpp
out/schedule_res.o:
	${CXX} -std=c++11 ${flag} ${INCLUDELIB} ${INCLUDEHEADER} ${LIB} -o out/schedule_res.o -c testclient/intelligence/schedule_res.cpp
out/power_analysys.o:
	${CXX} -std=c++11 ${flag} ${INCLUDELIB} ${INCLUDEHEADER} ${LIB} -o out/power_analysys.o -c testclient/intelligence/power_analysys.cpp

server:clean_server out/simpleserver.o out/getinterface.o out/hal.o out/MulticastTrans.o out/server_config.o
	${CXX} -std=c++11 ${flag} ${INCLUDELIB} ${INCLUDEHEADER} ${LIB} -o binary/simpleserver out/simpleserver.o out/getinterface.o out/hal.o out/MulticastTrans.o out/server_config.o ${INCLUDELIB}  ${LIB}
out/simpleserver.o:
	${CXX} -std=c++11 ${flag} ${INCLUDELIB} ${INCLUDEHEADER} ${LIB} -o out/simpleserver.o -c testserver/simpleserver.cpp
out/getinterface.o:
	${CXX} -std=c++11 ${flag} ${INCLUDELIB} ${INCLUDEHEADER} ${LIB} -o out/getinterface.o -c testserver/getinterface.cpp
out/hal.o:
	${CXX} -std=c++11 ${flag} ${INCLUDELIB} ${INCLUDEHEADER} ${LIB} -o out/hal.o -c testserver/hal.cpp
out/server_config.o:
	${CXX} -std=c++11 ${flag} ${INCLUDELIB} ${INCLUDEHEADER} ${LIB} -o out/server_config.o -c testserver/server_config.cpp
out/MulticastTrans.o:
	${CXX} -std=c++11 ${flag} ${INCLUDELIB} ${INCLUDEHEADER} ${LIB} -o out/MulticastTrans.o -c testserver/MulticastTrans.cpp

uiapp:clean_uiapp UIApp/UIApp.o
	${CXX} -std=c++11 ${flag} ${INCLUDELIB} ${INCLUDEHEADER} ${LIB} -o binary/testUIapp UIApp/UIApp.o ${INCLUDELIB}  ${LIB}
UIApp/UIApp.o:
	${CXX} -std=c++11 ${flag} ${INCLUDELIB} ${INCLUDEHEADER} ${LIB} -o UIApp/UIApp.o -c UIApp/UIApp.cpp

clean_uiapp:
	rm -f UIApp/UIApp.o binary/testUIapp
clean_client:
	rm -f out/* binary/ihome 
clean_server:
	rm -f out/* binary/simpleserver 
clean_cloudlib:
	make -C testclient/cloud/digi_connector clean
	rm -fr libdigicloud.a  lib/libdigicloud.so lib/libdigicloud.so.1 lib/libdigicloud.so.1.0  
clean_iotlib:
	rm -fr external/iotivity-0.9.2	
