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
EXPOSE 8000
#start app
CMD [ "python","app/main.py" ]
