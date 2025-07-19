#!/bin/bash

# Django博客部署脚本
echo "开始部署Django博客..."

# 检查Docker是否安装
if ! command -v docker &> /dev/null; then
    echo "错误: Docker未安装，请先安装Docker"
    exit 1
fi

if ! command -v docker-compose &> /dev/null; then
    echo "错误: Docker Compose未安装，请先安装Docker Compose"
    exit 1
fi

# 创建必要的目录
echo "创建必要的目录..."
mkdir -p static media logs

# 设置文件权限
echo "设置文件权限..."
chmod +x start.sh

# 停止现有容器
echo "停止现有容器..."
docker-compose down

# 重新构建镜像
echo "重新构建Docker镜像..."
docker-compose build --no-cache

# 启动服务
echo "启动服务..."
docker-compose up -d

# 等待服务启动
echo "等待服务启动..."
sleep 10

# 检查服务状态
echo "检查服务状态..."
docker-compose ps

# 查看日志
echo "查看启动日志..."
docker-compose logs blog

echo "部署完成！"
echo "访问地址: http://你的服务器IP:8000"
echo "管理后台: http://你的服务器IP:8000/admin/"
echo ""
echo "查看实时日志: docker-compose logs -f blog"
echo "停止服务: docker-compose down"
echo "重启服务: docker-compose restart"