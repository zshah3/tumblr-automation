require 'rubygems'
require 'Watir'
require 'pry'

RSpec.configure do |config|

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.before(:all) do
    @b = Watir::Browser.new :chrome
  end

  config.after(:all) do
    @b.quit
  end
end

def visit(path)
  @b.goto "https://www.tumblr.com#{path}"
end

def logged_in?
  @b.body.attribute_value('class').include? 'logged_in'
end

def logout!
  visit '/logout' if logged_in?
end

def login(email = 'z.shah@msn.com', password = 'thispassword')
  unless logged_in?
    visit '/'
    @b.button(id: 'signup_login_button').click 
    @b.text_field(name: 'determine_email').set email 
    Watir::Wait.until {@b.title == "Log in | Tumblr"}
    @b.button(id: 'signup_forms_submit').click
    @b.button(name: 'signin').click
    @b.text_field(name: 'passwd').set password
    Watir::Wait.until {@b.title == "Yahoo - login"}
    @b.button(name: 'signin').click
    Watir::Wait.until {@b.url == 'https://www.tumblr.com/dashboard'}
  end
end


def login_incorrect(email = 'sdhjs@sfs.com', password = 'passwordss')
  visit '/'
  @b.button(id: 'signup_login_button').click 
  @b.text_field(name: 'determine_email').set email 
  Watir::Wait.until {@b.title == "Log in | Tumblr"}
  @b.button(id: 'signup_forms_submit').click
  sleep 3
end

def create_post
  @b.a(id: 'new_post_label_text').click
  @b.element(css: "div[aria-label='Post title']").send_keys 'ndljdanc'
  @b.element(css: "div[aria-label='Post body']").send_keys 'feqlkfcdeni!'
  Watir::Wait.until {@b.title == "Tumblr"}
  @b.button(class: "button-area create_post_button").click
end

def delete_last
  # unless logged_in?
  #   login
    # visit '/'
  @b.div(title: 'Post Options').click
  @b.div(title: 'Delete').click
  @b.element(css: "button[data-btn-id='1']").click
  # end
end

def post_pic
  @b.a(id: 'new_post_label_photo').click
  @b.div(class: "split-cell media-url-button").click
  @b.element(css: "div[aria-label='Paste a URL']").send_keys 'https://theluxurytravelexpert.files.wordpress.com/2014/12/nepal.jpg'
  Watir::Wait.until {@b.title == "Tumblr"}
  @b.send_keys :enter
  @b.button(class: "button-area create_post_button").click
end

def file_upload
  @b.a(id: 'new_post_label_photo').click
  @b.div(class: "split-cell media-upload-button").click
  @b.file_field "/Users/tech-a44/desktop/scenery.jpg"
end

def take_selfie
  @b.a(id: 'new_post_label_photo').click
  sleep 2
  @b.div(class: "webcam-button").click
  @b.div(class: "icon").click
  sleep 5
  @b.button(class: "button-area create_post_button").click
  sleep 2
end




















