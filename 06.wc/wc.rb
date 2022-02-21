#ファイル内の行数、ワード数、およびバイト数
#-l	行数をカウントします。 

# methodA
	# - ファイル内の行数 == method a1
	# -	ワード数 == method a2
	# -	およびバイト数 == method a3
	# ..の表示 

		# method a1
		# -	ファイル内の行数の数値の取得
		# method a2 
		# - ワード数の取得
		#	method a3
		# - およびバイト数の取得
		
# ディレクトリを指定した場合
# wc: ../: read: Is a directory
	#  0       0       0 total

def output(str, f)
  get_file_lines(str)
  get_words_count(str)
	get_bytes_values(f)
	puts " #{f}"
end

def get_file_lines(str)
	print "       "
	print str.count("\n")
end

def get_words_count(str)
	ary = str.split(/\s+/)
	print "       "
	print ary.size
end

def get_bytes_values(f)
	print "      "
	print File.size(f)
end

def main
	filesnames = ARGV
	filesnames.each do |f|
		str = File.read(f)
		output(str, f)
	end
end

main