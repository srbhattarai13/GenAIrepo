FROM --platform=linux/amd64 python:3.9
WORKDIR /app

COPY jdk-21.0.2 /opt/java/openjdk
ENV JAVA_HOME=/opt/java/openjdk
ENV PATH="${JAVA_HOME}/bin:${PATH}"

RUN apt-get update && apt-get install -y poppler-utils
RUN apt-get install -y graphviz
COPY . /app
# COPY ./requirements.txt /app/requirements.txt
RUN pip install -r requirements.txt

EXPOSE 8501
 
HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health
 
ENTRYPOINT ["streamlit", "run", "main.py", "--server.port=8501", "--server.address=0.0.0.0"]
