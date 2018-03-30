# CoreKit makefile

OS := $(shell uname -s)

ifeq ($(OS), Linux)
	#no extra flags on linux
endif

ifeq ($(OS), Darwin)
	FLAGS += -Xswiftc "-target" -Xswiftc "x86_64-apple-macosx10.13"
endif


all:
	swift build $(FLAGS)

clean:
	rm -r .build

test:
	swift test $(FLAGS)


docker:
	docker-compose run corekit-swift bash

lint:
	swiftlint autocorrect && swiftlint

docs:
	jazzy