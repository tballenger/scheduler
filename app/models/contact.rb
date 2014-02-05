class Contact < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true

  validates :email_address, :presence => true, :uniqueness => true
  before_save :check_and_set_name

  def self.synchronize(xero)
    contacts = xero.Contact.all(:order => 'Name')
    emails_list = []
    contacts.entries.each do |contact|
      #try to find by guid
      local_contact = Contact.find_by_xero_uid(contact.contact_id)
      if !local_contact
        #try to find by email
        local_contact = Contact.find_by_email_address(contact.email_address)
        if !local_contact
          #create a new one
          Contact.create!(:name => contact.name, :first_name => contact.first_name, :last_name => contact.last_name, :xero_uid => contact.contact_id, :email_address => contact.email_address)
        end
      end
    end
  end

  private
  def check_and_set_name
    if self.name.blank?
      self.name = "#{self.first_name} #{self.last_name} "
    end
  end

end
