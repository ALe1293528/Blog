// 导航栏响应式功能
document.addEventListener('DOMContentLoaded', function() {
    const navToggle = document.querySelector('.nav-toggle');
    const navMenu = document.querySelector('.nav-menu');
    
    if (navToggle && navMenu) {
        navToggle.addEventListener('click', function() {
            navMenu.classList.toggle('active');
        });
        
        // 点击导航链接时关闭菜单
        const navLinks = document.querySelectorAll('.nav-link');
        navLinks.forEach(link => {
            link.addEventListener('click', () => {
                navMenu.classList.remove('active');
            });
        });
    }
    
    // 滚动时导航栏效果
    window.addEventListener('scroll', function() {
        const navbar = document.querySelector('.navbar');
        if (window.scrollY > 100) {
            navbar.style.background = 'rgba(255, 255, 255, 0.15)';
        } else {
            navbar.style.background = 'rgba(255, 255, 255, 0.1)';
        }
    });
    
    // 平滑滚动到顶部
    const scrollToTop = () => {
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    };
    
    // 添加回到顶部按钮
    const backToTopBtn = document.createElement('button');
    backToTopBtn.innerHTML = '<i class="fas fa-arrow-up"></i>';
    backToTopBtn.className = 'back-to-top';
    backToTopBtn.style.cssText = `
        position: fixed;
        bottom: 30px;
        right: 30px;
        width: 50px;
        height: 50px;
        border-radius: 50%;
        background: rgba(255, 255, 255, 0.2);
        backdrop-filter: blur(20px);
        border: 1px solid rgba(255, 255, 255, 0.3);
        color: white;
        font-size: 1.2rem;
        cursor: pointer;
        transition: all 0.3s ease;
        z-index: 1000;
        display: none;
    `;
    
    document.body.appendChild(backToTopBtn);
    
    backToTopBtn.addEventListener('click', scrollToTop);
    
    // 显示/隐藏回到顶部按钮
    window.addEventListener('scroll', function() {
        if (window.scrollY > 300) {
            backToTopBtn.style.display = 'flex';
            backToTopBtn.style.alignItems = 'center';
            backToTopBtn.style.justifyContent = 'center';
        } else {
            backToTopBtn.style.display = 'none';
        }
    });
    
    // 按钮悬停效果
    backToTopBtn.addEventListener('mouseenter', function() {
        this.style.background = 'rgba(255, 255, 255, 0.3)';
        this.style.transform = 'scale(1.1)';
    });
    
    backToTopBtn.addEventListener('mouseleave', function() {
        this.style.background = 'rgba(255, 255, 255, 0.2)';
        this.style.transform = 'scale(1)';
    });
    
    // 文章卡片动画
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };
    
    const observer = new IntersectionObserver(function(entries) {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, observerOptions);
    
    // 观察文章卡片
    const articleCards = document.querySelectorAll('.article-card');
    articleCards.forEach(card => {
        card.style.opacity = '0';
        card.style.transform = 'translateY(30px)';
        card.style.transition = 'all 0.6s ease';
        observer.observe(card);
    });
    
    // 博主卡片动画
    const bloggerCard = document.querySelector('.blogger-card');
    if (bloggerCard) {
        bloggerCard.style.opacity = '0';
        bloggerCard.style.transform = 'translateY(30px)';
        bloggerCard.style.transition = 'all 0.8s ease';
        
        setTimeout(() => {
            bloggerCard.style.opacity = '1';
            bloggerCard.style.transform = 'translateY(0)';
        }, 500);
    }
});

// 移除内容区毛玻璃渐变相关的滚动监听
// document.addEventListener('scroll', function() {
//     const mainContent = document.getElementById('main-content');
//     const hero = document.querySelector('.hero-section');
//     if (!mainContent || !hero) return;
//     const heroHeight = hero.offsetHeight;
//     const scrollY = window.scrollY || window.pageYOffset;
//     if (scrollY > heroHeight - 80) {
//         mainContent.classList.add('glass');
//         mainContent.style.background = '';
//         mainContent.style.backdropFilter = '';
//         mainContent.style.webkitBackdropFilter = '';
//     } else {
//         const percent = Math.min(scrollY / (heroHeight - 80), 1);
//         mainContent.style.background = `rgba(102,126,234,${0.85 * percent})`;
//         mainContent.style.backdropFilter = `blur(${20 * percent}px)`;
//         mainContent.style.webkitBackdropFilter = `blur(${20 * percent}px)`;
//         mainContent.classList.remove('glass');
//     }
// }); 