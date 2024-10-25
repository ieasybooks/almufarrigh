from contextlib import suppress
from importlib.metadata import PackageNotFoundError
from os import name as os_name
from shutil import which

from PyInstaller.building.api import COLLECT, EXE, PYZ
from PyInstaller.building.build_main import Analysis
from PyInstaller.building.osx import BUNDLE
from PyInstaller.utils.hooks import collect_data_files, copy_metadata

datas = []
datas += collect_data_files("whisper")
datas += collect_data_files("transformers", include_py_files=True)
datas += collect_data_files("torch")
with suppress(PackageNotFoundError):
    datas += copy_metadata("torch")
datas += copy_metadata("tqdm")
with suppress(PackageNotFoundError):
    datas += copy_metadata("numpy")
datas += copy_metadata("requests")
datas += copy_metadata("pydub")
datas += copy_metadata("auditok")
datas += copy_metadata("tafrigh")

binaries = []
if os_name == "nt":
    binaries += [("ffmpeg.exe", "."), ("ffprobe.exe", ".")]
else:
    datas += [(which("ffmpeg"), ".")]

a = Analysis(
    ["src/main.py"],
    pathex=[],
    binaries=binaries,
    datas=datas,
    hiddenimports=[],
    hookspath=[],
    hooksconfig={},
    win_no_prefer_redirects=False,
    win_private_assemblies=False,
    cipher=None,
    runtime_hooks=[],
    excludes=[
        "regex",
        "tkinter",
        "lib2to3",
        "unittest",
        "test",
        "websockets",
        "xmlrpc",
        "chardet",
        "pyreadline",
        "pycparser",
        "pydoc_data",
    ],
    noarchive=False,
)
pyz = PYZ(a.pure, a.zipped_data, cipher=None)

exe = EXE(
    pyz,
    a.scripts,
    [],
    name="AlMufarrigh",
    icon="./src/resources/images/icon.ico",
    exclude_binaries=True,
    debug=True,
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

coll = COLLECT(
    exe,
    a.binaries,
    a.zipfiles,
    a.datas,
    strip=False,
    upx=False,
    upx_exclude=[],
    name="almufarrigh",
)
app = BUNDLE(
    coll,
    name="AlMufarrigh.app",
    icon="./src/resources/images/icon.icns",
    bundle_identifier="com.almufarrigh",
    version="0.1.0",
    info_plist={
        "NSPrincipalClass": "NSApplication",
        "NSHighResolutionCapable": "True",
    },
)
