# Insta Jeju

## 171023


### C9 프로젝트 생성
1. **'Create a new workspace'** 버튼 클릭
2. **Workspace Name**을 입력하고, **Choose a template**에서 **Ruby**를 선택
3. **'Create workspace'** 클릭
4. 생성이 완료되어 로딩이 끝나고 IDE가 보이면, 아래쪽의 terminal에 `bundle`을 입력하여 필요한 라이브러리(gem)들을 설치한다.
5. 설치가 완료되면 위쪽의 **'Run Project'** 버튼을 클릭하여 서버를 실행한다.
6. 실행 후, 보이는 URL로 접속을 하여 Rails 기본 페이지가 뜨는 지 확인한다.


### Gemfile
1. **Gemfile**을 열어, 2번째 줄과 3번째 줄 사이에 `gem 'rails_db'`를 추가한다.
2. 아래쪽 terminal에서 `bundle`을 입력한다.


### Posts Model 생성
1. 아래 쪽의 termimal에서 `rails g model post`를 입력한다.
2. db/migrate 폴더 안에 새로 생긴 **create_posts.rb** 파일을 열어, 아래와 같이 작성한다.

```ruby
class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|

      t.text :content
      t.text :image

      t.timestamps null: false
    end
  end
end
```

3. 작성 완료 후, 아래쪽의 terminal에서 `rake db:migrate`를 입력한다.


### routes.rb 작성
1. **config/routes.rb** 파일을 열어 1번째 줄 바로 아래에 다음과 같이 작성한다.

```ruby
get 'posts' => 'posts#index'
get 'posts/new' => 'posts#new'
get 'posts/:id' => 'posts#show'
post 'posts' => 'posts#create'
get 'posts/:id/edit' => 'posts#edit'
put 'posts/:id' => 'posts#update'
delete 'posts/:id' => 'posts#destroy'
```


### Posts Controller 생성 및 작성
1. 아래 쪽의 termimal에서 `rails g controller posts`를 입력한다.
2. 생성된 **app/controllers/posts_controller.rb** 파일을 열어 다음과 같이 작성한다.

```ruby
class PostsController < ApplicationController
    
  def index
    @posts = Post.all
  end
  
  def new
    
  end
  
  def create
    @post = Post.new
    @post.content = params[:content]
    @post.save
    
    redirect_to "/posts/#{@post.id}"
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    @post.content = params[:content]
    @post.save
    
    redirect_to "/posts/#{@post.id}"
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
                
    redirect_to "/posts"
  end
    
 end
```
 
3. **app/controllers/application_controller.rb** 파일을 열어, `protect_from_forgery with: :exception` 코드 부분을 주석 처리한다. (코드 맨 앞에 '#' 추가)


### Posts View 생성 및 작성

**app/views/posts** 폴더 안에 `index.html.erb`, `new.html.erb`, `show.html.erb`, `edit.html.erb` 총 4개의 파일을 만들고 다음과 같이 코드를 작성한다.

1. `index.html.erb`

```erb
<h1>Posts Index</h1>

<a href="/posts/new">New</a>

<div>
  <% @posts.each do |post| %>

    <div>
      <a href="/posts/<%= post.id %>">
        <%= post.content %>
      </a>
    </div>
  
  <% end %>
</div>
```

2. `new.html.erb`

```erb
<h1>New Post</h1>

<form action="/posts" method="post">
  Content: <input type="text" name="content"><br>
  <input type="submit" value="Save">
</form>
```

3. `show.html.erb`

```erb
<a href="/posts/<%= @post.id %>/edit">Edit</a>

<div>
  <%= @post.content %>
</div>
<a href="/posts/<%= @post.id %>" data-method="delete">Delete</a>
```


4. `edit.html.erb`

```erb
<h1>Edit Post</h1>

<form action="/posts/<%= @post.id %>" method="post">
  <input type="hidden" name="_method" value="put">
  Content: <input type="text" name="content" value="<%= @post.content %>"><br>
  <input type="submit" value="Save">
</form> 
```

5. 서버가 실행 중이라면 **'Stop'** 버튼으로 정지한 후에, **'Run Project'** 버튼으로 서버를 재시작 하고, 실행 중이 아니라면 바로 **'Run Project'** 버튼으로 서버를 실행하여 위에서 작성한 코드들이 정상적으로 동작하는지 확인한다.


## 171025

### AWS 계정 만들기
1. 해외결제가 가능한 카드가 필요합니다.
2. 카드 정보 입력시 1달러의 가결제가 이루어지는데 이는 사용가능한 카드인지 확인하는 절차이며, 빠른 시일내에 환불됩니다.

