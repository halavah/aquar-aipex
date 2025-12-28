# ========================================
# Halavah's Tech - 管理脚本 (PowerShell)
# ========================================

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# 设置工作目录为脚本所在目录
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $ScriptDir

$BinDir = Join-Path $ScriptDir "bin"

# 检查 bin 目录是否存在
if (-not (Test-Path $BinDir)) {
    Write-Host "[错误] bin 目录不存在: $BinDir" -ForegroundColor Red
    Read-Host "按回车键退出"
    exit 1
}

function Show-MainMenu {
    Clear-Host
    Write-Host ""
    Write-Host "╔════════════════════════════════════════════════════════════╗"
    Write-Host "║  Halavah's Tech - 管理控制台"
    Write-Host "╚════════════════════════════════════════════════════════════╝"
    Write-Host ""
    Write-Host "═══════════════════════════════════════════════════════════"
    Write-Host "  项目管理"
    Write-Host "═══════════════════════════════════════════════════════════"
    Write-Host ""
    Write-Host "  1. 启动后端服务器     (start-backend.bat)"
    Write-Host "     → 启动 Spring Boot 后端"
    Write-Host ""
    Write-Host "  2. 启动前端服务器     (start-frontend.bat)"
    Write-Host "     → 启动 Vue 前端开发环境"
    Write-Host "═══════════════════════════════════════════════════════════"
    Write-Host ""
    Write-Host "  9. 退出"
    Write-Host ""
    Write-Host "═══════════════════════════════════════════════════════════"
    Write-Host ""
}

function Start-Backend {
    Write-Host ""
    Write-Host "╔════════════════════════════════════════════════════════════╗"
    Write-Host "║  执行: 启动后端服务器"
    Write-Host "╚════════════════════════════════════════════════════════════╝"
    Write-Host ""

    $backendScript = Join-Path $BinDir "start-backend.bat"
    & $backendScript
}

function Start-Frontend {
    Write-Host ""
    Write-Host "╔════════════════════════════════════════════════════════════╗"
    Write-Host "║  执行: 启动前端服务器"
    Write-Host "╚════════════════════════════════════════════════════════════╝"
    Write-Host ""

    $frontendScript = Join-Path $BinDir "start-frontend.bat"
    & $frontendScript
}

# 主循环
while ($true) {
    Show-MainMenu

    $choice = Read-Host "请选择操作 [1-2, 9] (默认: 1)"

    # 如果用户直接按回车，默认选择 1
    if ([string]::IsNullOrWhiteSpace($choice)) {
        $choice = "1"
    }

    switch ($choice) {
        "1" {
            Start-Backend
            Write-Host ""
            Write-Host "═══════════════════════════════════════════════════════════"
            Read-Host "按回车键继续"
        }
        "2" {
            Start-Frontend
            Write-Host ""
            Write-Host "═══════════════════════════════════════════════════════════"
            Read-Host "按回车键继续"
        }
        "9" {
            Write-Host ""
            Write-Host "[信息] 感谢使用 Halavah's Tech 管理控制台"
            Write-Host ""
            exit 0
        }
        default {
            Write-Host ""
            Write-Host "[错误] 无效的选项: $choice" -ForegroundColor Red
            Start-Sleep -Seconds 2
        }
    }
}
