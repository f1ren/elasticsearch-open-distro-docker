FROM amazon/opendistro-for-elasticsearch:1.0.1

ENV AWS_ACCESS_KEY_ID AKIA2QQDWN2TYLUU4XSY
ENV AWS_SECRET_ACCESS_KEY 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

RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch repository-s3
RUN /usr/share/elasticsearch/bin/elasticsearch-keystore create

RUN echo $AWS_ACCESS_KEY_ID | /usr/share/elasticsearch/bin/elasticsearch-keystore add --stdin s3.client.default.access_key
RUN echo $AWS_SECRET_ACCESS_KEY | /usr/share/elasticsearch/bin/elasticsearch-keystore add --stdin s3.client.default.secret_key

