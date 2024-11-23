# Используем минимальный образ Python на основе Alpine
FROM python:3.9-alpine

# Установка зависимостей
RUN apk add --no-cache --update \
    build-base \
    libffi-dev \
    postgresql-dev \
    gcc \
    musl-dev \
    && pip install --upgrade pip

# Создаем пользователя
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

# Устанавливаем рабочую директорию
WORKDIR /usr/src/app

# Копируем зависимости
COPY app/requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Копируем приложение
COPY app ./app

# Устанавливаем переменные окружения
ENV FLASK_APP=app
ENV FLASK_RUN_HOST=0.0.0.0

# Точка входа
COPY entrypoint.sh ./
RUN chmod +x ./entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
