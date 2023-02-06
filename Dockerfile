FROM voduytuan/restful-easyocr

# if you forked EasyOCR, you can pass in your own GitHub username to use your fork
# i.e. gh_username=myname
ARG gh_username=JaidedAI
ARG service_home="/home/EasyOCR"

# Configure apt and install packages
# RUN apt-get update -y && \
#     apt-get install -y \
#     libglib2.0-0 \
#     libsm6 \
#     libxext6 \
#     libxrender-dev \
#     libgl1-mesa-dev \
#     git \
#     # cleanup
#     && apt-get autoremove -y \
#     && apt-get clean -y \
#     && rm -rf /var/lib/apt/li

# Clone EasyOCR repo
RUN rm -rf "$service_home" && mkdir "$service_home" \
    && git clone "https://github.com/$gh_username/EasyOCR.git" "$service_home" \
    && cd "$service_home" \
    && git remote add upstream "https://github.com/JaidedAI/EasyOCR.git" \
    && git pull upstream master

# Build
RUN cd "$service_home" \
    && python setup.py build_ext --inplace -j 4 \
    && python -m pip install -e .

RUN pip install Flask

RUN pip3 install --upgrade pip && pip3 install packaging

RUN apt-get update --fix-missing -y && apt-get install -y poppler-utils \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/li

ADD ./recognition.py /home/ubuntu/
WORKDIR /home/ubuntu/

EXPOSE 2000
RUN alias python=python3
ENTRYPOINT ["python"]
CMD ["/home/ubuntu/recognition.py"]