FROM node:latest
RUN yarn global add elm --no-progress
RUN yarn global add create-elm-app --no-progress
RUN git clone https://github.com/obmarg/libsysconfcpus.git;
RUN cd libsysconfcpus && ./configure && make && make install && cd ../