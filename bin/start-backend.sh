#!/bin/bash

# Navigate to the directory where the script is located
cd "$(dirname "$0")"

# Go back to project root directory
cd ..

# Enter backend directory
cd backend

# Halavah's Tech Backend 启动脚本
# 用于 macOS 和 Linux 系统

echo "=================================="
echo "🚀 Halavah's Tech Backend 启动中..."
echo "=================================="

# 检查 Maven 是否安装
if ! command -v mvn &> /dev/null; then
    echo "❌ 错误: Maven 未安装"
    echo "请访问 https://maven.apache.org 下载并安装 Maven"
    exit 1
fi

# 显示 Maven 版本
echo "📦 Maven 版本: $(mvn --version | head -1)"

# 检查 Java 是否安装
if ! command -v java &> /dev/null; then
    echo "❌ 错误: Java 未安装"
    echo "请访问 https://adoptium.net 下载并安装 Java"
    exit 1
fi

# 显示 Java 版本
echo "📦 Java 版本: $(java -version 2>&1 | head -1)"
echo ""

# 启动 Spring Boot 服务器
echo "🌐 启动 Spring Boot 服务器..."
echo ""
echo "📍 本地访问地址: http://localhost:9991"
echo "📍 网络访问地址: http://$(hostname -I | awk '{print $1}'):9991"
echo ""
echo "⚠️  按 Ctrl+C 停止服务器"
echo ""
echo "=================================="

mvn spring-boot:run
