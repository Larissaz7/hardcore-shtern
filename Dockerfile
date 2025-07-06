# 1. Imagem Base
# Usamos uma imagem oficial do Python. A versão 'slim' é uma boa opção por ser leve.
# A imagem original 'phyton:3.13.5-alpine3.22' tinha um erro de digitação.
FROM python:3.13.4-alpine3.22


# 2. Diretório de Trabalho
# Define o diretório de trabalho para /app dentro do contêiner.
WORKDIR /app

# 3. Instalação de Dependências
# Copia o arquivo de requisitos primeiro para otimizar o cache de camadas do Docker.
# Assumindo que o Dockerfile está na raiz e o código em 'imersao-devops-main/'.
COPY ./imersao-devops-main/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 4. Cópia do Código da Aplicação
# Copia o código da sua aplicação para o diretório de trabalho.
COPY ./imersao-devops-main/ .

# 5. Exposição da Porta
# Expõe a porta 8000 para permitir a comunicação com a aplicação.
EXPOSE 8000

# 6. Comando de Execução
# Comando para iniciar a aplicação com Uvicorn.
# O host '0.0.0.0' torna a aplicação acessível externamente.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
