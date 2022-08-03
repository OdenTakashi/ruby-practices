require 'spec_helper.rb'

RSpec.describe Ls do
  it "return file" do 
    ARGV = []
    ls = Ls.new(ARGV)
    expect(ls.directory_names).to eq "lib"
  end
end
