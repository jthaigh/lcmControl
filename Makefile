objects = build/DeviceInterface.o build/DeviceManager.o build/EthernetDevice.o\
          build/USBDevice.o build/EmulatedDevice.o build/RegMap.o build/EventPacket.o\
          build/Log.o build/Flash.o
CXXFLAGS=-fPIC -Isrc/ -Llib/ -std=c++11 -Iinclude\
	 -I/data/lbnedaq/products/boost/v1_57_0/source/boost_1_57_0/\
	 -L/data/lbnedaq/products/boost/v1_57_0/Linux64bit+2.6-2.12-e6-prof/lib/

all: libanlBoard_standalone.so lcmControl.exe

%.exe : app/%.cxx lib/libanlBoard_standalone.so
	$(CXX) $(CXXFLAGS) -lanlBoard_standalone -lftd2xx -lconfig++ -lboost_system -o bin/$@ $<

libanlBoard_standalone.so : $(objects)
	$(CXX) $(CXXFLAGS) --shared $(objects) -o lib/libanlBoard_standalone.so

build/%.o : src/%.cxx src/*.h
	$(CXX) -c $(CXXFLAGS) -o $@ $<

clean : 
	rm lib/libanlBoard_standalone.so; rm build/*.o; rm bin/*.exe
