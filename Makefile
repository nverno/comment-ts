SHELL   =  /bin/bash

TSDIR   ?= $(CURDIR)/tree-sitter-comment
TESTDIR ?= $(TSDIR)/examples

.PHONY: parse-% all clean dev test
all:
	@

dev: $(TSDIR)
$(TSDIR):
	@git clone --depth=1 https://github.com/stsewd/tree-sitter-comment
	@printf "\e[1m\e[31mNote\e[22m npm build can take a while\e[0m\n" >&2
	cd $(TSDIR) &&                                         \
		npm --loglevel=info --progress=true install && \
		npm run generate

parse-%:
	cd $(TSDIR) && npx tree-sitter parse $(TESTDIR)/$(subst parse-,,$@)

clean:
	$(RM) -r *~

distclean: clean
	$(RM) -rf $$(git ls-files --others --ignored --exclude-standard)
