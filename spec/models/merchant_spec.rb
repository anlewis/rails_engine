require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:invoices) }
    it { should respond_to(:invoices) }
    it { should have_many(:items) }
    it { should respond_to(:items) }
    it { should have_many(:customers) }
    it { should respond_to(:customers) }
  end
end
