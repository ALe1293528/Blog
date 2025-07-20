# Django 博客项目

一个现代化的 Django 博客系统，支持文章、标签、分类、友链、响应式设计，支持 Docker 部署和静态导出到 GitHub Pages。

本来是准备用的，但是云服务器到期了，续费还蛮贵的，所以改用基于hexo的博客系统了，而且这个写的也有点草率了，是初学作品，效果肯定不如开源模板

---

## 功能特性
- 文章发布与管理
- 分类、标签系统
- 友链管理
- 响应式美观 UI
- 支持 Markdown
- 支持 Docker 一键部署
- 支持导出静态站点到 GitHub Pages

---

## 快速启动

### 本地开发

1. 安装依赖
   ```bash
   python3 -m venv venv
   source venv/bin/activate
   pip install -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple/
   ```
2. 数据库迁移 & 创建超级用户
   ```bash
   python manage.py migrate
   python manage.py createsuperuser
   ```
3. 启动开发服务器
   ```bash
   python manage.py runserver 0.0.0.0:8000
   ```
4. 访问
   - 博客首页: http://localhost:8000
   - 管理后台: http://localhost:8000/admin/

### Docker 部署

1. 构建镜像
   ```bash
   docker build -t my-django-app .
   ```
2. 运行容器（允许所有主机访问）
   ```bash
   docker run -d -p 8000:8000 my-django-app
   ```
3. 访问
   - http://服务器IP:8000

---

## 静态部署到 GitHub Pages

1. 安装 [django-distill](https://github.com/meeb/django-distill)
   ```bash
   pip install django-distill
   ```
2. 配置 `INSTALLED_APPS` 和 `urls.py`，参考 django-distill 文档。
3. 生成静态站点
   ```bash
   python manage.py distill-local dist/
   ```
4. 新建仓库 `yourusername.github.io`，将 `dist/` 目录下的内容推送到该仓库。
5. 访问 `https://yourusername.github.io`。

---

## 常见问题

- **端口被占用**：换一个端口或释放 8000 端口。
- **ALLOWED_HOSTS 报错**：已默认设置为 `['*']`，如需更安全可指定域名/IP。
- **静态文件不显示**：确保 `collectstatic` 已执行，模板引用用 `{% static %}` 标签。
- **Docker 构建慢**：已配置 pip 清华源。
- **只想静态博客**：用 django-distill 导出静态站点即可。

---

## 联系方式

- 作者：ALe
- 邮箱：1686960364@qq.com
- Issues：欢迎在 GitHub 提交 issue

---

> 本项目适合学习 Django、个人博客、静态站点部署等场景。欢迎 Star & Fork！ 
