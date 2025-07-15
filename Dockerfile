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

# Instalar Google Chrome (versão 138.0.7204.94 para compatibilidade com chromedriver)
RUN curl -LO https://storage.googleapis.com/chrome-for-testing-public/138.0.7204.94/linux64/chrome-linux64.zip && \
    unzip chrome-linux64.zip && \
    mv chrome-linux64 /opt/chrome && \
    ln -s /opt/chrome/chrome /usr/bin/google-chrome && \
    rm chrome-linux64.zip

# Instalar ChromeDriver correspondente
RUN curl -LO https://storage.googleapis.com/chrome-for-testing-public/138.0.7204.94/linux64/chromedriver-linux64.zip && \
    unzip chromedriver-linux64.zip && \
    mv chromedriver-linux64/chromedriver /usr/local/bin/chromedriver && \
    chmod +x /usr/local/bin/chromedriver && \
    rm -rf chromedriver-linux64*

# Instalar Selenium
RUN pip install --upgrade pip && \
    pip install selenium

RUN mkdir -p /app/.cache/selenium/chromedriver/linux64

WORKDIR /app
COPY test_selenium.py /app/test_selenium.py
COPY chromedriver /.cache/selenium/chromedriver/linux64/chromedriver

# Comando padrão: terminal interativo
CMD ["/bin/bash"]
