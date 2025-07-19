#!/bin/bash

# Django博客调试脚本
# 使用方法: ./debug.sh

echo "=== Django博客调试脚本 ==="

# 检查Docker状态
echo "1. 检查Docker状态..."
if command -v docker &> /dev/null; then
    echo "Docker已安装"
    docker --version
else
    echo "错误: Docker未安装"
    exit 1
fi

# 检查容器状态
echo ""
echo "2. 检查容器状态..."
docker ps -a

# 查看容器日志
echo ""
echo "3. 查看容器日志..."
if docker ps -a | grep -q blog-blog; then
    echo "blog-blog容器日志:"
    docker logs blog-blog --tail 50
else
    echo "blog-blog容器不存在"
fi

# 检查镜像
echo ""
echo "4. 检查Docker镜像..."
docker images | grep blog

# 检查文件
echo ""
echo "5. 检查必要文件..."
files=("Dockerfile" "docker-compose.yml" "start.sh" "requirements.txt" "manage.py")
for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "✓ $file 存在"
    else
        echo "✗ $file 不存在"
    fi
done

# 检查端口占用
echo ""
echo "6. 检查端口占用..."
if command -v netstat &> /dev/null; then
    netstat -tlnp | grep 8000 || echo "端口8000未被占用"
else
    echo "netstat命令不可用"
fi

# 重新构建建议
echo ""
echo "=== 建议操作 ==="
echo "1. 重新构建镜像:"
echo "   docker-compose build --no-cache"
echo ""
echo "2. 启动服务:"
echo "   docker-compose up -d"
echo ""
echo "3. 查看实时日志:"
echo "   docker-compose logs -f blog"
echo ""
echo "4. 进入容器调试:"
echo "   docker-compose exec blog bash" 