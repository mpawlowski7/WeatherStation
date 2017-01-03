#!/bin/bash

export ANDROID_SDK=/home/mipw/Android/Sdk
export ANDROID_NDK=/home/mipw/Android/Sdk/ndk-bundle
export ANT=/usr/bin/ant

mkdir build/android
cd build/android

cmake -DANDROID_ABI="armeabi-v7a" -DANDROID_NATIVE_API_LEVEL=android-13 -DCMAKE_TOOLCHAIN_FILE=../../thirdparty/qt-android-cmake/toolchain/android.toolchain.cmake ../..

make -j8
