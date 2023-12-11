from os import name as os_name

from PyInstaller.building.api import EXE, PYZ
from PyInstaller.building.build_main import Analysis

datas = [
    ("src/qml", "qml/"),
    ("src/resources", "resources/"),
    ("src/resources_rc.py", "."),
]
binaries = []
hidden_imports = [
    "auditok",
    "numpy",
    "pydub",
    "requests",
    "scipy",
    "tqdm",
    "whisper",
    "faster-whisper",
]
if os_name == "nt":
    binaries += [("ffmpeg.exe", "."), ("ffprobe.exe", ".")]

a = Analysis(
    ["src/main.py"],
    pathex=[],
    binaries=binaries,
    datas=datas,
    hiddenimports=hidden_imports,
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[],
    noarchive=False,
)
pyz = PYZ(a.pure)

exe = EXE(
    pyz,
    a.scripts,
    a.binaries,
    a.datas,
    [],
    name="AlMufarrigh",
    icon="./src/resources/images/icon.ico",
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    upx_exclude=[],
    runtime_tmpdir=None,
    console=False,
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
)
