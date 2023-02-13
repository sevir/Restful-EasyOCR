#!/bin/bash
docker build . -t easyocr
docker tag easyocr sevir/restful-easyocr:latest