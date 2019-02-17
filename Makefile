CFLAGS ?= -Os -std=gnu99 -Wall -Wextra -pedantic
LDFLAGS ?=

PROG := su-exec
SRCS := $(PROG).c

all: $(PROG)-shared $(PROG)-static

$(PROG)-shared: $(SRCS)
	$(CC) $(CFLAGS) -s -o $@ $^ $(LDFLAGS)
	ldd -v $@

$(PROG)-static: $(SRCS)
	$(CC) $(CFLAGS) -s -o $@ $^ $(LDFLAGS) -static
	# /bin/cp $(PROG)-static $(PROG)

clean:
	rm -f $(PROG) $(PROG)-shared $(PROG)-static
