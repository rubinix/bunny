# exchange_spec.rb

require File.expand_path(File.join(File.dirname(__FILE__), %w[.. lib bunny]))

describe Exchange do
	
	before(:each) do
    @b = Bunny.new
		@b.start
	end
	
	after(:each) do
		@b.stop
	end
	
	it "should be able to be created as a direct exchange" do
		exch = @b.exchange(:direct, 'direct_exchange')
		exch.should be_an_instance_of Exchange
		exch.name.should == 'direct_exchange'
		exch.type.should == :direct
		@b.exchanges.has_key?('direct_exchange').should be true
	end
	
	it "should be able to be created as a topic exchange" do
		exch = @b.exchange(:topic, 'topic_exchange')
		exch.should be_an_instance_of Exchange
		exch.name.should == 'topic_exchange'
		exch.type.should == :topic
		@b.exchanges.has_key?('topic_exchange').should be true
	end
	
	it "should be able to be created as a fanout exchange" do
		exch = @b.exchange(:fanout, 'fanout_exchange')
		exch.should be_an_instance_of Exchange
		exch.name.should == 'fanout_exchange'
		exch.type.should == :fanout
		@b.exchanges.has_key?('fanout_exchange').should be true
	end
	
	it "should be able to publish a message" do
		exch = @b.exchange(:direct, 'direct_exchange')
		exch.publish('This is a published message')
	end
	
	it "should be able to be deleted" do
		exch = @b.exchange(:direct, 'direct_exchange')
		exch.delete
		@b.exchanges.has_key?('direct_exchange').should be false
	end
	
end