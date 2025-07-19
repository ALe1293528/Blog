#!/bin/bash

echo "=== 容器调试脚本 ==="

# 检查容器状态
echo "1. 检查容器状态:"
docker ps -a | grep blog-container

echo ""
echo "2. 检查容器日志:"
docker logs blog-container

echo ""
echo "3. 检查容器内进程:"
docker exec blog-container ps aux

echo ""
echo "4. 检查端口监听:"
docker exec blog-container netstat -tlnp

echo ""
echo "5. 测试容器内Django:"
docker exec blog-container python3 manage.py check --settings=blog_project.settings_prod

echo ""
echo "6. 检查静态文件:"
docker exec blog-container ls -la /app/staticfiles/css/

echo ""
echo "7. 测试静态文件访问:"
docker exec blog-container curl -I http://localhost:8000/static/css/style.css

echo ""
echo "=== 调试完成 ==="