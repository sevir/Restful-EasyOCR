#!/bin/bash
#docker run -i --rm --gpus all --privileged -p 2000:2000 -e SECRET_KEY=easyocr_vdt easyocr
docker run -i --rm -v ~/Downloads:/files -p 2000:2000 -e SECRET_KEY=easyocr_vdt easyocr