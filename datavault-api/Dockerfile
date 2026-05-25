FROM python:3.12-slim
#create a working directory
WORKDIR /app
#copy requirements first
COPY app/requirements.txt . 
#install dependencies
RUN pip install --no-cache-dir -r requirements.txt
#copy all source code
COPY . . 
#expose application port
EXPOSE 8080
#start app
CMD [ "uvicorn","app.main:app","--host","0.0.0.0","--port","8080" ]
