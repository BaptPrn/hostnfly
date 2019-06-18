require 'rails_helper'

describe Mission do
  it { should belong_to(:listing) }
end
