class IntroController < ApplicationController
  def initialize(*params)
    super(*params)
    @controller_name=t('activerecord.models.intro')
  end

  def index
    @title=@controller_name
  end
end