### IAM Key 만들기
1. 우측 상단 **'본인 이름'** > **'My Security Credentials'** 클릭
2. 창이 뜨면 **'Get Started with IAM Users'** 클릭 (뜨지 않는다면 왼쪽 사이드바에 'Users' 클릭)
3. 좌측 상단 **'Add User'** 클릭
4. 생성하고자 하는 이름을 'User name'에 입력, 'Access type'을 **Programmatic access**에 체크하고 **'Next'** 클릭
5. **'Create group'** 클릭
6. 'Group name'을 입력, 'Search' 칸에서 **S3**를 검색하여 나오는 결과중 **AmazonS3FullAccess**를 체크하고 **'Create group'** 클릭
7. 생성된 Group을 체크하고 **'Next'** 클릭
8. **'Create User'** 클릭
9. **'Download .csv'** 버튼을 클릭하여 ID와 KEY를 저장하거나 **'Secret access key'** 아래쪽의 'show'를 클릭하여 ID와 KEY를 확인. 여기서 확인할 수 있는 KEY는 이 페이지를 벗어나면 다시 확인이 불가능하므로 꼭 Download를 하거나 다른 곳에 복사해두어야 한다. 또한 타인에게 알려지면 안되는 중요한 정보이므로 인터넷 상에 업로드하는 일이 없도록 하여야한다.

### S3 Bucket 만들기
1. 좌측 상단 'Services' > 'Storage' > 'S3' 클릭
2. 좌측 상단 **'Create bucket'** 클릭
3. 'Bucket name'을 지정, 'Region'을 'Asia Pacific (Seoul)'로 선택하고, 'Next'를 계속 클릭하여 bucket을 생성

### Gemfile 

```ruby
gem 'fog'
gem 'carrierwave'
gem 'figaro'
```

위의 gem들을 **Gemfile**에 추가 후, 아래 쪽의 terminal에서 `bundle` 명령어로 gem 설치.

### config/initalizers/fog.rb

파일을 새로 생성한 후, 아래의 코드를 복사하여 붙여넣는다.

```ruby
CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',                               # required
    aws_access_key_id:     ENV["AWS_ACCESS_KEY_ID"],            # required
    aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],        # required
    region:                'ap-northeast-2'
  }
  config.fog_directory  = '[아까 생성한 S3 Bucket의 이름]'           # required
end

```

여기서 서버를 Stop 하였다가 다시 Run Project로 해준다.

### Uploader 만들기

1. terminal에 `rails g uploader image`를 입력하여 uploader 파일을 생성한다. `app/uploaders` 폴더에 `image_uploader.rb`파일이 생성된다.
2. `image_uploader.rb`파일에서 해당하는 부분의 코드를 다음과 같이 수정해준다.

```ruby
# Choose what kind of storage to use for this uploader:
# storage :file
storage :fog
```

### post.rb

`post.rb` 파일을 다음과 같이 수정한다.

```ruby
class Post < ActiveRecord::Base
  mount_uploader :image, ImageUploader
end 
```

### figaro

1. 아래쪽의 termial에서 `bundle exec figaro install` 명령어로 `config/application.yml` 파일을 만들어준다.
2. 앞서 생성했던 IAM Key를 `application.yml` 파일에 **(ID)** 와 **(KEY)** 에 맞추어 작성해준다. 괄호는 함께 입력하지 않는다.

```yaml
  AWS_ACCESS_KEY_ID: (ID)
  AWS_SECRET_ACCESS_KEY: (KEY)
```

### app/controllers/posts_controller.rb

**create**와 **update** 부분에 다음과 같이 `post.content = params[:content]` 위쪽에 `post.image = params[:image]`를 추가해준다.

```ruby
post.image = params[:image]
post.content = params[:content]
post.save
```

### app/views/posts/new.html.erb

1. form tag에 `enctype='multipart/form-data'` 속성을 추가한다.
2. form tag 안쪽, Content 위쪽에 아래 코드와 같이 파일을 업로드 하는 input tag를 추가한다.
3. `app/views/posts/edit.html.erb` 파일도 1번, 2번과 같은 작업을 해준다.

```erb
<form action="/posts" method="post" enctype='multipart/form-data'>
  Image: <input type="file" name="image"><br>
  Content: <input type="text" name="content"><br>
  <input type="submit" value="Save">
</form>
```

### app/views/posts/show.html.erb

업로드 된 이미지를 확인하기 위하여, image tag를 다음과 같이 content 위쪽에 추가한다.

