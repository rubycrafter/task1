class Page < ActiveRecord::Base
  # Page name can content: latin, cyrillic, numbers, underscore
  validates :name, format: { with: /\A[а-яА-ЯёЁa-zA-Z0-9_]+\z/,
                             message: "Page name can content: latin, cyrillic, numbers, underscore" }
  # Page name have to be unique
  validates :name, uniqueness: true, presence: true

  # Communications, forming a tree structure
  # @page.subpages and @page.suprapage are avaiable now
  has_many    :subpages,  class_name:   "Page",
                          foreign_key:  "suprapage_id",
                          dependent:    :destroy
  belongs_to  :suprapage, class_name:   "Page"
end
