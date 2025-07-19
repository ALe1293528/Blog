@echo off
REM 使用docker run部署Django博客 (Windows版本)

echo 使用docker run部署Django博客...

REM 设置变量
set IMAGE_NAME=django-blog
set CONTAINER_NAME=blog-container
set PORT=8000

REM 停止并删除现有容器
echo 停止并删除现有容器...
docker stop %CONTAINER_NAME% 2>nul
docker rm %CONTAINER_NAME% 2>nul

REM 删除现有镜像
echo 删除现有镜像...
docker rmi %IMAGE_NAME% 2>nul

REM 构建镜像
echo 构建Docker镜像...
docker build -t %IMAGE_NAME% .

REM 创建必要的目录
echo 创建必要的目录...
if not exist static mkdir static
if not exist media mkdir media
if not exist logs mkdir logs

REM 运行容器
echo 启动容器...
docker run -d --name %CONTAINER_NAME% -p %PORT%:8000 -v %cd%/static:/app/static -v %cd%/media:/app/media -v %cd%/logs:/app/logs -v %cd%/db.sqlite3:/app/db.sqlite3 %IMAGE_NAME%

REM 等待服务启动
echo 等待服务启动...
timeout /t 5 /nobreak >nul

REM 检查容器状态
echo 检查容器状态...
docker ps | findstr %CONTAINER_NAME%

REM 查看日志
echo 查看启动日志...
docker logs %CONTAINER_NAME%

echo.
echo 部署完成！
echo 访问地址: http://localhost:%PORT%
echo 管理后台: http://localhost:%PORT%/admin/
echo.
echo 查看实时日志: docker logs -f %CONTAINER_NAME%
echo 停止容器: docker stop %CONTAINER_NAME%
echo 重启容器: docker restart %CONTAINER_NAME%
echo 进入容器: docker exec -it %CONTAINER_NAME% bash

pause