##### テーブルスキーマ（案）  
```
User  
id, integer  
name, string  
password_digest, string

Task  
id, integer  
task_name, string  
task_detail, text  
user_id, integer

Label  
id, integer  
label_name, string  
task_id, integer

Task_label  
id, integer  
task_id, integer  
label_id, integer
```

##### Herokuへのデプロイの手順

1.適当なディレクトリにいる事を確認  
2.`heroku create`を行い新しいアプリケーションを作成  
3.`rails assets:precompile RAILS_ENV=production`をアセットプリコンパイルをする為に入力  
4.Gemfileの`ruby '2.6.5'`となっている行をコメントアウト  
5.`bundle install`を入力  
6.`git add -A`と`git commit -m`を行い変更したところをコミットする  
7.Heroku buildpackを追加する（`heroku buildpacks:set heroku/ruby`と`heroku buildpacks:add --index 1 heroku/nodejs`を入力）  
8.Herokuにデプロイする為に`git push heroku 該当のブランチ`を行う  
9.`heroku run rails db:migrate`を入力し、マイグレーションを行う  

##### Gemのバージョン情報
```
gem 'rails', '= 5.2.5'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 3.8'
  gem 'factory_bot_rails'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'webdrivers'
end
```
