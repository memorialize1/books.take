class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :favorites
  has_many :comments



  #以下フォロー機能
  #フォローしている情報を表示
  has_many :relationships #短縮されているが、これはuser_idをキーとしてrelationshipsにアクセスという意味
  has_many :followings, through: :relationships, source: :follow
  #followwingsモデルを架空で作成し、throughで中間テーブルをrelationshipsに指定。その参照先はfollowです。
  #これで、user.followwingsと入力するだけでrelationshipsを踏み台にしてそのuser_idに紐づいたフォローしているuserたちを取得できる
  #user_idをキーとして、そのuser_idに紐づいたカラムfollowのデータを引っ張ってくる

  #フォローされている情報を表示
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  #この記述は、reverse_of_relationshipsという架空のモデルにアクセスする際はRelationshipを踏み台にし、それをfollow_idをキーにして検索という意味
  has_many :followers, through: :reverse_of_relationships, source: :user
  #follow_idをキーとし、reverse_of_relationshipsからuser_idに紐づいたものを引っ張ってくる。

  #source = ～を参照してという意味。データのソース元。検索の出口
  #foreigin_key = ～というキーを使って検索という意味。キーで指定された情報をソースから引っ張ってくる。検索の入り口
  #through = ～を経由してという意味



  attachment :profile_image, destroy: false #画像ファイルをビュー上で表示するためのコマンド

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}

  def follow(other_user)
    unless self == other_user #self(自分)はother_user(指定したユーザー)ですか？
    #自分でなければ下記の処理を実行
      self.relationships.find_or_create_by(follow_id: other_user.id)
      #self(User)からrelationshipsにfollow_idとuser_idを追加
      #find_or_create_byとは・・・同じ組み合わせが無いか探し、なければ作成(.new .)
    end
  end

  def unfollow(other_user) #followがあった場合
    relationship = self.relationships.find_by(follow_id: other_user.id)
    #relationshipの中身はself(user).relationshipsでfolllow_idをother_userで探す。
    relationship.destroy if relationship #relationshipがあればrelationshipを削除
  end

  def following?(other_user) #フォローしている？
    self.followings.include?(other_user)
    #self.followings = self(user).followings(relationships.follow) つまり、ユーザーを入り口としてフォローが紐づいているものを探す
    #includeは含まれているかどうかを聞いているので、フォローしている人の中に今回のユーザーはいますか？と聞いている。
  end

end
