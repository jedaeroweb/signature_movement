module JsonLdHelper
  def json_ld_tag(type='website', options: {})
    data = case type.to_s
           when "organization"
             {
               "@context": "https://schema.org",
               "@type": "Organization",
               "url": root_url,
               "name": options[:name] || Rails.application.class.module_parent_name,
               "contactPoint": {
                 "@type": "ContactPoint",
                 "telephone": options[:phone] || "+82-2-0000-0000",
                 "contactType": "customer service",
                 "areaServed": "KR",
                 "availableLanguage": ["Korean", "English"]
               },
               "sameAs": options[:same_as] || []
             }

           when "local_business"
             {
               "@context": "https://schema.org",
               "@type": options[:business_type] || "LocalBusiness",
               "name": options[:name] || "My Business",
               "image": options[:image] || image_url("store.jpg"),
               "address": {
                 "@type": "PostalAddress",
                 "streetAddress": options[:street] || "서울시 종로구 123",
                 "addressLocality": options[:city] || "서울",
                 "postalCode": options[:zip] || "03000",
                 "addressCountry": "KR"
               },
               "telephone": options[:phone] || "+82-2-0000-0000",
               "url": root_url
             }

           else
             {
               "@context": "https://schema.org",
               "@type": "WebSite",
               "url": root_url,
               "name": options[:name] || Rails.application.class.module_parent_name,
               "description":  I18n.t(:meta_description, default: "jedaeroweb.co.kr's good site"),
               "publisher": {
                 "@type": "Organization",
                 "name":  options[:org_name] || 'Jedaeroweb',
                 "logo": {
                   "@type": "ImageObject",
                   "url": options[:logo_url] || image_url("favicon.ico")
                 }
               }
             }
           end

    return data
  end

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


  def json_ld_for_article(record)
    {
      "@context": "https://schema.org",
      "@type": "Article",
      "headline": record.try(:title) || record.try(:name),
      "description": truncate(strip_tags(record.try(:content) || ""), length: 150),
      "author": {
        "@type": "Person",
        "name": record.try(:user)&.try(:name)
      },
      "datePublished": record.created_at.iso8601,
      "dateModified": record.updated_at.iso8601,
      "mainEntityOfPage": {
        "@type": "WebPage",
        "@id": polymorphic_url(record)   # <- 여기서 자동 처리
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