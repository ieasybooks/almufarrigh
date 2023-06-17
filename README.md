# المفرّغ

[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/ieasybooks/almufarrigh/main.svg)](https://results.pre-commit.ci/latest/github/ieasybooks/almufarrigh/main)

الواجهة الرسومية الخاصة بأداة تفريغ على أنظمة التشغيل المختلفة

## خطوات التشغيل

نفذ الأمر التالي في داخل المجلد `src` لتوليد ملف الموارد
```bash
cd src
pyside6-rcc resources.qrc -o resources_rc.py
```
أو قم بتشغيل الملف الآتي:
```cmd
cd src
.\update_resources.bat
```
ثم قم بتشغل الملف الرئيسي:
```bash
python main.py
```
