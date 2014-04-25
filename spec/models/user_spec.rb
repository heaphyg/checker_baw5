require 'spec_helper'

describe User do
  it { should have_secure_password }
  it { should have_db_column(:name).of_type(:string) }
  it { should have_db_column(:email).of_type(:string) }
  it { should have_many(:game_rooms) }
  it { should have_many(:games) }
end



