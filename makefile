TARGETDIR=$(HOME)
export TARGETDIR

main:
	@echo "No default action specified."
	@echo ""
	@echo "Use make install to install all scripts to TARGETDIR (default $(TARGETDIR))"
	@echo ""
	@echo "Use make install-* to install particular script to TARGETDIR (default $(TARGETDIR))"
	@echo "  install-bashrc      install bashrc"
	@echo "  install-vimrc       install vimrc"

install: install-vimrc install-bashrc

install-before:
	@echo "Installing..."
	mkdir -p $(TARGETDIR)

install-vimrc: install-before
	cp -f vimrc $(TARGETDIR)/.vimrc  

install-bashrc: install-before
	cp -n bash_config $(TARGETDIR)/.bash_config
	cp -rf bash_plugins/* $(TARGETDIR)/.bash_plugins
	cp -f bashrc $(TARGETDIR)/.bashrc
