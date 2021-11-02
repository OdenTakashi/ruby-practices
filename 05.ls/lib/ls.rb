# frozen_string_literal: true

argument = ARGV
argument.push(Dir.pwd) if argument.size <= 0

def gets_argument(argument)
  counter = 0
  argument.each do |p|
    counter += 1
		#ファイルの情報を受け取って、変数に代入
    get_file = Dir.glob('*', base: p)
		#ファイルの中で一番長い文字の値を取得
    argument_of_size = get_file.map(&:size)
    @maximum_size = argument_of_size.max
		#引数が2個以上与えられた時、ディレクトリ名：のように出力
    puts "#{p}:" if argument.size > 1
    make_jam(get_file)
    out_puts(@final_sort_order)
		#引数が2個以上与えられた時、一つ目の出力と二つ目の出力の間に空行
    if counter == 1 && argument.size >= 2
      puts '  '
      puts '  '
    end
  end
end

def make_jam(get_file)
	#3つに分割する際に、３で割り切れない時はnilで帳尻合わせ
  case get_file.size % 3
  when 1
    2.times do
      get_file.push(nil)
    end
  when 2
    get_file.push(nil)
  end
	#3行に出力するためにファイル数を３つに均等に分割
  @one_third_mom = get_file.size / 3
  @one_third_file = get_file.each_slice(@one_third_mom).to_a
  @final_sort_order = @one_third_file.transpose
end

def out_puts(_final_sort_order)
  count = 0
  @final_sort_order.each do |e|
    e.each do |f|
      count += 1
			#3つごと出力
      if (count % 3).zero? && !f.nil?
        puts f
			#一番文字数の多いファイル+5に幅を合わせる
      elsif count % 3 != 0 && !f.nil?
        print f.ljust(@maximum_size + 5)
      end
    end
  end
end
gets_argument(argument)
