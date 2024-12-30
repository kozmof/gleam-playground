FROM rust:latest

# Build Gleam from source
# https://gleam.run/getting-started/installing/
RUN cd /tmp && \
  git clone https://github.com/gleam-lang/gleam.git --branch v1.6 && \
  cd gleam && \
  make install

# Build Erlang from source
# https://www.erlang.org/downloads#source
RUN cd /tmp && \
  git clone https://github.com/erlang/otp otp_src_27.2 && \
  cd otp_src_27.2 && \
  export ERL_TOP=`pwd` && \
  ./configure && make && make install

# Install Node.js to use `gleam run --target javascript`
RUN cd /tmp && \
  curl -fsSL https://deb.nodesource.com/setup_23.x -o nodesource_setup.sh && \
  bash nodesource_setup.sh && \
  apt-get install -y nodejs

# Clean up
RUN cd /tmp && \
  rm -rf gleam && \
  rm -rf otp_src_27.2 && \
  rm nodesource_setup.sh
