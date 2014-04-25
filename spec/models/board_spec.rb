require 'spec_helper'

describe Board do
  it { should have_db_column(:coord).of_type(:string) }
  it { should have_db_column(:is_occupied).of_type(:boolean) }
  it { should have_db_column(:game_id).of_type(:integer) }
  it { should belong_to(:game) }
end
