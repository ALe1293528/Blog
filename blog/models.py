from django.db import models
from django.utils import timezone

class Category(models.Model):
    name = models.CharField(max_length=32, unique=True, verbose_name='分类')
    
    def __str__(self):
        return self.name

class Tag(models.Model):
    name = models.CharField(max_length=32, unique=True, verbose_name='标签')
    
    def __str__(self):
        return self.name

class BloggerInfo(models.Model):
    nickname = models.CharField(max_length=32, verbose_name='昵称')
    avatar = models.ImageField(upload_to='avatars/', blank=True, null=True, verbose_name='头像')
    level = models.CharField(max_length=16, default='Lv.1', verbose_name='等级')
    bio = models.TextField(blank=True, verbose_name='简介')
    
    def __str__(self):
        return self.nickname

class Article(models.Model):
    title = models.CharField(max_length=200, verbose_name='标题')
    body = models.TextField(verbose_name='正文')
    summary = models.CharField(max_length=200, blank=True, verbose_name='摘要')
    created_at = models.DateTimeField(default=timezone.now, verbose_name='创建时间')
    category = models.ForeignKey(Category, on_delete=models.SET_NULL, null=True, blank=True, verbose_name='分类')
    tags = models.ManyToManyField(Tag, blank=True, verbose_name='标签')
    cover = models.ImageField(upload_to='covers/', blank=True, null=True, verbose_name='封面图')
    
    def __str__(self):
        return self.title

class FriendLink(models.Model):
    name = models.CharField(max_length=50, verbose_name='网站名称')
    url = models.URLField(verbose_name='网站链接')
    description = models.CharField(max_length=200, blank=True, verbose_name='网站描述')
    avatar = models.ImageField(upload_to='friend_avatars/', blank=True, null=True, verbose_name='网站头像')
    is_active = models.BooleanField(default=True, verbose_name='是否激活')
    created_at = models.DateTimeField(default=timezone.now, verbose_name='创建时间')
    order = models.IntegerField(default=0, verbose_name='排序')
    
    class Meta:
        ordering = ['order', '-created_at']
        verbose_name = '友情链接'
        verbose_name_plural = '友情链接'
    
    def __str__(self):
        return self.name
