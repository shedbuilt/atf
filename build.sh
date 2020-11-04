#!/bin/bash
declare -A SHED_PKG_LOCAL_OPTIONS=${SHED_PKG_OPTIONS_ASSOC}
# Configure
for SHED_PKG_LOCAL_OPTION in "${!SHED_PKG_LOCAL_OPTIONS[@]}"; do
    case "$SHED_PKG_LOCAL_OPTION" in
        sun50ia64)
            SHED_PKG_ATF_PLATFORM='sun50i_a64'
            SHED_PKG_ATF_TARGET='bl31'
            SHED_PKG_ATF_PRODUCT='build/sun50i_a64/debug/bl31.bin'
            ;;
        rk3328)
            SHED_PKG_ATF_PLATFORM='rk3328'
            SHED_PKG_ATF_TARGET='bl31'
            SHED_PKG_ATF_PRODUCT='build/rk3328/debug/bl31/bl31.elf'
            ;;
    esac
done
# Build and Install
SHED_PKG_LOCAL_ATF_NAME=$(basename "$SHED_PKG_ATF_PRODUCT")
make PLAT="$SHED_PKG_ATF_PLATFORM" DEBUG=1 "$SHED_PKG_ATF_TARGET" &&
install -dm755 "${SHED_FAKE_ROOT}/boot/u-boot" &&
install -m644 "$SHED_PKG_ATF_PRODUCT" "${SHED_FAKE_ROOT}/boot/u-boot/${SHED_PKG_ATF_PLATFORM}-${SHED_PKG_LOCAL_ATF_NAME}"
