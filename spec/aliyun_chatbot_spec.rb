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
end
