crumb :root do
  link t(:home), root_path
end

crumb :intro do
  link t('activerecord.models.intro'), intro_index_path
end

crumb :improve do
  link t('activerecord.models.improve'), improve_index_path
end

crumb :sitemap do
  link t('activerecord.models.sitemap'), sitemap_index_path
end

crumb :reports do
  link t('activerecord.models.report'), reports_path
end

crumb :report do |report|
  link report.title, report_path(report)
  parent :reports
end

crumb :users do
  link t('activerecord.models.user'), users_path
end

crumb :user do |user|
  link user.name, user_path(user)
  parent :users
end

crumb :compliments do
  link t('activerecord.models.compliment'), compliments_path
end

crumb :compliment do |compliment|
  link compliment.title, compliment_path(compliment)
  parent :compliments
end

crumb :proposes do
  link t('activerecord.models.propose'), proposes_path
end

crumb :models do
  link t('activerecord.models.model'), models_path
end

crumb :model do |model|
  link model.title, model_path(model)
  parent :models
end

crumb :faqs do
  link t('activerecord.models.faq'), faqs_path
end

crumb :faq do |faq|
  link faq.title, faq_path(faq)
  parent :faqs
end

crumb :notices do
  link t('activerecord.models.notice'), notices_path
end

crumb :notice do |notice|
  link notice.title, notice_path(notice)
  parent :notices
end