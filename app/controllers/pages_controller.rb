class PagesController < ApplicationController

  before_filter :find_event_and_slot, only: [:confirmation]

  def home
  end

  def about
  end

  def more
  end

  def evenmore
  end

  def confirmation
  end

end
