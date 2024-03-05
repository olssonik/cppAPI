# Compiler
CXX = g++

# Compiler flags
CXXFLAGS = -Wall -Wextra -std=c++11

# Directories
SRCDIR = src
INCDIR = include
LIBDIR = lib
OUTPUTDIR = output

# Libraries
LIBS = -lcurl

# Source files
SRCS = $(wildcard $(SRCDIR)/*.cpp)

# Object files
OBJS = $(SRCS:$(SRCDIR)/%.cpp=$(OUTPUTDIR)/%.o)

# Executable
TARGET = $(OUTPUTDIR)/program

.PHONY: all clean run

all: $(TARGET)

$(TARGET): $(OBJS)
	@mkdir -p $(OUTPUTDIR)
	$(CXX) $(CXXFLAGS) -o $@ $^ -L$(LIBDIR) $(LIBS)

$(OUTPUTDIR)/%.o: $(SRCDIR)/%.cpp
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -c -o $@ $< -I$(INCDIR)

clean:
	rm -rf $(OUTPUTDIR) $(TARGET)

run: $(TARGET)
	@./$(TARGET)
