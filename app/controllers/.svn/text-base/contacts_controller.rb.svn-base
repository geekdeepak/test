class ContactsController < ApplicationController

  before_filter :dont_display_projects
  before_filter :require_owner, :only => [:confirm]

  def index
    if @life
      @my_contacts = @life.contacts_from.find(:all, :include => :lives)
    else
      @my_contacts = @current_user.contacts_from.find(:all, :include => :lives)
      @contacts_me = @current_user.contacts_to.find(:all, :include => :lives)
      
      @my_contacts.each do |contacter|
        @contacts_me.each do |contactee|
          @contacts_me.delete contactee if contacter.contactee == contactee.contacter
        end
      end
    end
  end
  
  def new
    @contact = Contact.new
    setup_new_contact
  end
  
  def create
    user = User.find(params[:user][:id])
    has_contact = false
    @life.contacts_from.each do |contact|
      has_contact = true if contact.contactee == user
    end
    if user && !has_contact
      @contact = Contact.new
      @contact.contactee = user
      @contact.contacter = @current_user
      @contact.contacter_life = @life
      if @contact.save
        @contact.contactee.deliver_contact_add_notification!(@contact)
        send_contact_message(user)
        flash[:notice] = "Contact added"
        redirect_to life_contacts_path(@life)
      end
    else
      setup_new_contact
      flash[:error] = "User not found"
      render :action => 'new'
    end
  end
  
  def confirm
  end
  
  def update
    @contact = Contact.find(params[:id])
    @contact.contactee_life = Life.find(params[:contact][:contactee_life_id])
    @contact.token = nil
    if @contact.save
      @contact.contacter.deliver_contact_added_notification!(@contact)
      flash[:notice] = "Contact allowed"
      redirect_to life_contacts_path(@contact.contactee_life)
      send_contact_added_message(@contact.contacter)
    end
  end
  
  private
  
    def setup_new_contact
      @users = User.all
      @users.delete @current_user
      @life.contacts_from.each do |contact|
        @users.delete contact.contactee
      end
    end
    
    def unique_contacts
      @my_contacts.each do |contact|
        @my_contacts.delete contact if contact[0] == @current_user
        contact[1].uniq!
      end
    end
    
    def require_owner
      @contact = Contact.find(:first, :conditions => {:token => params[:id]})
      unless @contact.contactee == @current_user
        flash[:error] = "You must be the owner of the link to accept it"
        redirect_to contacts_path
      end
    end
    
    def send_contact_message(user)
      @message = Message.new
      @message.user = user
      @message.sender_id = @contact.contacter.id
      @message.sender = @contact.contacter.username
      @message.subject = "New Contact Request"
      @message.body = "#{@message.sender} has added you to their contacts. <br />"+
        "To see their profile just click the link below: <br />"+
        "<a href=\"#{url_for(contacts_url)}\">#{url_for(contacts_url)}</a> <br />"+
        "If the above URL does not work try copying and pasting it into your browser. <br />"+
        "If you continue to have problem please feel free to contact us. <br />"
      @message.save
    end
end
