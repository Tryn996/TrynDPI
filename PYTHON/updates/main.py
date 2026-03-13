import os
import sys
import requests
import subprocess
from lastversion import lastversion

def main():
    arguments = sys.argv[1:]

    if "--vers" in arguments:
        print("Запуск в режиме администратора")

    if len(arguments) > 0:
        vers = "v" + str(lastversion.latest("Tryn996/TrynDPI"))
        with open("vers.txt", "w", encoding="utf-8") as file:
            file.write(vers)
    else:
        download_and_run()


def get_base_path():
    if getattr(sys, 'frozen', False):
        return os.path.dirname(sys.executable)
    return os.path.dirname(os.path.abspath(__file__))


BASE_DIR = get_base_path()
FOLDER_NAME = os.path.join(BASE_DIR, "vers")


def download_and_run():
    vers = "v" + str(lastversion.latest("Tryn996/TrynDPI"))
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
        subprocess.run(FULL_PATH,shell=True)

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