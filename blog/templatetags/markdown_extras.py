from django import template
from django.utils.safestring import mark_safe
import markdown
from pygments import highlight
from pygments.lexers import get_lexer_by_name
from pygments.formatters import HtmlFormatter
import re

register = template.Library()

class CodeBlockExtension(markdown.Extension):
    def extendMarkdown(self, md):
        md.registerExtension(self)
        md.preprocessors.register(CodeBlockPreprocessor(self), 'code_block', 30)

class CodeBlockPreprocessor(markdown.preprocessors.Preprocessor):
    def run(self, lines):
        new_lines = []
        in_code_block = False
        code_lines = []
        language = ''
        
        for line in lines:
            if line.startswith('```'):
                if not in_code_block:
                    # 开始代码块
                    in_code_block = True
                    language = line[3:].strip()
                    code_lines = []
                else:
                    # 结束代码块
                    in_code_block = False
                    if code_lines:
                        code = '\n'.join(code_lines)
                        if language:
                            try:
                                lexer = get_lexer_by_name(language)
                                formatter = HtmlFormatter(style='monokai')
                                highlighted_code = highlight(code, lexer, formatter)
                                new_lines.append(highlighted_code)
                            except:
                                # 如果语言不支持，使用普通代码块
                                new_lines.append(f'<pre><code class="language-{language}">{code}</code></pre>')
                        else:
                            new_lines.append(f'<pre><code>{code}</code></pre>')
            elif in_code_block:
                code_lines.append(line)
            else:
                new_lines.append(line)
        
        return new_lines

@register.filter(name='markdown')
def markdown_filter(text):
    """将Markdown文本转换为HTML"""
    if not text:
        return ''
    
    # 配置Markdown扩展
    extensions = [
        'markdown.extensions.fenced_code',
        'markdown.extensions.codehilite',
        'markdown.extensions.tables',
        'markdown.extensions.toc',
        'markdown.extensions.nl2br',
        'markdown.extensions.sane_lists',
    ]
    
    # 配置代码高亮
    extension_configs = {
        'codehilite': {
            'css_class': 'highlight',
            'use_pygments': True,
            'noclasses': True,
            'style': 'monokai'
        }
    }
    
    # 转换Markdown为HTML
    md = markdown.Markdown(
        extensions=extensions,
        extension_configs=extension_configs
    )
    
    html = md.convert(text)
    return mark_safe(html) 