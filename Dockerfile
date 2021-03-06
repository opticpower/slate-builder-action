FROM ruby:2.6-alpine
LABEL maintainer="developers@decathlon.com"
LABEL "com.github.actions.name"="Slate Documentation builder"
LABEL "com.github.actions.description"="Build repository md files using the slate framework"
LABEL "com.github.actions.icon"="book-open"
LABEL "com.github.actions.color"="blue"

ENV DOC_BASE_FOLDER=${DOC_BASE_FOLDER:-"/usr/src/doc"}
ENV ZIP_BUILD=${ZIP_BUILD:-"true"}

WORKDIR /usr/src/app

COPY scripts/*.sh /usr/src/scripts/

RUN gem install bundler

RUN apk --no-cache --update add nodejs g++ make coreutils git zip && \
    git clone https://github.com/slatedocs/slate.git /usr/src/app && \
    bundle install && \
    chmod +x /usr/src/scripts/*.sh
    
VOLUME ["/usr/src/doc"]

CMD ["sh", "/usr/src/scripts/build.sh"]
