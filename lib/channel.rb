class Channel
  attr_reader :name, :id, :purpose, :is_archived, :is_general, :members

  def initialize(name, id, options = {} )
    raise ArgumentError if name == nil || name == "" || id == nil || id == ""

    @name = name
    @id = id

    @purpose = options[:purpose]
    @is_archived = options[:is_archived]
    @is_general = options[:is_general]
    @members = options[:members]
  end
end
