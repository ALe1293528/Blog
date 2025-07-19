#!/bin/bash

# 本地开发环境设置脚本
# 使用方法: ./setup-dev.sh

echo "设置本地开发环境..."

# 检查Python是否安装
if ! command -v python3 &> /dev/null; then
    echo "错误: Python3未安装"
    exit 1
fi

# 创建虚拟环境
echo "创建虚拟环境..."
python3 -m venv venv

# 激活虚拟环境
echo "激活虚拟环境..."
source venv/bin/activate

# 配置pip镜像源
echo "配置pip镜像源..."
mkdir -p ~/.pip
cp pip.conf ~/.pip/

# 升级pip
echo "升级pip..."
pip install --upgrade pip -i https://pypi.tuna.tsinghua.edu.cn/simple/

# 安装依赖
echo "安装Python依赖..."
pip install -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple/

# 运行数据库迁移
echo "运行数据库迁移..."
python manage.py makemigrations
python manage.py migrate

# 收集静态文件
echo "收集静态文件..."
python manage.py collectstatic --noinput

echo "本地开发环境设置完成！"
echo ""
echo "启动开发服务器:"
echo "source venv/bin/activate"
echo "python manage.py runserver 8080"
echo ""
echo "创建超级用户:"
echo "python manage.py createsuperuser" 