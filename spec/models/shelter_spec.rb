require 'rails_helper'

describe Shelter, type: :model do
  describe 'relationships' do
    it {should have_many(:pets).dependent(:destroy)}
  end
end