```erb
<div>
  <img src="<%= @post.image.url %>">
  <%= @post.content %>
</div>
```

### mini_magick를 이용하여 사진을 정사각형으로 변환하기

1. `Gemfile`에 `gem 'mini_magick'`를 추가한 후, terminal에 `bundle` 명령어를 입력해준다.
2. 'mini_magick'는 imagemagick 프로그램을 사용하므로, terminal에 `sudo apt-get update && sudo apt-get install imagemagick` 명령어로 imagemagick를 설치한다.
3. `image_uploader` 파일을 열어 해당하는 부분을 다음과 같이 수정한다.

```ruby
# Include RMagick or MiniMagick support:
# include CarrierWave::RMagick
include CarrierWave::MiniMagick

...

# Create different versions of your uploaded files:
# version :thumb do
  process resize_to_fill: [600, 600]
# end
```


## 171027

### routes.rb

1. `routes.rb`에 RESTful하게 생성한 URL들을 resources를 사용해서 아래와 같이 한줄 코드로 작성한다.
2. 첫 화면을 게시글들의 리스트가 있는 페이지로 지정하기 위하여 아래와 같이 코드를 추가한다. 

```ruby
root 'posts#index'
resources :posts
```

### URL Helper

`index.html.erb`, `show.html.erb` 파일에 작성되어있는 **a tag**를 **link_to** helper로 바꾸어 작성한다.

1. `index.html.erb`

```erb
<a href="/posts/new">New</a>

...

<a href="/posts/<%= post.id %>">
  ...
</a>
```
위 코드를 아래 코드로

```erb
<%= link_to("New", new_post_path) %>

...

<%= link_to(post) do %>
  ...
<% end %>
```

2. `show.html.erb`

```erb
<a href="/posts/<%= @post.id %>/edit">Edit</a>

...

<a href="/posts/<%= @post.id %>" data-method="delete">Delete</a>
```

위 코드를 아래 코드로

```erb
<%= link_to( "Edit", edit_post_path(@post) ) %>

...

<%= link_to( "Delete", @post, method: :delete ) %>
```


### Form Helper

`new.html.erb`, `edit.html.erb` 파일에 작성되어있는 **form tag**를 **form_for** helper로 바꾸어 작성한다.


1. `new.html.erb`

```erb
<form action="/posts/<%= @post.id %>" method="post">
  Image: <input type="file" name="image"><br>
  Content: <input type="text" name="content" value="<%= @post.content %>"><br>
  <input type="submit" value="Save">
</form>
```

위 코드를 아래 코드로

```erb
<%= form_for(@post) do |f| %>
  Image: <%= f.file_field :image %>
  Content: <%= f.text_field :content %>
  <%= f.submit "Save" %>
<% end %>
```


2. `edit.html.erb`

```erb
<form action="/posts/<%= @post.id %>" method="post">
  <input type="hidden" name="_method" value="put">
  Image: <input type="file" name="image"><br>
  Content: <input type="text" name="content" value="<%= @post.content %>"><br>
  <input type="submit" value="Save">
</form>
```

위 코드를 아래 코드로

```erb
<%= form_for(@post) do |f| %>
  Image: <%= f.file_field :image %>
  Content: <%= f.text_field :content %>
  <%= f.submit "Save" %>
<% end %>
```

3. `posts_controller.rb` 의 **new** 부분에 다음과 같은 코드를 추가한다.

```ruby
def new
  @post = Post.new
end
```


4. `posts_controller.rb` 의 **create**와 **update** 부분의 코드를 다음과 같이 수정한다.

```ruby
post.image = params[:image]
post.content = params[:content]
post.save

redirect_to "/posts/#{post.id}"
```

위 코드를 아래 코드로

```ruby
post.image = params[:post][:image]
post.content = params[:post][:content]
post.save

redirect_to post
```

5. `app/controllers/application_controller.rb`

주석처리 되어 있는 `protect_from_forgery with: :exception` 코드 부분을 주석 해제한다. ('#' 삭제)


### Asset Tag Helper

`index.html.erb`, `show.html.erb` 파일에 작성되어있는 **img tag**를 **image_tag** helper로 바꾸어 작성한다.

1. `index.html.erb`

```erb
<img src="<%= post.image.url %>" class="img-fluid">
```

위 코드를 아래 코드로

```erb
<%= image_tag(post.image.url, class:"img-fluid") %>
```


2. `show.html.erb`

```erb
<img src="<%= @post.image.url %>">
```

위 코드를 아래 코드로

```erb
<%= image_tag(@post.image.url, class:"img-fluid") %>
```
