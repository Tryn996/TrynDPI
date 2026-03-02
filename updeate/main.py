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


def download_and_run():
    if not os.path.exists(VERSION_FILE):
        print(f"Ошибка: Файл не найден по пути {VERSION_FILE}")
        return

    with open(VERSION_FILE, "r") as f:
        vers = f.read().strip()

    FILE_NAME = f"TrynDPIupdeate{vers}.exe"
    FULL_PATH = os.path.join(FOLDER_NAME, FILE_NAME)

    try:
        url = f"https://github.com/Tryn996/TrynDPI/releases/download/{vers}/TrynDPI.exe"
        if os.path.exists(FULL_PATH):
            print(f"Файл {FILE_NAME} уже существует. Пропускаю скачивание.")
        else:
            print(f"Загрузка: {url}")
            if not os.path.exists(FOLDER_NAME):
                os.makedirs(FOLDER_NAME)

            response = requests.get(url, stream=True)
            response.raise_for_status()

            with open(FULL_PATH, "wb") as f:
                for chunk in response.iter_content(chunk_size=8192):
                    f.write(chunk)
            print("OK download")

        print("OK setup")
        silent_flags = ["/VERYSILENT"]
        subprocess.run([FULL_PATH] + silent_flags, shell=True)

    except Exception as e:
        print(f"Ошибка: {e}")


if __name__ == "__main__":
    download_and_run()

    APP_PATH = os.path.join(BASE_DIR, "TrynDPI.exe")

    if os.path.exists(APP_PATH):
        subprocess.Popen(
            [APP_PATH],
            shell=True,
            creationflags=subprocess.DETACHED_PROCESS | subprocess.CREATE_NEW_PROCESS_GROUP
        )
        print("Приложение запущено, скрипт закрывается.")
        sys.exit(0)
    else:
        print(f"Файл {APP_PATH} не найден.")