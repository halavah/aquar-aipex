# ========================================
# Halavah's Tech Frontend 启动脚本 (PowerShell)
# ========================================

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# 切换到脚本所在目录
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $ScriptDir

# 返回项目根目录
Set-Location (Join-Path $ScriptDir "..")

# 进入 frontend 目录
Set-Location "frontend"

Write-Host "=================================="
Write-Host "🚀 Halavah's Tech Frontend 启动中..."
Write-Host "=================================="
Write-Host ""

# 检查 Node.js 是否安装
$nodeExists = Get-Command node -ErrorAction SilentlyContinue
if (-not $nodeExists) {
    Write-Host "❌ 错误: Node.js 未安装" -ForegroundColor Red
    Write-Host "请访问 https://nodejs.org 下载并安装 Node.js"
    Read-Host "按回车键退出"
    exit 1
}

# 显示 Node.js 版本
$nodeVersion = node --version
Write-Host "📦 Node.js 版本: $nodeVersion"

# 检查 npm 是否安装
$npmExists = Get-Command npm -ErrorAction SilentlyContinue
if (-not $npmExists) {
    Write-Host "❌ 错误: npm 未安装" -ForegroundColor Red
    Read-Host "按回车键退出"
    exit 1
}

# 显示 npm 版本
$npmVersion = npm --version
Write-Host "📦 npm 版本: $npmVersion"
Write-Host ""

# 检查是否已安装依赖
if (-not (Test-Path "node_modules")) {
    Write-Host "📥 正在安装项目依赖..."
    Write-Host ""
    npm install
    if ($LASTEXITCODE -ne 0) {
        Write-Host ""
        Write-Host "❌ 依赖安装失败，请检查网络连接" -ForegroundColor Red
        Read-Host "按回车键退出"
        exit 1
    }
    Write-Host ""
    Write-Host "✅ 依赖安装完成"
    Write-Host ""
}

# 获取本机IP地址（跨平台）
$LOCAL_IP = $null
if ($IsWindows) {
    $ipAddresses = Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.IPAddress -notlike "127.*" } | Select-Object -ExpandProperty IPAddress
    if ($ipAddresses) {
        $LOCAL_IP = $ipAddresses[0]
    }
} else {
    $ipAddresses = (Get-NetIPAddress -AddressFamily IPv4 2>$null) ?: (ifconfig 2>$null | Select-String "inet " | Select-Object -First 1)
    if ($ipAddresses) {
        $LOCAL_IP = ($ipAddresses -split '\s+')[2]
    }
}

# 启动开发服务器
Write-Host "🌐 启动 Vue 开发服务器..."
Write-Host ""
Write-Host "📍 本地访问地址: http://localhost:5173"
if ($LOCAL_IP) {
    Write-Host "📍 网络访问地址: http://${LOCAL_IP}:5173"
}
Write-Host "📍 后端服务地址: http://localhost:9991"
Write-Host ""
Write-Host "⚠️  按 Ctrl+C 停止服务器"
Write-Host ""
Write-Host "=================================="
Write-Host ""

npm run dev

# 检查是否出错
if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "❌ 服务器启动失败" -ForegroundColor Red
    Read-Host "按回车键退出"
    exit $LASTEXITCODE
}
