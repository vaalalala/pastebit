require 'spec_helper'
require_relative '../lib/content_storer'
require 'digest'

describe ContentStorer do
  let(:example_content){"Hello World!\nHere is some basic content!\n"}
  let(:example_content_1){example_content}
  let(:example_content_2){"This content is different!"}

  describe '#store' do
    it 'returns a key string for the content' do
      key = subject.store example_content
      key.should =~ /[a-zA-Z0-9]{16,}/
    end

    it 'returns a different key string for different content' do
      key_1 = subject.store example_content_1
      key_2 = subject.store example_content_2

      key_1.should_not == key_2
    end

    it 'returns the same key string for the same content' do
      key_1 = subject.store example_content
      key_2 = subject.store example_content

      key_1.should == key_2
    end

    it 'returns an empty key string for nil content' do
      key = subject.store nil
      key.should == ''
    end

    it 'returns an empty key string for empty content' do
      key = subject.store ''
      key.should == ''
    end

    it 'the key is not just the SHA1 of the content' do
      key = subject.store example_content
      key.should_not == Digest::SHA1.hexdigest(example_content)
    end
  end

  describe "#retreive" do
    it "returns the content when given a valid key" do
      key = subject.store example_content
      
      subject.retreive(key).should == example_content
    end

    it "returns nil if there is no content for that key" do
      subject.retreive("invalid key").should be_nil
    end

  end

end
