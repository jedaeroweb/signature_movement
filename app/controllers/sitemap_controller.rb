class SitemapController < ApplicationController
  def initialize(*params)
    super(*params)
    @controller_name=t('activerecord.models.sitemap')
  end

  def index
    @title=@controller_name    
  end
end
