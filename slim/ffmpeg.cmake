ExternalProject_Add(ffmpeg
    DEPENDS
        amf-headers
        nvcodec-headers
        bzip2
        openssl
        libass
        fontconfig
        harfbuzz
        opus
        vorbis
        dav1d
        libxml2
    GIT_REPOSITORY https://github.com/FFmpeg/FFmpeg.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--sparse --filter=tree:0"
    GIT_CLONE_POST_COMMAND "sparse-checkout set --no-cone /* !tests/ref/fate"
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} CONF=1 <SOURCE_DIR>/configure
        --cross-prefix=${TARGET_ARCH}-
        --prefix=${MINGW_INSTALL_PREFIX}
        --arch=${TARGET_CPU}
        --target-os=mingw32
        --pkg-config-flags=--static
        --enable-cross-compile
        --enable-runtime-cpudetect
        --enable-gpl
        --enable-version3
        --disable-everything
        --disable-doc
        --disable-avdevice
        --disable-encoders
        --disable-muxers
        --disable-devices
        --enable-decoder=h264,hevc,libdav1d,av1,vp8,vp9,mpeg1video,mpeg2video,mpeg4,msmpeg4v2,msmpeg4v3,wmv1,wmv2,wmv3,vc1,h263,h263p,rv30,rv40,theora,flv,mjpeg,png,rawvideo,aac,aac_latm,mp3,mp3float,ac3,eac3,dca,truehd,mlp,flac,opus,vorbis,alac,ape,mp2,wavpack,pcm_s16le,pcm_s24le,pcm_s32le,pcm_f32le,pcm_alaw,pcm_mulaw,ass,ssa,subrip,webvtt,movtext,pgssub,dvdsub,text
        --enable-parser=h264,hevc,av1,vp9,mpeg4video,mpegvideo,aac,aac_latm,ac3,dca,flac,opus,vorbis,mpegaudio
        --enable-demuxer=mov,matroska,mpegts,mpegps,flv,avi,asf,mp3,aac,ogg,flac,wav,hls,dash,image2,ass,srt,webvtt,rtsp,rtp,sdp,h264,hevc,mpegvideo,live_flv,concat,nut,loas
        --enable-protocol=file,pipe,http,https,tcp,tls,crypto,httpproxy,data,udp,rtp,rtmp,rtmps,rtmpt,concat
        --enable-filter=scale,format,aformat,aresample,null,copy,fps,trim,setpts,overlay,pad,crop,transpose,anull
        --enable-hwaccel=h264_d3d11va,h264_d3d11va2,h264_dxva2,h264_nvdec,hevc_d3d11va,hevc_d3d11va2,hevc_dxva2,hevc_nvdec,av1_d3d11va,av1_d3d11va2,av1_dxva2,av1_nvdec,vp9_d3d11va,vp9_d3d11va2,vp9_dxva2,vp9_nvdec,vp8_nvdec,mpeg2_d3d11va,mpeg2_d3d11va2,mpeg2_dxva2,mpeg2_nvdec,mpeg1_nvdec,mpeg4_nvdec,vc1_d3d11va,vc1_d3d11va2,vc1_dxva2,vc1_nvdec,wmv3_d3d11va,wmv3_d3d11va2,wmv3_dxva2,wmv3_nvdec,mjpeg_nvdec
        --enable-libass
        --enable-libdav1d
        --enable-openssl
        --enable-libopus
        --enable-libvorbis
        --enable-libxml2
        --disable-vdpau
        --disable-videotoolbox
        ${ffmpeg_lto}
        --extra-cflags='-Wno-error=int-conversion'
        "--extra-libs='${ffmpeg_extra_libs}'"
    BUILD_COMMAND ${MAKE}
    INSTALL_COMMAND ${MAKE} install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(ffmpeg)
cleanup(ffmpeg install)
