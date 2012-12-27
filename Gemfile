source 'http://ruby.taobao.org'
#source 'http://rubygems.org'

gem 'rails', '3.2.9'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

#gem 'pg'
gem 'mysql2'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
  gem 'haml-rails'
end

gem 'jquery-rails'

# Tags
gem 'acts-as-taggable-on', '~> 2.3.1'

# 上传
gem 'paperclip'

# 分页
gem 'kaminari'

# 富文本编辑器  图像选择/上传
gem 'rich' #https://github.com/bastiaanterhorst/rich
#gem 'ckeditor', "3.7.3"

# 客户端验证，利用Model中的validates
gem 'client_side_validations'
gem 'client_side_validations-simple_form'

# 认证
gem 'devise'
gem 'devise-i18n'

# 权限
gem 'declarative_authorization'

# form builder
gem 'simple_form', '~> 2.0.0'

# 异步任务与定时
gem 'resque'
gem 'resque-scheduler', :require => 'resque_scheduler'


group :development do
  gem 'quiet_assets'
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :production do
  gem 'unicorn'
end

group :test do

end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
