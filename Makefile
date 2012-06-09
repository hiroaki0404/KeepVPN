# $Id$

APPBASE=work/KeepVPN.app/Contents
CODEDIR=$(APPBASE)/MacOS
RESDIR=$(APPBASE)/Resources
SRC=src/vpnc src/keepvpn.pl src/keepvpn.sh src/settings
OBJ=$(CODEDIR)/vpnc $(CODEDIR)/keepvpn.pl $(CODEDIR)/keepvpn.sh $(CODEDIR)/settings

appdirs:
	-mkdir -p $(CODEDIR)
	-mkdir -p $(RESDIR)

appcopy: appdirs
	-cp $(SRC) $(CODEDIR)
	-chmod +x $(OBJ)
	-cp Info.plist $(APPBASE)
	-tiff2icns KeepVPN.tiff $(RESDIR)/KeepVPN.icns

app: appcopy

all: app

clean:
	-rm -fr work/
