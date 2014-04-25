require 'spec_helper'

describe GameRoom do
  it { should have_db_column(:room_name).of_type(:string) }
  it { should have_db_column(:game_id).of_type(:integer) }
  it { should have_db_column(:user_id).of_type(:integer) }
  it { should belong_to(:owner) }
  it { should belong_to(:game) }
end
