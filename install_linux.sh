#!/bin/bash

# install.sh
# Этот скрипт автоматизирует установку зависимостей и настройку проекта.

# Обновляем пакеты и устанавливаем необходимые зависимости
echo "Обновление пакетов и установка зависимостей..."
sudo apt-get update
sudo apt-get install -y build-essential cmake git

# Клонируем репозиторий (если скрипт запускается не из клонированного репозитория)
if [ ! -d "my-interesting-ideas" ]; then
    echo "Клонирование репозитория..."
    git clone https://github.com/zhdidoks123/my-interesting-ideas.git
    cd my-interesting-ideas
else
    echo "Репо уже клонирован, переходим в папку проекта..."
    cd my-interesting-ideas
fi

# Создаем папку для сборки (если используется CMake)
if [ -f "CMakeLists.txt" ]; then
    echo "Настройка CMake..."
    mkdir -p build
    cd build
    cmake ..
    make
    echo "Сборка завершена."
else
    echo "CMake не используется, пропускаем сборку."
fi

# Устанавливаем дополнительные зависимости (если есть)
if [ -f "requirements.txt" ]; then
    echo "Установка Python-зависимостей..."
    pip install -r requirements.txt
fi

echo "Установка завершена!"