


rm -rf -f bin
rm -rf -f dist
python2 -m pip uninstall PyInstaller
python3 -m pip uninstall PyInstaller

python2 -m pip install PyInstaller
~/.local/bin/pyinstaller --onefile test_no_main.py
cd dist
./test_no_main
cd ..
rm -rf -f bin
rm -rf -f dist

~/.local/bin/pyinstaller --onefile test_main.py
cd dist
./test_main
cd ..
rm -rf -f bin
rm -rf -f dist
python2 -m pip uninstall PyInstaller

python3 -m pip install PyInstaller
~/.local/bin/pyinstaller --onefile test_no_main.py
cd dist
./test_no_main
cd ..
rm -rf -f bin
rm -rf -f dist

~/.local/bin/pyinstaller --onefile test_main.py
cd dist
./test_main
cd ..
rm -rf -f bin
rm -rf -f dist
python3 -m pip uninstall PyInstaller
