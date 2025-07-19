#!/bin/bash

# Django博客打包脚本
# 使用方法: ./package.sh

echo "开始打包Django博客..."

# 创建打包目录
PACKAGE_DIR="blog-deploy-$(date +%Y%m%d-%H%M%S)"
mkdir -p $PACKAGE_DIR

echo "创建打包目录: $PACKAGE_DIR"

# 复制必要文件
echo "复制项目文件..."

# 复制Django应用文件
cp -r blog/ $PACKAGE_DIR/
cp -r blog_project/ $PACKAGE_DIR/
cp -r static/ $PACKAGE_DIR/
cp -r templates/ $PACKAGE_DIR/

# 复制配置文件
cp requirements.txt $PACKAGE_DIR/
cp Dockerfile $PACKAGE_DIR/
cp docker-compose.yml $PACKAGE_DIR/
cp start.sh $PACKAGE_DIR/
cp deploy.sh $PACKAGE_DIR/
cp README.md $PACKAGE_DIR/
cp package.sh $PACKAGE_DIR/
cp pip.conf $PACKAGE_DIR/

# 复制数据库文件（如果存在）
if [ -f db.sqlite3 ]; then
    cp db.sqlite3 $PACKAGE_DIR/
    echo "已包含数据库文件"
else
    echo "数据库文件不存在，将在部署时创建"
fi

# 创建必要的目录
mkdir -p $PACKAGE_DIR/media
mkdir -p $PACKAGE_DIR/logs

# 设置文件权限
chmod +x $PACKAGE_DIR/start.sh
chmod +x $PACKAGE_DIR/deploy.sh

# 创建.gitignore文件
cat > $PACKAGE_DIR/.gitignore << EOF
# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
env/
venv/
ENV/
env.bak/
venv.bak/

# Django
*.log
local_settings.py
db.sqlite3
db.sqlite3-journal

# Media files
media/

# Static files
staticfiles/

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Docker
.dockerignore
EOF

# 创建压缩包
echo "创建压缩包..."
tar -czf "${PACKAGE_DIR}.tar.gz" $PACKAGE_DIR

# 清理临时目录
rm -rf $PACKAGE_DIR

echo "打包完成！"
echo "部署文件: ${PACKAGE_DIR}.tar.gz"
echo ""
echo "上传到服务器:"
echo "scp ${PACKAGE_DIR}.tar.gz user@your-server:/home/user/"
echo ""
echo "在服务器上解压:"
echo "tar -xzf ${PACKAGE_DIR}.tar.gz"
echo "cd ${PACKAGE_DIR}"
echo "./deploy.sh" 