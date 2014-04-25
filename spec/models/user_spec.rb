require 'spec_helper'

describe User do
  it { should have_secure_password }
  it { should have_db_column(:name).of_type(:string) }
  it { should have_db_column(:email).of_type(:string) }
  it { should have_many(:game_rooms) }
  it { should have_many(:games) }
end

describe GameRoom do
  it { should have_db_column(:room_name).of_type(:string) }
  it { should have_db_column(:game_id).of_type(:integer) }
  it { should have_db_column(:user_id).of_type(:integer) }
  it { should belong_to(:owner) }
  it { should belong_to(:game) }
end

describe Piece do
  it { should have_db_column(:color).of_type(:string) }
  it { should have_many(:moves) }
end

describe Move do
  it { should have_db_column(:position).of_type(:string) }
  it { should have_db_column(:piece_id).of_type(:integer) }
  it { should have_db_column(:game_id).of_type(:integer) }
end
