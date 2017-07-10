mkdir "c:/vagrant/files"

powershell -Command "Start-BitsTransfer -Source https://dev.ellisbs.co.uk/files/VSI_bundle.exe -Destination c:/vagrant/files/VSI_bundle.exe"
powershell -Command "Start-BitsTransfer -Source https://dev.ellisbs.co.uk/files/vcredist_x86_2013.zip -Destination c:/vagrant/files/vcredist_x86_2013.zip"
powershell -Command "Start-BitsTransfer -Source https://dev.ellisbs.co.uk/files/dotnetfx45_full_x86_x64.exe -Destination c:/vagrant/files/dotnetfx45_full_x86_x64.exe"

