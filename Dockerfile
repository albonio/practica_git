# La imagen base va a ser la de Python 3.10
FROM python:3.10-slim

WORKDIR /app

# Copiamos el archivo requirements.txt en el directorio de trabajo
COPY requirements.txt .

# Instalamos las dependencias del requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copiamos el main.py en el directorio de trabajo
COPY main.py .

# Comando para ejecutar el script
CMD ["python", "main.py"]
