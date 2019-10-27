GENERATED_DIR = ./Sourcery/Generated
SOURCES_DIR = ./Sourcery

all: 
	cd $(SOURCES_DIR) && bash run.sh

clear:
	rm -rf $(GENERATED_DIR)