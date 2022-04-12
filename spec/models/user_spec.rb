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
end
