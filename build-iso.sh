#!/usr/bin/env sh

ksflatten -c custom-actual.ks -o ks.cfg && \
  ksflatten -c custom-live.ks -o custom-live-flat.ks && \
  mock -r fedora-25-x86_64 --init && \
  mock -r fedora-25-x86_64 --install spin-kickstarts pungi vim-minimal tree && \
  mock -r fedora-25-x86_64 --chroot -- 'mkdir -p /usr/share/lorax/templates.d/50-custom && cp -R /usr/share/lorax/templates.d/99-generic/* /usr/share/lorax/templates.d/50-custom'
  mock -r fedora-25-x86_64 --copyin ${PWD}/templates /tmp/ && \
  mock -r fedora-25-x86_64 --chroot -- 'cp -R /tmp/templates/* /usr/share/lorax/templates.d/50-custom'
  mock -r fedora-25-x86_64 --copyin ${PWD}/custom-live-flat.ks ${PWD}/gateway.pungi.conf ${PWD}/comps.xml ${PWD}/variants.xml ${PWD}/ks.cfg /tmp && \
  mock -r fedora-25-x86_64 --chroot -- mkdir -p /tmp/build && \
  mock -r fedora-25-x86_64 --chroot -- pungi-koji --target-dir /tmp/build --label Snapshot-1.0 --supported False --config /tmp/gateway.pungi.conf
