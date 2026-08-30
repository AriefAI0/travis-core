FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Setup gstreamer installation
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
         build-essential cmake pkg-config ca-certificates curl \
         libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev \
         gstreamer1.0-plugins-base gstreamer1.0-plugins-good \
         gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav \
         gstreamer1.0-tools \
    && rm -rf /var/lib/apt/lists/*

# Sanity gate: fail the build if any required GStreamer element is absent.
RUN gst-inspect-1.0 srtsrc >/dev/null \
    && gst-inspect-1.0 tsparse >/dev/null \
    && gst-inspect-1.0 matroskamux >/dev/null

# PORT LISTENER
EXPOSE 9191 
