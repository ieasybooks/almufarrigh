"""CX_Freeze setup script for building the application."""
import sys
from pathlib import Path

import cx_Freeze

__version__ = "1.0.6"
base = None
include_files: list[str | tuple[str, str]] = []
ffmpeg_files: list[str] = ["ffmpeg.exe", "ffprobe.exe"]

if sys.platform == "win32":
    base = "Win32GUI"
    for file in ffmpeg_files:
        if (Path(__file__).parent / file).exists():
            include_files.append(file)

includes = ["src"]
excludes = [
    # remove unnecessary modules from the executable to reduce its size
    "mypy",
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
]


cx_Freeze.setup(
    name="المفرغ Al Mufarrigh",
    description="تحويل الملفات الصوتية إلى نصوص بسهولة ومجانًا.",
    version=__version__,
    executables=[
        cx_Freeze.Executable(
            "src/main.py",
            base=base,
            target_name="المفرغ Al Mufarrigh",
            trademarks="Copyright © 2022-2023 almufaragh.com.",
            icon="src/resources/images/logo.ico",
            shortcut_name="المفرغ",
            shortcut_dir="DesktopFolder",
        )
    ],
    options={
        "build_exe": {
            # "packages": packages,
            "includes": includes,
            "include_files": include_files,
            "include_msvcr": True,
            "excludes": excludes,
        },
        "bdist_msi": {
            "upgrade_code": "{00EF338F-794D-3AB8-8CD6-2B0AB7541021}",
            "add_to_path": False,
            "initial_target_dir": r"[ProgramFilesFolder]\almufarrigh",
            "install_icon": "src/resources/images/logo.ico",
        },
        "bdist_mac": {
            # "iconfile": "src/resources/images/logo.icns",
            "bundle_name": "المفرغ Al Mufarrigh",
        },
        "bdist_dmg": {
            "volume_label": "Install المفرغ Al Mufarrigh",
            "applications_shortcut": True,
        },
    },
)
