#define MyAppName "TrynDPI"
#define MyAppVersion "4.2"
#define MyAppPublisher "Tryn"
#define MyAppURL "https://t.me/tryndpi"
#define MyAppExeName "TrynDPI.exe"

[Setup]
AppId={{C3DC6410-672F-4FF9-91E4-09F61D46032C}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppName}
UninstallDisplayIcon={app}\{#MyAppExeName}
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
PrivilegesRequiredOverridesAllowed=commandline
OutputDir=E:\Custom\EXPORT
OutputBaseFilename=TrynDPI
SetupIconFile=C:\Users\Tryn\Documents\tryn_vpn\res\icons\ext.ico
SolidCompression=yes
WizardStyle=modern dynamic

[Languages]
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "C:\Users\Tryn\Desktop\TrynDPI\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Tryn\Desktop\TrynDPI\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

