require 'spec_helper'

describe UserGame do
  it {should have_db_column(:game_id).of_type(:integer) }
  it {should have_db_column(:user_id).of_type(:integer) }
  it { should belong_to(:game) }
  it { should belong_to(:user) }
end
