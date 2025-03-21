import os 
import time as t


print("Welcome to the SosisonchikSoft 1.0!")
a = input("Enter the hash for connect to database: ")

if a == "18A218AD4ADA623035FA462D814E253E48752076271AD6363AF9B45BF4B619F7":
    print("Connecting..")
    t.sleep(2)
    print("50%..")
    t.sleep(0.2)
    print("60%..")
    t.sleep(0.2)
    print("67%..")
    t.sleep(0.2)
    print("73%..")
    t.sleep(0.2)
    print("96%..")
    t.sleep(0.2)
    print("100%")
    t.sleep(0.5)
    print("Connected!")
    os.system("python3 mmain.py")
if a == "exit":
    print("Bye!")
    t.sleep(1)
    os.close("sql.py")
if a == "auto-access":
    b = input("Enter the hash: ")

if b == "18A218AD4ADA623035FA462D814E253E48752076271AD6363AF9B45BF4B619F7":
    print("Connecting..")
    t.sleep(2)
    print("Accessing..")
    t.sleep(4)
    print("Done!")
    t.sleep(1)
    os.system("cls")
    os.system("python3 mmain.py")
