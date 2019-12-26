# AliyunChatbot

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/aliyun_chatbot`. To experiment with that code, run `bin/console` for an interactive prompt.
[ruby sdk for aliyun chatbot](https://help.aliyun.com/document_detail/60762.html?spm=a2c4g.11186623.6.593.81035929ZxOJur)


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'aliyun_chatbot'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install aliyun_chatbot

## Usage

```ruby

#config/initialize/AliyunChatbot.rb
AliyunChatbot.configure do |c|
    c.ak_id = 'xx'
    c.ak_secret = 'xx'
end
# rails c
client = AliyunChatbot::Client.new


# or
client = AliyunChatbot::Client.new(ak_id, ak_secret)
# instance_id from chatbot infos
client.send_message("instance_id" , "message")

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/aliyun_chatbot. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).


