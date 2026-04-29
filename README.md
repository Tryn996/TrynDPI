<p align="center">
      <img src="https://github.com/Tryn996/TryProxy/blob/main/GIT/back4.png" width="726">
</p>
<p align="center">
  <a href="https://github.com/Tryn996/TrynDPI/releases/latest">
    <kbd>
      <img height="40" src="https://github.com/Tryn996/TryProxy/blob/main/GIT/doc256.png" style="social: invert(100%);">
      &nbsp; RELEASES &nbsp;
    </kbd>
  </a>
      
  <a href="https://github.com/Tryn996/TryProxy/blob/main/windows.py">
    <kbd>
      <img height="40" src="https://github.com/Tryn996/TryProxy/blob/main/GIT/ext256.png" style="social: invert(100%);">
      &nbsp; PROXY SOURCE CODE &nbsp;
    </kbd>
  </a>

# TrynDPI

A graphical interface for managing DPI bypass tools on Windows, built with the Godot Engine and Python backend.

## Project Structure

The application is divided into several functional modules:

*   **Main GUI (Godot)**: Handles the primary UI, process execution, and status monitoring.
*   **Bypass Engine (Python)**: Manages complex DPI desync configurations and administrative privileges.
*   **Update System (Python)**: Automates version checking and asset downloading from GitHub Releases.
*   **Initialization & State**: Manages persistent user settings and window behavior.

## Technical Reference

### Python Backend Components

The Python scripts handle low-level system operations and update logic:

*   **`bypass.py`**: Requests Administrator privileges and launches `winws.exe` with optimized desync arguments for Discord, YouTube, and general web traffic.
*   **`main.py` / `updeate.py`**: Utilizes the `lastversion` library to fetch the latest release tag from GitHub and handles the download of updated binaries.

### Settings and State (Godot)


| Property | Type | Description |
| :--- | :--- | :--- |
| setting_start | int | Toggle for automatic proxy activation on launch. |
| avtoload | int | Controls Windows startup (Registry) integration. |
| transp | int | Toggles UI transparency and background effects. |
| upavt | int | Auto-update check preference. |

### Global Constants and Paths

Configuration snippet from `global.gd` and `bypass.py`:

```gdscript
# Godot Pathing
var path = (OS.get_executable_path().get_base_dir() + "/data/DPI_OSNOV.exe")
var vers = "2026.27.04/v4.5.1"
```

```python
# Python Pathing
BIN_DIR = os.path.join(BASE_DIR, "bin")
LISTS_DIR = os.path.join(BASE_DIR, "lists")
WINWS_PATH = os.path.join(BIN_DIR, "winws.exe")
```

## Documentation

### Features

*   **Administrative Elevation**: `bypass.py` automatically checks for admin rights and re-runs with elevation if necessary for network filtering.
*   **Stealth Execution**: Proxy processes are launched using the `0x08000000` (CREATE_NO_WINDOW) flag to remain invisible to the user.
*   **Automated Lifecycle**: 
    *   `updeate.py` synchronizes the local `vers.txt` with the latest GitHub release.
    *   `main.py` handles the secure download and execution of update packages.
*   **Custom DPI Strategies**: Implements advanced desync patterns (fake, fakedsplit, ts) targeted at specific L7 protocols like Discord and STUN.

### Core Methods (Bypass Engine)

```python
# Launching the bypass with custom hostlists and desync patterns
def start_invisible_zapret():
    subprocess.run("taskkill /f /im winws.exe", shell=True, capture_output=True)
    args = [
        WINWS_PATH,
        "--wf-tcp=80,443,2053,2083,2087,2096,8443",
        "--dpi-desync=fake", "--dpi-desync-repeats=6",
        f'--hostlist={LISTS_DIR}\\list-general.txt'
    ]
    subprocess.Popen(args, cwd=BIN_DIR, creationflags=0x08000000)
```

### Core Methods (Updater)

```python
# Fetching latest release and executing update
def download_and_run():
    vers = "v" + str(lastversion.latest("Tryn996/TrynDPI"))
    url = f"https://github.com/Tryn996/TrynDPI/releases/download/{vers}/TrynDPI.exe"
    response = requests.get(url, stream=True)
    # ... file writing logic ...
    subprocess.run(FULL_PATH)
```
