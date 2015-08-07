class Page < ActiveRecord::Base
  # Page name can content: latin, cyrillic, numbers, underscore
  validates :name, format: { with: /\A[а-яА-ЯёЁa-zA-Z0-9_]+\z/,
                             message: "может содерждать только буквы и цифры" }

  # Communications, forming a tree structure
  # @page.subpages and @page.suprapage are avaiable now
  has_many    :subpages,  class_name: "Page",
                          foreign_key: "suprapage_id"
  belongs_to  :suprapage, class_name: "Page"
end
