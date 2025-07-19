from django.shortcuts import render, get_object_or_404
from django.core.paginator import Paginator
from .models import Article, Category, Tag, BloggerInfo, FriendLink

def index(request):
    """首页视图"""
    # 获取所有文章，按创建时间倒序排列
    articles_list = Article.objects.all().order_by('-created_at')
    
    # 分页
    paginator = Paginator(articles_list, 10)  # 每页显示10篇文章
    page_number = request.GET.get('page')
    articles = paginator.get_page(page_number)
    
    # 获取博主信息
    try:
        blogger = BloggerInfo.objects.first()
    except:
        blogger = None
    
    # 获取分类和标签统计
    categories = Category.objects.all()
    tags = Tag.objects.all()
    
    context = {
        'articles': articles,
        'blogger': blogger,
        'categories': categories,
        'tags': tags,
    }
    
    return render(request, 'blog/index.html', context)

def article_detail(request, article_id):
    """文章详情页视图"""
    article = get_object_or_404(Article, id=article_id)
    
    context = {
        'article': article,
    }
    
    return render(request, 'blog/article_detail.html', context)

def about(request):
    """关于页面视图"""
    try:
        blogger = BloggerInfo.objects.first()
    except:
        blogger = None
    
    # 获取统计信息
    articles_count = Article.objects.count()
    categories_count = Category.objects.count()
    tags_count = Tag.objects.count()
    
    context = {
        'blogger': blogger,
        'articles_count': articles_count,
        'categories_count': categories_count,
        'tags_count': tags_count,
    }
    
    return render(request, 'blog/about.html', context)

def links(request):
    """链接页面视图"""
    # 获取激活的友情链接
    friend_links = FriendLink.objects.filter(is_active=True)
    
    context = {
        'links': friend_links,
    }
    
    return render(request, 'blog/links.html', context)
