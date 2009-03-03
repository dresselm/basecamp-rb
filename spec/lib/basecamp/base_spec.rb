require File.dirname(__FILE__) + '/../../spec_helper.rb'

describe Basecamp::Base do
  before(:each) do
    establish_connection
  end
  
  describe "Creating a resource" do
    it "should create a comment for post" do      
      comment = Basecamp::Comment.new(:post_id => TEST_MESSAGE_ID)
      comment.body = "test comment"
      comment.save

      c = Basecamp::Comment.find(comment.id)
      c.body.should == "test comment"
      c.id.should == comment.id.to_i      
    end
  end
    
  describe "Finding a resource" do 
    it "should find message" do
      message = Basecamp::Message.find(TEST_MESSAGE_ID)
      message.body.should_not be_blank
      message.category_id.should_not be_blank
    end
  end
  
  describe "Updating a Resource" do 
    it "should update message" do
      m = Basecamp::Message.find(TEST_MESSAGE_ID)
      m.body = 'Changed'
      m.save
      message = Basecamp::Message.find(TEST_MESSAGE_ID)
      message.body.should == 'Changed'
    end
  end
  
  describe "Deleting a Resource" do
    it "should delete todo item" do
      todo = Basecamp::TodoItem.create(:todo_list_id => TEST_TODO_LIST_ID, :content => 'Todo for destroy')
      Basecamp::TodoItem.delete(todo.id)
    end
  end
end
