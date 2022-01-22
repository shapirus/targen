FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y cairosvg libsvg-perl && apt-get clean

WORKDIR /targen

COPY LICENSE README.md targen /targen/

RUN chmod a+x /targen/targen

RUN ( \
	echo "#!/bin/bash"; \
	echo; \
	echo '/targen/targen "$@" | cairosvg -f pdf -o - -') \
	> /targen/pdfwrapper.sh && chmod a+x /targen/pdfwrapper.sh

ENTRYPOINT /targen/pdfwrapper.sh "$@"
