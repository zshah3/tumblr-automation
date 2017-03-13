describe "Tumblr" do 

	it 'should login with correct details' do
		login('z.shah@msn.com', 'thispassword')
		expect(@b.body.attribute_value('class')).to include 'logged_in'
	end


	it 'should not login with incorrect details' do
		logout!
		login_incorrect('sdhjs@sfs.com', 'passwordss')
		expect(@b.li.text).to eq "This email doesn't have a Tumblr account. Sign up now?"	
	end	

	it 'should post a text post' do
		login
		create_post
		expect(@b.body.text).to include 'ndljdanc'
	  delete_last
	  sleep 2
	end

	it "should delete last post" do
		# visit '/'
		create_post
		Watir::Wait.until {@b.url == 'https://www.tumblr.com/dashboard'}
		visit '/blog/zubairshah313/'
		delete_last
		sleep 2
		# Watir::Wait.until {@b.body.text != 'ndljdanc'}
    expect(@b.body.text).not_to include 'ndljdanc'
	end

	it "should post a image post" do
		login
		post_pic
		sleep 3
		expect(@b.img(class: "post_media_photo image").present?).to eq true
		sleep 2
		delete_last
	end


	# it "should upload a file image" do
	# 	login
	# 	file_upload
	# end

	it "should take a selfie" do
		login
		take_selfie
		expect(@b.img(class: "post_media_photo image").present?).to eq true
		sleep 2
		delete_last
	end

end


