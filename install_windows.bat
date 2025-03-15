@echo off
REM install.bat
REM Этот скрипт автоматизирует установку зависимостей и настройку проекта на Windows.

echo Обновление пакетов и установка зависимостей...

REM Устанавливаем Chocolatey (если еще не установлен)
if not exist "%ProgramData%\chocolatey\bin\choco.exe" (
    echo Установка Chocolatey...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"
)

REM Устанавливаем необходимые зависимости через Chocolatey
echo Установка build-essential, cmake и git...
choco install -y cmake git

REM Клонируем репозиторий (если скрипт запускается не из клонированного репозитория)
if not exist "my-interesting-ideas" (
    echo Клонирование репозитория...
    git clone https://github.com/zhdidoks123/my-interesting-ideas.git
    cd my-interesting-ideas
) else (
    echo Репо уже клонирован, переходим в папку проекта...
    cd my-interesting-ideas
)

REM Создаем папку для сборки (если используется CMake)
if exist "CMakeLists.txt" (
    echo Настройка CMake...
    mkdir build
    cd build
    cmake ..
    echo Сборка проекта...
    cmake --build .
    echo Сборка завершена.
) else (
    echo CMake не используется, пропускаем сборку.
)

REM Устанавливаем дополнительные зависимости (если есть)
if exist "requirements.txt" (
    echo Установка Python-зависимостей...
    pip install -r requirements.txt
)

echo Установка завершена!
pause