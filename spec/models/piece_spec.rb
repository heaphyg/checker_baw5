require 'spec_helper'

describe Piece do
  it { should have_db_column(:location).of_type(:string) }
  it { should have_db_column(:is_king).of_type(:boolean) }
  it { should have_db_column(:game_id).of_type(:integer) }
  it { should belong_to(:game) }
end
