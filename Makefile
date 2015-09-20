CXXFLAGS = -std=c++11 -O2 -MMD -I ./deps
OBJECTS = src/text_encoding_detect.o src/Utils.o src/Converter.o src/main.o
DEPENDS = $(OBJECTS:.o=.d)
EXEC = srt-vtt
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S), Darwin)
	CXX = g++
	BIN = bin/Mac-OSX
else
	ifdef TRAVIS
		CXX= g++-5
	else
		CXX = g++
	endif
	UNAME_M := $(shell uname -m)
	BIN = bin/$(UNAME_S)/$(UNAME_M)
endif

all: $(EXEC)

$(EXEC) : $(OBJECTS)
	mkdir -p $(BIN)
	$(CXX) $(CXXFLAGS) $(OBJECTS) -o $(BIN)/$(EXEC)

clean :
	rm -rf $(DEPENDS) $(OBJECTS)

cleanall :
	rm -rf $(DEPENDS) $(OBJECTS) $(BIN)/$(EXEC)

-include $(DEPENDS)