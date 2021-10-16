module EmailValidable
  extend ActiveSupport::Concern

  included do
    validates :email, presence: true,
                      uniqueness: { case_sensitive: false },
                      format: { with: Regexp::EMAIL }
  end
end
