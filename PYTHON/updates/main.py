import os
import sys
import requests
import subprocess
from lastversion import lastversion



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
    url = f"https://github.com/Tryn996/TrynDPI/releases/download/{vers}/TrynDPI.exe"
    if os.path.exists(FULL_PATH):
        pass
    else:
        if not os.path.exists(FOLDER_NAME):
            os.makedirs(FOLDER_NAME)
        response = requests.get(url, stream=True)
        response.raise_for_status()

        with open(FULL_PATH, "wb") as f:
            for chunk in response.iter_content(chunk_size=8192):
                f.write(chunk)
        subprocess.run(FULL_PATH)
        sys.exit()


if __name__ == "__main__":
    download_and_run()