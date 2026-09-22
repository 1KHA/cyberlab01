FROM alpine:3.20
RUN apk add --no-cache bash coreutils sed openssl nano vim diffutils
COPY data/ /opt/lab-data/
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
WORKDIR /lab
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["bash"]
