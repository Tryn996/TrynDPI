import os
import sys
import requests
import subprocess


def get_base_path():
    if getattr(sys, 'frozen', False):
        return os.path.dirname(sys.executable)
    return os.path.dirname(os.path.abspath(__file__))

BASE_DIR = get_base_path()
VERSION_FILE = os.path.join(BASE_DIR, "vers.txt")
FOLDER_NAME = os.path.join(BASE_DIR, "Updates")
FILE_NAME = "TrynDPIupdeate.exe"
FULL_PATH = os.path.join(FOLDER_NAME, FILE_NAME)


def download_and_run():
    if not os.path.exists(VERSION_FILE):
        print(f"Ошибка: Файл не найден по пути {VERSION_FILE}")
        return

    try:
        with open(VERSION_FILE, "r") as f:
            vers = f.read().strip()

        url = f"https://github.com/Tryn996/TrynDPI/releases/download/{vers}/TrynDPI.exe"

        if not os.path.exists(FOLDER_NAME):
            os.makedirs(FOLDER_NAME)

        response = requests.get(url, stream=True)
        response.raise_for_status()

        with open(FULL_PATH, "wb") as f:
            for chunk in response.iter_content(chunk_size=8192):
                f.write(chunk)

        silent_flags = ["/VERYSILENT", "/SUPPRESSMSGBOXES"]
        subprocess.run([FULL_PATH] + silent_flags, shell=True)

    except Exception as e:
        print(f"Ошибка: {e}")


if __name__ == "__main__":
    download_and_run()
