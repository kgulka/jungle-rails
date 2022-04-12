require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
   
    #test password and password confirmation not equal -case sensitive
    it "should fail if password and password confirmation not equal"  do
      usr = User.new( first_name:"First1", last_name:"Last1", email: "here@therE.com", password: "password1", password_confirmation: "password")
      usr.validate
      expect(usr.errors.full_messages[0]).to eq("Password confirmation doesn't match Password")
    end
    #test password are required
    it "should fail if password missing"  do
      usr = User.new( first_name:"First1", last_name:"Last1", email: "here@there.com", password_confirmation: "password")
      usr.validate
      expect(usr.errors.full_messages[0]).to eq("Password can't be blank")
    end    
    # test that password is 3 char or longer
     it "should fail if password length < 3"  do
      usr = User.new( first_name:"First1", last_name:"Last1", email: "here@there.com", password: "pd", password_confirmation: "pd")
      usr.validate
      expect(usr.errors.full_messages[0]).to eq("Password is too short (minimum is 3 characters)")
    end  
    #test password confirmation are required
    it "should fail if password confirmation missing"  do
      usr = User.new( first_name:"First1", last_name:"Last1", email: "here@there.com", password: "password")
      usr.validate
      expect(usr.errors.full_messages[0]).to eq("Password confirmation can't be blank")
    end 
     #test email is unique in db - not case sensitive
     it "should fail if email is not unique"  do
      usr1 = User.new( first_name:"First1", last_name:"Last1", email: "here@there.com", password: "password", password_confirmation: "password")
      usr1.save
      usr2 = User.new( first_name:"First1", last_name:"Last1", email: "here@therE.com", password: "password", password_confirmation: "password")
      usr2.validate
      expect(usr2.errors.full_messages[0]).to eq("Email has already been taken")
    end 
    #test email required
    it "should fail if email missing"  do
      usr = User.new( first_name:"First1", last_name:"Last1", password: "password", password_confirmation: "password")
      usr.validate
      expect(usr.errors.full_messages[0]).to eq("Email can't be blank")
    end    
    #test first name required
    it "should fail if first name missing"  do
      usr = User.new( last_name:"Last1", email: "here@there.com", password: "password", password_confirmation: "password")
      usr.validate
      expect(usr.errors.full_messages[0]).to eq("First name can't be blank")
    end
    #test last name required
    it "should fail if last name missing"  do
      usr = User.new( first_name:"First1", email: "here@there.com", password: "password", password_confirmation: "password")
      usr.validate
      expect(usr.errors.full_messages[0]).to eq("Last name can't be blank")
    end
  end
  describe '.authenticate_with_credentials' do
    # examples for this class method here
    it "should return a user if the password is correct" do
      usr1 = User.new( first_name:"First9", last_name:"Last9", email: "here9@there.com", password: "password9", password_confirmation: "password9")
      usr1.save
      expect(User.authenticate_with_credentials("here9@there.com", "password9")).to be_a User
    end
    it "should return nil if the password is wrong" do
      usr1 = User.new( first_name:"First10", last_name:"Last10", email: "here10@there.com", password: "password10", password_confirmation: "password10")
      usr1.save
      expect(User.authenticate_with_credentials("here10@there.com", "password11")).to be nil
    end    
    it "should return a user the email CASE is different " do
      usr1 = User.new( first_name:"First8", last_name:"Last8", email: "here8@there.com", password: "password8", password_confirmation: "password8")
      usr1.save
      expect(User.authenticate_with_credentials("HERE8@there.com", "password8")).to be_a User
    end
    it "should still return a user if the email has leading or trailing spces" do
      usr1 = User.new( first_name:"First2", last_name:"Last2", email: "here2@there.com", password: "password2", password_confirmation: "password2")
      usr1.save
      expect(User.authenticate_with_credentials("   here2@there.com ", "password2")).to be_a User
    end
  end
end
