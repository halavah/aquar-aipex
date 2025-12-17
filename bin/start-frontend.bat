@echo off
chcp 65001 >nul

REM 切换到脚本所在目录
cd /d "%~dp0"

REM 返回项目根目录
cd ..

REM 进入 frontend 目录
cd frontend

REM Halavah's Tech Frontend 启动脚本
REM 用于 Windows 系统

echo ==================================
echo 🚀 Halavah's Tech Frontend 启动中...
echo ==================================

REM 检查 Node.js 是否安装
where node >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ 错误: Node.js 未安装
    echo 请访问 https://nodejs.org 下载并安装 Node.js
    pause
    exit /b 1
)

REM 显示 Node.js 版本
for /f "tokens=*" %%i in ('node --version') do set NODE_VERSION=%%i
echo 📦 Node.js 版本: %NODE_VERSION%

REM 检查 npm 是否安装
where npm >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ 错误: npm 未安装
    pause
    exit /b 1
)

REM 显示 npm 版本
for /f "tokens=*" %%i in ('npm --version') do set NPM_VERSION=%%i
echo 📦 npm 版本: %NPM_VERSION%
echo.

REM 检查是否已安装依赖
if not exist "node_modules" (
    echo 📥 正在安装项目依赖...
    echo.
    call npm install
    if %errorlevel% neq 0 (
        echo.
        echo ❌ 依赖安装失败，请检查网络连接
        pause
        exit /b 1
    )
    echo.
    echo ✅ 依赖安装完成
    echo.
)

REM 获取本机IP地址（Windows）
for /f "tokens=2 delims=:" %%i in ('ipconfig ^| findstr /i "IPv4"') do set LOCAL_IP=%%i
set LOCAL_IP=%LOCAL_IP: =%

REM 启动开发服务器
echo 🌐 启动 Vue 开发服务器...
echo.
echo 📍 本地访问地址: http://localhost:5173
if defined LOCAL_IP (
    echo 📍 网络访问地址: http://%LOCAL_IP%:5173
)
echo 📍 后端服务地址: http://localhost:9991
echo.
echo ⚠️  按 Ctrl+C 停止服务器
echo.
echo ==================================

call npm run dev

REM 如果出错，暂停以查看错误信息
if %errorlevel% neq 0 (
    echo.
    echo ❌ 服务器启动失败
    pause
)
