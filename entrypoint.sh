#!/bin/sh
flask db upgrade  # Выполняем миграции
flask run
