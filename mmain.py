import os
import time as t
import sys
from datetime import datetime

# Изначально в списке только admin
users = ["admin"]

# История команд
command_history = []

# Функция для пинга хоста
def ping_host(host):
    response = os.system(f"ping -c 1 {host} > /dev/null 2>&1")
    if response == 0:
        print(f"{host} is up!")
    else:
        print(f"{host} is down!")

# Функция для шифрования файла (симуляция)
def encrypt_file(filename):
    print(f"Encrypting {filename}...")
    t.sleep(2)
    print(f"{filename} encrypted successfully!")

# Функция для расшифровки файла (симуляция)
def decrypt_file(filename):
    print(f"Decrypting {filename}...")
    t.sleep(2)
    print(f"{filename} decrypted successfully!")

# Функция для создания резервной копии
def create_backup():
    print("Creating backup...")
    t.sleep(2)
    print("Backup created successfully!")

# Функция для отображения статуса сервера
def show_status():
    uptime = t.time() - start_time
    print(f"Server Uptime: {uptime:.2f} seconds")
    print(f"Users Online: {len(users)}")

# Запуск времени сервера
start_time = t.time()

print("Welcome to the SosisonShell!")

while True:
    a = input("sosison-server@@USER $ ")

    # Добавление команды в историю
    command_history.append(a)

    if a == "help":
        print("help - show all commands")
        print("exit - exit from shell")
        print("clear - clear the screen")
        print("upload - updates the database (and logout)")
        print("access <args> - grant an access to the user")
        print("remove <args> - remove an access to the user")
        print("shutdown <db-hash> - shutdowns the server")
        print("restart <db-hash> - restarts the server (and logout)")
        print("root <user> <db-hash> - rooting user in database")
        print("list - show all users in the database")
        print("status - show server status")
        print("ping <host> - check if a host is reachable")
        print("history - show command history")
        print("backup - create a backup of the database")
        print("encrypt <file> - encrypt a file")
        print("decrypt <file> - decrypt a file")
        print("time - show current server time")
        print("users - show all users")
    elif a == "clear":
        os.system("clear")
    elif a == "upload":
        print("Updating..")
        print("Done")
        os.system("python3 sql.py")
    elif a == "exit":
        print("Bye!")
        t.sleep(1)
        sys.exit()
    elif a == "shutdown":
        print("Shutting down..")
        t.sleep(2)
        os.system("cls")
        sys.exit()
    elif a == "restart":
        print("Restarting..")
        t.sleep(2)
        os.system("clear")
        os.system("python3 sql.py")
    elif a.startswith("access"):
        if len(a.split()) > 1:
            user = a.split()[1]
            if user not in users:
                users.append(user)
                print(f"User {user} added successfully!")
            else:
                print(f"User {user} already exists!")
        else:
            print("Usage: access <username>")
    elif a.startswith("remove"):
        if len(a.split()) > 1:
            user = a.split()[1]
            if user in users:
                if user == "admin":
                    print("Cannot remove admin!")
                else:
                    users.remove(user)
                    print(f"User {user} removed successfully!")
            else:
                print(f"User {user} not found!")
        else:
            print("Usage: remove <username>")
    elif a.startswith("root"):
        if len(a.split()) > 2:
            user = a.split()[1]
            db_hash = a.split()[2]
            print(f"Rooting {user} in {db_hash}..")
            t.sleep(2)
            print("Rooted!")
        else:
            print("Usage: root <user> <db-hash>")
    elif a == "list":
        print("Users in the database:")
        for user in users:
            print(f"- {user}")
    elif a == "status":
        show_status()
    elif a.startswith("ping"):
        if len(a.split()) > 1:
            host = a.split()[1]
            ping_host(host)
        else:
            print("Usage: ping <host>")
    elif a == "history":
        print("Command History:")
        for i, cmd in enumerate(command_history, 1):
            print(f"{i}. {cmd}")
    elif a == "backup":
        create_backup()
    elif a.startswith("encrypt"):
        if len(a.split()) > 1:
            filename = a.split()[1]
            encrypt_file(filename)
        else:
            print("Usage: encrypt <file>")
    elif a.startswith("decrypt"):
        if len(a.split()) > 1:
            filename = a.split()[1]
            decrypt_file(filename)
        else:
            print("Usage: decrypt <file>")
    elif a == "time":
        now = datetime.now()
        print(f"Current Server Time: {now.strftime('%Y-%m-%d %H:%M:%S')}")
    elif a == "users":
        print("List of all users:")
        for user in users:
            print(f"- {user}")
    else:
        print("Unknown command. Type 'help' for a list of commands.")