FROM ruby:2.6.6-alpine3.13

RUN apk add --update --no-cache \
      autoconf \
      bash \
      bison \
      boost-dev \
      build-base \
      ccache \
      cmake \
      curl \
      flex \
      g++ \
      gcc \
      git \
      glib-dev \
      gobject-introspection-dev \
      gzip \
      imagemagick \
      less \
      libc6-compat \
      libnsl-dev \
      libxml2-dev \
      libxslt-dev \
      linux-headers \
      make \
      meson \
      musl-dev \
      ninja \
      openssl-dev \
      pkgconfig \
      postgresql-dev \
      shared-mime-info \
      tzdata \
      wget \
      zlib-dev

ENV CC=gcc \
    CXX=g++ \
    ARROW_FLIGHT=OFF \
    ARROW_GANDIVA=OFF \
    ARROW_ORC=OFF \
    ARROW_PARQUET=ON \
    ARROW_BUILD_TESTS=ON \
    ARROW_HOME=/usr/local

RUN cd /usr/src && \
  wget https://downloads.apache.org/arrow/arrow-3.0.0/apache-arrow-3.0.0.tar.gz && \
  tar xf apache-arrow-3.0.0.tar.gz && \
  mv apache-arrow-3.0.0 arrow && \
  rm -f apache-arrow-3.0.0 && \
  cd arrow && \
  cd cpp && \
  mkdir release && \
  cd release && \
  cmake -GNinja -DARROW_DATASET=ON -DARROW_COMPUTE=ON -DARROW_JSON=ON -DARROW_PARQUET=ON -DARROW_CSV=ON .. && \
  ninja && \
  ninja install&& \
  cd /usr/src/arrow && \
 meson setup c_glib.build c_glib --buildtype=release -Darrow_cpp_build_dir=/usr/src/arrow/cpp/release && \
 meson compile -C c_glib.build && \
 meson install -C c_glib.build && \
 rm -rf /usr/src/arrow
