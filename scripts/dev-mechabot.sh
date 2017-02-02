#!/bin/bash

pushd ~/code/mechabot
urxvt -e gengine-env &
popd

pushd ~/code/gengine-samples
urxvt -e gengine-env &
popd

pushd ~/code/gengine-samples/gengine
urxvt -e gengine-env &
popd
