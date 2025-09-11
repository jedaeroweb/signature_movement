module JsonLdHelper
  def json_ld_for_blog(post)
    {
      "@context": "https://schema.org",
      "@type": "BlogPosting",
      "mainEntityOfPage": {
        "@type": "WebPage",
        "@id": blog_url(post)
      },
      "headline": post.title,
      "description": post.description || truncate(strip_tags(post.content), length: 160),
      "image": post.blog_picture ? sl_get_thumb(post.blog_picture.picture.to_s,'medium') : '-',
      "author": {
        "@type": "Person",
        "name": post.user&.nickname || "익명"
      },
      "publisher": {
        "@type": "Organization",
        "name": "My Blog",
        "logo": {
          "@type": "ImageObject",
          "url": asset_url("favicon.ico")
        }
      },
      "genre": post.blog_category.title || "블로그",
      "datePublished": post.created_at.iso8601,
      "dateModified": post.updated_at.iso8601
    }
  end

  def json_ld_for_gallery(gallery)
    {
      "@context": "https://schema.org",
      "@type": "ImageGallery",
      "name": gallery.title,
      "url": gallery_url(gallery),
      "image": {
          "@type": "ImageObject",
          "url": gallery.photo.url,
          "caption": gallery.title,
          "thumbnail": sl_get_thumb(gallery.photo.to_s,'medium')
        },
      "datePublished": gallery.created_at.iso8601,
      "dateModified": gallery.updated_at.iso8601
    }
  end

  def json_ld_for_faq_page(faqs)
    {
      "@context": "https://schema.org",
      "@type": "FAQPage",
      "mainEntity": faqs.map do |faq|
        {
          "@type": "Question",
          "name": faq.title,
          "acceptedAnswer": {
            "@type": "Answer",
            "text": faq.content.to_plain_text
          }
        }
      end
    }
  end

  def json_ld_for_profile()
    {
      "@context": "https://schema.org",
      "@type": "ProfilePage",
      "mainEntity": {
        "@type": "Person",
        "name": "정진규",
        "url": t(:site_full_url),
        "image": asset_url('intro.jpg'),
        "jobTitle": "은퇴자",
        "birthDate": "1953-11-02"
      }
    }
  end

  # 공지사항 단일 NewsArticle JSON-LD
  def json_ld_for_notice(notice)
    {
      "@context": "https://schema.org",
      "@type": "NewsArticle",
      "headline": notice.title,
      "datePublished": notice.created_at.iso8601,
      "dateModified": notice.updated_at.iso8601,
      "author": {
        "@type": "Person",
        "name": notice.user.nickname || "관리자"
      },
      "publisher": {
        "@type": "Organization",
        "name": "MySite",
        "logo": {
          "@type": "ImageObject",
          "url": asset_url("favicon.ico")
        }
      },
      "url": notice_url(notice),
      "description": notice.content.to_plain_text
    }
  end

  # 공지사항 리스트 JSON-LD (ItemList)
  def json_ld_for_notice_list(notices)
    {
      "@context": "https://schema.org",
      "@type": "ItemList",
      "itemListElement": notices.map.with_index(1) do |notice, idx|
        {
          "@type": "ListItem",
          "position": idx,
          "url": notice_url(notice),
          "name": notice.title
        }
      end
    }
  end
end