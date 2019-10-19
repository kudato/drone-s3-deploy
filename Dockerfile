FROM kudato/baseimage:python3.7

RUN pip install --upgrade \
        python-magic \
        awscli

COPY plugin.sh /usr/bin/
RUN chmod +x /usr/bin/plugin.sh

WORKDIR /src
CMD [ "/usr/bin/plugin.sh" ]