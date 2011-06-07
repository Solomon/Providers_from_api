
# == Schema Information
#
# Table name: places
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  complete   :boolean         default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#

class Place < ActiveRecord::Base

	scope :complete, where(:complete => true)
	scope :incomplete, where(:complete => false)

	validates :name, :presence => true
	

	attr_accessor :print_place


end
