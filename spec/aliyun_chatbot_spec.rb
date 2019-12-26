RSpec.describe AliyunChatbot do
  it "has a version number" do
    expect(AliyunChatbot::VERSION).not_to be nil
  end

  it "client new with params" do
    ak_id = SecureRandom.uuid
    ak_secret = SecureRandom.uuid
    client = AliyunChatbot::Client.new(ak_id, ak_secret)
    expect(client.ak_id).to eq(ak_id)
    expect(client.ak_secret).to eq(ak_secret)
  end

  it "client new with config" do
    ak_id = SecureRandom.uuid
    ak_secret = SecureRandom.uuid
    AliyunChatbot.configure do |c|
      c.ak_id = ak_id
      c.ak_secret = ak_secret
    end
    client = AliyunChatbot::Client.new
    expect(client.ak_id).to eq(ak_id)
    expect(client.ak_secret).to eq(ak_secret)
  end

  context "set arguments like: ak_id='1' ak_secret='2' instance_id='3' bundle exec rspec" do
    ak_id = ENV['ak_id']
    ak_secret = ENV['ak_secret']
    instance_id = ENV['instance_id']
    if ak_id.nil? || ak_secret.nil? || instance_id.nil?
      it "you can test send_message after set arguments: ak_id ak_secret instance_id" do    
       
      end
    else
      it "client send_message ok" do    
        puts ak_id
        puts ak_secret
        puts instance_id
        client = AliyunChatbot::Client.new(ak_id, ak_secret)
        # instance_id from chatbot infos
        res = client.send_message(instance_id , "hello 你好") 
        puts res.class
        puts res
      end
    end

  end

    
  
  
end
