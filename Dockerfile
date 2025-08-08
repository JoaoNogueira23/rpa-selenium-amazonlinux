FROM amazonlinux:2023

# Instalar dependências
RUN yum update -y && \
    yum install -y --allowerasing \
    gcc openssl-devel bzip2-devel libffi-devel wget curl unzip tar gzip \
    zlib-devel dnf

# Instalar Python 3.11
RUN curl -O https://www.python.org/ftp/python/3.11.7/Python-3.11.7.tgz && \
    tar xzf Python-3.11.7.tgz && \
    cd Python-3.11.7 && \
    ./configure --enable-optimizations && \
    make -j$(nproc) && \
    make altinstall && \
    ln -s /usr/local/bin/python3.11 /usr/bin/python && \
    ln -s /usr/local/bin/pip3.11 /usr/bin/pip

# Instalar Selenium
RUN pip install --upgrade pip && \
    pip install selenium

WORKDIR /app
COPY test_selenium.py /app/test_selenium.py

# Comando padrão: terminal interativo
CMD ["/bin/bash"]
