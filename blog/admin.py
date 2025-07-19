from django.contrib import admin
from .models import Article, Category, Tag, BloggerInfo, FriendLink

@admin.register(Article)
class ArticleAdmin(admin.ModelAdmin):
    list_display = ['title', 'category', 'created_at', 'get_tags']
    list_filter = ['category', 'created_at', 'tags']
    search_fields = ['title', 'body', 'summary']
    date_hierarchy = 'created_at'
    filter_horizontal = ['tags']
    
    def get_tags(self, obj):
        return ", ".join([tag.name for tag in obj.tags.all()])
    get_tags.short_description = '标签'

@admin.register(Category)
class CategoryAdmin(admin.ModelAdmin):
    list_display = ['name']
    search_fields = ['name']

@admin.register(Tag)
class TagAdmin(admin.ModelAdmin):
    list_display = ['name']
    search_fields = ['name']

@admin.register(BloggerInfo)
class BloggerInfoAdmin(admin.ModelAdmin):
    list_display = ['nickname', 'level', 'get_avatar']
    search_fields = ['nickname', 'bio']
    
    def get_avatar(self, obj):
        if obj.avatar:
            return f"✓ 已上传"
        return "✗ 未上传"
    get_avatar.short_description = '头像状态'

@admin.register(FriendLink)
class FriendLinkAdmin(admin.ModelAdmin):
    list_display = ['name', 'url', 'is_active', 'order', 'created_at']
    list_filter = ['is_active', 'created_at']
    search_fields = ['name', 'description', 'url']
    list_editable = ['is_active', 'order']
    date_hierarchy = 'created_at'
