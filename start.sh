#!/bin/bash

# 设置错误时退出
set -e

# 设置Django设置模块
export DJANGO_SETTINGS_MODULE=blog_project.settings_prod

echo "=== Django博客启动脚本 ==="
echo "当前目录: $(pwd)"
echo "Python版本: $(python3 --version)"
echo "Django设置模块: $DJANGO_SETTINGS_MODULE"

# 检查必要文件
echo "检查必要文件..."
if [ ! -f "manage.py" ]; then
    echo "错误: manage.py 文件不存在"
    exit 1
fi

if [ ! -f "blog_project/settings_prod.py" ]; then
    echo "错误: 生产环境设置文件不存在"
    exit 1
fi

# 运行数据库迁移
echo "运行数据库迁移..."
python3 manage.py migrate --settings=blog_project.settings_prod || {
    echo "数据库迁移失败"
    exit 1
}

# 收集静态文件
echo "收集静态文件..."
python3 manage.py collectstatic --noinput --settings=blog_project.settings_prod || {
    echo "静态文件收集失败"
    exit 1
}

# 检查gunicorn是否安装
echo "检查gunicorn..."
python3 -c "import gunicorn" || {
    echo "错误: gunicorn未安装"
    exit 1
}

# 启动gunicorn
echo "启动gunicorn..."
exec gunicorn blog_project.wsgi:application \
    --bind 0.0.0.0:8000 \
    --workers 3 \
    --timeout 120 \
    --access-logfile - \
    --error-logfile - \
    --log-level info 