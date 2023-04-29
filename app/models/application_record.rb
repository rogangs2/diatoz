class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def author?
    self.is_a?(Author)
  end

  def subscriber?
    self.is_a?(Author)
  end
end
