@echo off
chcp 65001 >nul

REM 切换到脚本所在目录
cd /d "%~dp0"

REM 返回项目根目录
cd ..

REM 进入 backend 目录
cd backend

REM Halavah's Tech Backend 启动脚本
REM 用于 Windows 系统

echo ==================================
echo 🚀 Halavah's Tech Backend 启动中...
echo ==================================

REM 检查 Maven 是否安装
where mvn >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ 错误: Maven 未安装
    echo 请访问 https://maven.apache.org 下载并安装 Maven
    pause
    exit /b 1
)

REM 显示 Maven 版本
for /f "tokens=*" %%i in ('mvn --version ^| findstr /C:"Apache Maven"') do set MAVEN_VERSION=%%i
echo 📦 %MAVEN_VERSION%
echo.

REM 检查 Java 是否安装
where java >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ 错误: Java 未安装
    echo 请访问 https://adoptium.net 下载并安装 Java
    pause
    exit /b 1
)

REM 显示 Java 版本
for /f "tokens=*" %%i in ('java -version 2^>^&1 ^| findstr /C:"version"') do set JAVA_VERSION=%%i
echo 📦 %JAVA_VERSION%
echo.

REM 获取本机IP地址（Windows）
for /f "tokens=2 delims=:" %%i in ('ipconfig ^| findstr /i "IPv4"') do set LOCAL_IP=%%i
set LOCAL_IP=%LOCAL_IP: =%

REM 启动 Spring Boot 开发服务器
echo 🌐 启动 Spring Boot 服务器...
echo.
echo 📍 本地访问地址: http://localhost:9991
if defined LOCAL_IP (
    echo 📍 网络访问地址: http://%LOCAL_IP%:9991
)
echo.
echo ⚠️  按 Ctrl+C 停止服务器
echo.
echo ==================================

call mvn spring-boot:run

REM 如果出错，暂停以查看错误信息
if %errorlevel% neq 0 (
    echo.
    echo ❌ 服务器启动失败
    pause
)
