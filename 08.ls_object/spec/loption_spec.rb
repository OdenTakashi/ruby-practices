require 'spec_helper'

RSpec.describe 'Loption' do
  it 'return_file_path' do 
    argv = ["-a", "../"]
    Director.new(argv).result
  end
end
