TARGET = dist/sha256

SOURCES = $(wildcard src/**/*.c) $(wildcard src/*.c)
OBJECTS = $(patsubst src/%.c,build/%.o,$(SOURCES))

LIBS = $(wildcard lib/*)
LIB_LINK = $(wildcard lib/*.a) $(wildcard lib/**/*.a)

INCLUDE = $(patsubst %,-I%,$(LIBS))

all: $(TARGET)

run: $(TARGET)
	$^

.SECONDEXPANSION:

$(TARGET): $(OBJECTS) $(LIB_LINK) | $$(@D)/.keep
	clang -std=c11 -o $@ $^

build/%.o: src/%.c | $$(@D)/.keep
	clang -std=c11 -O2 $(INCLUDE) -MD -o $@ -c $< 

.PRECIOUS: %/.keep

%/.keep:
	mkdir -p $(dir $@)
	@touch $@

clean:
	rm -rf dist build

-include $(OBJECTS:.o=.d)
