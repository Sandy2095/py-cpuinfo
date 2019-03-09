#!/bin/bash
set -e

echo "Cleanup ..."
rm -rf -f build
rm -rf -f dist
rm -f *.spec
set +e
python2 -m pip uninstall PyInstaller -y > /dev/null 2>&1
python3 -m pip uninstall PyInstaller -y > /dev/null 2>&1
set -e

echo "Running Python 3 main ..."
python3 test_main.py

echo "Running Python 3 NO main ..."
python3 test_no_main.py

echo "Running Python 2 main ..."
python2 test_main.py

echo "Running Python 2 NO main ..."
python2 test_no_main.py

echo "Running Python 2 PyInstaller NO main ..."
python2 -m pip install PyInstaller > /dev/null 2>&1
~/.local/bin/pyinstaller --onefile test_no_main.py > /dev/null 2>&1
cd dist
./test_no_main
cd ..
rm -rf -f build
rm -rf -f dist

echo "Running Python 2 PyInstaller main ..."
~/.local/bin/pyinstaller --onefile test_main.py > /dev/null 2>&1
cd dist
./test_main
cd ..
rm -rf -f build
rm -rf -f dist
python2 -m pip uninstall PyInstaller -y > /dev/null 2>&1

echo "Running Python 3 PyInstaller NO main ..."
python3 -m pip install PyInstaller > /dev/null 2>&1
~/.local/bin/pyinstaller --onefile test_no_main.py > /dev/null 2>&1
cd dist
./test_no_main
cd ..
rm -rf -f build
rm -rf -f dist

echo "Running Python 3 PyInstaller main ..."
~/.local/bin/pyinstaller --onefile test_main.py > /dev/null 2>&1
cd dist
./test_main
cd ..
rm -rf -f build
rm -rf -f dist
python3 -m pip uninstall PyInstaller -y > /dev/null 2>&1

echo "Cleanup ..."
rm -rf -f build
rm -rf -f dist
rm -f *.spec
set +e
python2 -m pip uninstall PyInstaller -y > /dev/null 2>&1
python3 -m pip uninstall PyInstaller -y > /dev/null 2>&1
set -e
