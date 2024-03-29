class Contact < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true

  validates :email_address, :presence => true, :uniqueness => true
  before_save :check_and_set_name

  has_many :time_slots

  belongs_to :user #owner of the contact = business owner


  def self.synchronize(xero, current_user = nil)
    xero_contacts = xero.Contact.all(:order => 'Name')


    #add Xero contacts to local database -------------------------------------
    xero_contacts.entries.each do |contact|
      #try to find by guid
      local_contact = Contact.find_by_xero_uid(contact.contact_id)
      if !local_contact
        #try to find by email
        local_contact = Contact.find_by_email_address(contact.email_address)
        if !local_contact
          #create a new one
          Contact.create(:name => contact.name, :first_name => contact.first_name, :last_name => contact.last_name, :xero_uid => contact.contact_id, :email_address => contact.email_address, :user => current_user)
        end
      end
      if local_contact
        #update local information
        local_contact.update_attributes(:name => contact.name, :first_name => contact.first_name, :last_name => contact.last_name, :xero_uid => contact.contact_id, :email_address => contact.email_address, :user => current_user)

        #Upload bills start  #TODO: move to a private method for avoid duplication
        local_contact.time_slots.where(:billed => false).each do |time_slot|

          #create invoice item
          xero_items = xero.Item.all(:where => "Code==\"#{time_slot.event.title}\"")
          xero_item = nil
          if xero_items.empty?
            #create item
            xero_item = xero.Item.build(:code =>time_slot.event.title)
            xero_item.save
          else
            xero_item = xero_items.first
          end

          #generate Invoice

          invoice = xero.Invoice.build(:contact => contact, :type => 'ACCREC', :date => Date.today, :due_date => time_slot.starts_at )
          line_item = invoice.add_line_item({:item_code => time_slot.event.title,
                                             :description => time_slot.event.service.description,
                                             :quantity => 1,
                                             :unit_amount => time_slot.event.service.price,
                                             :tax_amount => 0.0,
                                             :account_code => 200})

          if invoice.save
            #billing made
            time_slot.update_attribute(:billed,true)
          end
        end
        #Upload bills end

      end

    end

    #add Xero contacts from local contacts -------------------------------------
    Contact.all.each do |contact|
      if contact.xero_uid.blank?
        #new contact --> Add to Xero
        remote_contact = xero.Contact.build(:name => contact.name)
        remote_contact.first_name = contact.first_name
        remote_contact.last_name = contact.last_name
        remote_contact.last_name = contact.last_name
        remote_contact.email_address = contact.email_address
        #contact.add_address(:type => 'STREET', :line1 => '12 Testing Lane', :city => 'Brisbane')
        #contact.add_phone(:type => 'DEFAULT', :area_code => '07', :number => '3033 1234')
        #contact.add_phone(:type => 'MOBILE', :number => '0412 123 456')
        remote_contact.save
      else
        #TODO: try to update contact from local data
        #begin
        remote_contact = xero.Contact.find(contact.xero_uid)
        #contact.name = "Another Name Change"
        #remote_contact.save

        #Upload bills start  #TODO: move to a private method for avoid duplication
        contact.time_slots.where(:billed => false).each do |time_slot|
          #generate billing
          invoice = xero.Invoice.build(:contact => remote_contact, :type => 'ACCREC')
          line_item = invoice.add_line_item({:description => time_slot.event.title , :quantity => 1, :unit_amount => time_slot.event.service.price, :tax_amount => 0.0, :account_code => 200})

          if invoice.save
            #billing made
            time_slot.update_attribute(:billed,true)
          end
        end
        #Upload bills end

      end
      begin
        remote_contact = xero.Contact.find(contact.xero_uid)
        #contact.name = "Another Name Change"
        #remote_contact.save

        #Upload bills start  #TODO: move to a private method for avoid duplication
        contact.time_slots.where(:billed => false).each do |time_slot|
          #generate billing
          invoice = xero.Invoice.build(:contact => remote_contact, :type => 'ACCREC')
          line_item = invoice.add_line_item({:description => time_slot.event.title , :quantity => 1, :unit_amount => time_slot.event.service.price, :tax_amount => 0.0, :account_code => 200})

          if invoice.save
            #billing made
            time_slot.update_attribute(:billed,true)
          end
        end
          #Upload bills end
      rescue Exception => e
        # do some logging
        puts e.to_s
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
