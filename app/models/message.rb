class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user

  validates :content_klass, presence: true
  validate :is_valid_klass

  validates :content_id, presence: true

  after_create_commit { MessageBroadcastJob.perform_later(self) }

  def set_content(type, content)
    message_content = type.constantize.data_to_obj(content)

    self.content_klass = type
    self.content_id = message_content.id
  end

  def render
    content_object = self[:content_klass].constantize.find_by(id: self[:content_id])
    return "" unless content_object

    content_object.render
  end

  def is_valid_klass
    klass = self[:content_klass].constantize
    unless klass && klass.method_defined?(:render)
      errors.add(:content_klass, "Content class is not valid")
    end

  rescue
    errors.add(:content_klass, "Content class is not valid")
  end
end
