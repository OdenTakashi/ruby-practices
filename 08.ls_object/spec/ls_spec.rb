require 'spec_helper.rb'

RSpec.describe Ls do
  # it "return_pwd" do 
  #   ARGV = []
  #   ls = Ls.new(ARGV)
  #   expect(ls.directory_names).to eq ["/Users/kodamanaoki/ruby-practices/08.ls_object"]
  # end

  # it "return_aimed_directory" do
  #   ls = Ls.new(['lib'])
  #   expect(ls.directory_names).to eq ['lib']
  # end

  # it "return_aimed_files" do 
  #   ls = Ls.new(['lib', 'spec'])
  #   expect(ls.files).to eq "{:lib=>["ls.rb"], :spec=>["spec_helper.rb", "examples.txt", "ls_spec.rb"]}"
  # end

  # it "return_files" do 
  #   ls = Ls.new([])
  #   expect(ls.files).to eq ['spec', 'lib']
  # end

  # it "return_result" do 
  #   ls = Ls.new(['../'])
  #   expect(p ls.result).to eq ('ls.rb')
  # end

  it "return_devided_files" do 
    ls = Ls.new(['../'])
    expect(ls.devide).to eq [["01.fizzbuzz", "02.calendar", "03.rake", "04.bowling"], ["05.ls", "06.wc", "07.bowling_object", "08.ls_object"], ["09.wc_object", "Gemfile", "Gemfile.lock", "README.md"]]
  end

  # it "return_devided_files" do 
  #   ls = Ls.new(['../'])
  #   expect(ls.result).to eq [["01.fizzbuzz", "02.calendar", "03.rake", "04.bowling"], ["05.ls", "06.wc", "07.bowling_object", "08.ls_object"], ["09.wc_object", "Gemfile", "Gemfile.lock", "README.md"]]
  # end
end
