require 'active_model_cachers'

ActiveRecord::Schema.define do
  self.verbose = false

  create_table :users, :force => true do |t|
    t.string :name
    t.string :email
    t.text :serialized_attribute
  end

  create_table :posts, :force => true do |t|
    t.integer :user_id
    t.string :title
  end

  create_table :profiles, :force => true do |t|
    t.integer :user_id
    t.integer :point
  end

  create_table :contacts, :force => true do |t|
    t.integer :user_id
    t.string :phone
  end
end

ActiveSupport::Dependencies.autoload_paths << File.expand_path('../models/', __FILE__)

users = User.create([
  {:name => 'John1', :email => 'john1@example.com', :profile => Profile.create(point: 10), :contact => Contact.create(phone: '12345')},
  {:name => 'John2', :email => 'john2@example.com', :profile => Profile.create(point: 30)},
  {:name => 'John3', :email => 'john3@example.com', :profile => Profile.create(point: 50)},
  {:name => 'John4', :email => 'john4@example.com', :profile => Profile.create(point: 70)},
])

Post.create([
  {:title => "John1's post1", :user_id => users[0].id},
  {:title => "John1's post2", :user_id => users[0].id},
  {:title => "John1's post3", :user_id => users[0].id},
  {:title => "John2's post1", :user_id => users[1].id},
  {:title => "John2's post2", :user_id => users[1].id},
  {:title => "John3's post1", :user_id => users[2].id},
])

