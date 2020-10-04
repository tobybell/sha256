NAME = sha256

# Release products.
DST_BIN = dist/$(NAME)
DST_LICENSE = dist/LICENSE
DST_README = dist/README.md
DST = $(DST_BIN) $(DST_LICENSE) $(DST_README)

SOURCES = $(wildcard src/**/*.c) $(wildcard src/*.c)
OBJECTS = $(patsubst src/%.c,build/%.o,$(SOURCES))

LIBS = $(wildcard lib/*)
LIB_LINK = $(wildcard lib/*.a) $(wildcard lib/**/*.a)

INCLUDE = $(patsubst %,-I%,$(LIBS))

all: $(DST)

run: $(DST_BIN)
	$^

.SECONDEXPANSION:

$(DST_LICENSE): LICENSE
	cp $< $@

$(DST_README): README.md
	cp $< $@

$(DST_BIN): $(OBJECTS) $(LIB_LINK) | $$(@D)/.keep
	clang -std=c11 -o $@ $^

build/%.o: src/%.c | $$(@D)/.keep
	clang -std=c11 -O2 $(INCLUDE) -MD -o $@ -c $< 

.PRECIOUS: %/.keep

%/.keep:
	mkdir -p $(dir $@)
	@touch $@

clean:
	rm -rf $(DST) build

-include $(OBJECTS:.o=.d)
