import os
import sys
import subprocess
import ctypes

def is_admin():
    try: return ctypes.windll.shell32.IsUserAnAdmin()
    except: return False

if not is_admin():
    ctypes.windll.shell32.ShellExecuteW(None, "runas", sys.executable, " ".join(sys.argv), None, 0)
    sys.exit()
if getattr(sys, 'frozen', False):
    BASE_DIR = os.path.dirname(sys.executable)
else:
    BASE_DIR = os.path.dirname(os.path.abspath(__file__))

BIN_DIR = os.path.join(BASE_DIR, "bin")
LISTS_DIR = os.path.join(BASE_DIR, "lists")
WINWS_PATH = os.path.join(BIN_DIR, "winws.exe")

def start_invisible_zapret():
    subprocess.run("taskkill /f /im winws.exe", shell=True, capture_output=True)
    args = [
        WINWS_PATH,
        "--wf-tcp=80,443,2053,2083,2087,2096,8443",
        "--wf-udp=443,19294-19344,50000-50100",
        "--filter-udp=443",
        f'--hostlist={LISTS_DIR}\\list-general.txt', f'--hostlist={LISTS_DIR}\\list-general-user.txt',
        f'--hostlist-exclude={LISTS_DIR}\\list-exclude.txt', f'--hostlist-exclude={LISTS_DIR}\\list-exclude-user.txt',
        f'--ipset-exclude={LISTS_DIR}\\ipset-exclude.txt', f'--ipset-exclude={LISTS_DIR}\\ipset-exclude-user.txt',
        "--dpi-desync=fake", "--dpi-desync-repeats=6", f'--dpi-desync-fake-quic={BIN_DIR}\\quic_initial_www_google_com.bin', "--new",
        "--filter-udp=19294-19344,50000-50100", "--filter-l7=discord,stun", "--dpi-desync=fake", "--dpi-desync-repeats=6", "--new",
        "--filter-tcp=2053,2083,2087,2096,8443", "--hostlist-domains=discord.media", "--dpi-desync=fake,fakedsplit",
        "--dpi-desync-repeats=6", "--dpi-desync-fooling=ts", "--dpi-desync-fakedsplit-pattern=0x00",
        f'--dpi-desync-fake-tls={BIN_DIR}\\tls_clienthello_www_google_com.bin', "--new",
        "--filter-tcp=443", f'--hostlist={LISTS_DIR}\\list-google.txt', "--ip-id=zero", "--dpi-desync=fake,fakedsplit",
        "--dpi-desync-repeats=6", "--dpi-desync-fooling=ts", "--dpi-desync-fakedsplit-pattern=0x00",
        f'--dpi-desync-fake-tls={BIN_DIR}\\tls_clienthello_www_google_com.bin', "--new",
        "--filter-tcp=80,443", f'--hostlist={LISTS_DIR}\\list-general.txt', f'--hostlist={LISTS_DIR}\\list-general-user.txt',
        f'--hostlist-exclude={LISTS_DIR}\\list-exclude.txt', f'--hostlist-exclude={LISTS_DIR}\\list-exclude-user.txt',
        f'--ipset-exclude={LISTS_DIR}\\ipset-exclude.txt', f'--ipset-exclude={LISTS_DIR}\\ipset-exclude-user.txt',
        "--dpi-desync=fake,fakedsplit", "--dpi-desync-repeats=6", "--dpi-desync-fooling=ts", "--dpi-desync-fakedsplit-pattern=0x00",
        f'--dpi-desync-fake-tls={BIN_DIR}\\stun.bin', f'--dpi-desync-fake-tls={BIN_DIR}\\tls_clienthello_www_google_com.bin',
        f'--dpi-desync-fake-http={BIN_DIR}\\tls_clienthello_max_ru.bin', "--new",
        "--filter-udp=443", f'--ipset={LISTS_DIR}\\ipset-all.txt',
        f'--hostlist-exclude={LISTS_DIR}\\list-exclude.txt', f'--hostlist-exclude={LISTS_DIR}\\list-exclude-user.txt',
        f'--ipset-exclude={LISTS_DIR}\\ipset-exclude.txt', f'--ipset-exclude={LISTS_DIR}\\ipset-exclude-user.txt',
        "--dpi-desync=fake", "--dpi-desync-repeats=6", f'--dpi-desync-fake-quic={BIN_DIR}\\quic_initial_www_google_com.bin', "--new",
        "--filter-tcp=80,443,8443", f'--ipset={LISTS_DIR}\\ipset-all.txt',
        f'--hostlist-exclude={LISTS_DIR}\\list-exclude.txt', f'--hostlist-exclude={LISTS_DIR}\\list-exclude-user.txt',
        f'--ipset-exclude={LISTS_DIR}\\ipset-exclude.txt', f'--ipset-exclude={LISTS_DIR}\\ipset-exclude-user.txt',
        "--dpi-desync=fake,fakedsplit", "--dpi-desync-repeats=6", "--dpi-desync-fooling=ts", "--dpi-desync-fakedsplit-pattern=0x00",
        f'--dpi-desync-fake-tls={BIN_DIR}\\stun.bin', f'--dpi-desync-fake-tls={BIN_DIR}\\tls_clienthello_www_google_com.bin',
        f'--dpi-desync-fake-http={BIN_DIR}\\tls_clienthello_max_ru.bin'
    ]

    try:
        subprocess.Popen(args, cwd=BIN_DIR, creationflags=0x08000000)
    except:
        pass

if __name__ == "__main__":
    start_invisible_zapret()
