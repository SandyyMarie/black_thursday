require 'helper'
require 'findable'
require 'existable'

class Repository
  include Findable
  include Existable

  attr_accessor :all

  def initialize(file_path)
    @all = make_repo(file_path)
  end

  def make_repo(file_path)
    thing = evaluate
    repo = Array.new
    CSV.foreach(file_path, headers: true, header_converters: :symbol){|row| repo.push(thing.new(row))}
    repo
  end
end
