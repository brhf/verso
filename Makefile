version = 0.0.0
sdistfiles = verso.pl verso.conf verso.desktop README.md Makefile LICENSE.txt

bin = $(DESTDIR)/usr/bin/verso
conf = $(DESTDIR)/etc/verso.conf
desktop = $(DESTDIR)/usr/share/applications/verso.desktop
man = $(DESTDIR)/usr/share/man/man1/verso.1.gz

.PHONY: all
all: verso.1.gz

.PHONY: sdist
sdist: dist/verso-$(version).tar.gz

dist/verso-$(version).tar.gz: $(sdistfiles)
	@mkdir -p dist/verso-$(version)/
	@cp $^ dist/verso-$(version)/
	@tar -C dist/ -czf $@ verso-$(version)/

verso.1.gz: verso.pl
	@pod2man $^ | gzip -9 > $@

.PHONY: install
install: verso.pl verso.conf verso.desktop verso.1.gz
	@install -Dm 755 verso.pl $(bin)
	@install -Dm 644 verso.conf $(conf)
	@install -Dm 644 verso.desktop $(desktop)
	@install -Dm 644 verso.1.gz $(man)

.PHONY: clean
clean:
	@rm -rf verso.1.gz dist/

.PHONY: uninstall
uninstall:
	@rm -f $(bin) $(desktop) $(man)

.PHONY: purge
purge: uninstall
	@rm -f $(conf)

