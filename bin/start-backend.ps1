# ========================================
# Halavah's Tech Backend 启动脚本 (PowerShell)
# ========================================

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# 切换到脚本所在目录
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $ScriptDir

# 返回项目根目录
Set-Location (Join-Path $ScriptDir "..")

# 进入 backend 目录
Set-Location "backend"

Write-Host "=================================="
Write-Host "🚀 Halavah's Tech Backend 启动中..."
Write-Host "=================================="
Write-Host ""

# 检查 Maven 是否安装
$mavenExists = Get-Command mvn -ErrorAction SilentlyContinue
if (-not $mavenExists) {
    Write-Host "❌ 错误: Maven 未安装" -ForegroundColor Red
    Write-Host "请访问 https://maven.apache.org 下载并安装 Maven"
    Read-Host "按回车键退出"
    exit 1
}

# 显示 Maven 版本
$mavenVersion = mvn --version 2>&1 | Select-String "Apache Maven" | Select-Object -First 1
Write-Host "📦 $mavenVersion"
Write-Host ""

# 检查 Java 是否安装
$javaExists = Get-Command java -ErrorAction SilentlyContinue
if (-not $javaExists) {
    Write-Host "❌ 错误: Java 未安装" -ForegroundColor Red
    Write-Host "请访问 https://adoptium.net 下载并安装 Java"
    Read-Host "按回车键退出"
    exit 1
}

# 显示 Java 版本
$javaVersion = java -version 2>&1 | Select-String "version" | Select-Object -First 1
Write-Host "📦 $javaVersion"
Write-Host ""

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

# 启动 Spring Boot 开发服务器
Write-Host "🌐 启动 Spring Boot 服务器..."
Write-Host ""
Write-Host "📍 本地访问地址: http://localhost:9991"
if ($LOCAL_IP) {
    Write-Host "📍 网络访问地址: http://${LOCAL_IP}:9991"
}
Write-Host ""
Write-Host "⚠️  按 Ctrl+C 停止服务器"
Write-Host ""
Write-Host "=================================="
Write-Host ""

mvn spring-boot:run

# 检查是否出错
if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "❌ 服务器启动失败" -ForegroundColor Red
    Read-Host "按回车键退出"
    exit $LASTEXITCODE
}
