# $Id$

WORK=work
TARGET=KeepVPN
APPBASE=$(WORK)/$(TARGET).app/Contents
CODEDIR=$(APPBASE)/MacOS
RESDIR=$(APPBASE)/Resources
DOC=Welcome.txt License.txt
SRC=src/vpnc src/keepvpn.pl src/keepvpn.sh src/settings src/startup
OBJ=$(CODEDIR)/vpnc $(CODEDIR)/keepvpn.pl $(CODEDIR)/keepvpn.sh $(CODEDIR)/settings $(CODEDIR)/startup

appdirs:
	-mkdir -p $(CODEDIR)
	-mkdir -p $(RESDIR)

appcopy: appdirs
	-cp $(SRC) $(CODEDIR)
	-cp $(DOC) $(RESDIR)
	-chmod +x $(OBJ)
	-cp Info.plist $(APPBASE)
	-tiff2icns KeepVPN.tiff $(RESDIR)/KeepVPN.icns

app: appcopy

all: app

archive: app
	-(cd $(WORK);zip $(TARGET) -r .)

clean:
	-rm -fr $(WORK)/
