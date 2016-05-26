$workingDir = [environment]::CurrentDirectory
$apr_url = "http://ftp.meisei-u.ac.jp/mirror/apache/dist//apr/apr-1.5.2-win32-src.zip" 
$aprutil_url = "http://ftp.meisei-u.ac.jp/mirror/apache/dist//apr/apr-util-1.5.4-win32-src.zip"
$log4cxx_url = "http://ftp.meisei-u.ac.jp/mirror/apache/dist/logging/log4cxx/0.10.0/apache-log4cxx-0.10.0.zip"


pushd $Env:SOURCE_FOLDER
md log4cxxWin32

(New-Object System.Net.WebClient).DownloadFile($apr_url, "apr.zip")
(New-Object System.Net.WebClient).DownloadFile($aprutil_url, "aprutil.zip")
(New-Object System.Net.WebClient).DownloadFile($log4cxx_url, "log4cxx.zip")

Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory("apr.zip","apr")
[System.IO.Compression.ZipFile]::ExtractToDirectory("aprutil.zip","apr-util")
[System.IO.Compression.ZipFile]::ExtractToDirectory("log4cxx.zip","log4cxx")

Move-Item -path $workingDir/apr/apr-1.5.2 -destination $Env:SOURCE_FOLDER/log4cxxWin32/apr
Move-Item -path $workingDir/apr-util/apr-util-1.5.4 -destination $Env:SOURCE_FOLDER/log4cxxWin32/apr-util
Move-Item -path $workingDir/log4cxx/apache-log4cxx-0.10.0 -destination $Env:SOURCE_FOLDER/log4cxxWin32/log4cxx

# cloning git repo into an already existing folder
cd log4cxxWin32
git init
git remote add origin git://github.com/aescande/log4cxxWin32.git
git fetch
git branch master origin/master
git checkout master

# restore initial directory
popd
