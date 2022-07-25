# オブジェクト指向ボウリング
- 引数で与えられたshotからスコアを計算する
 1. 引数で与えられた数字をフレームごとに分ける
 2. フレームごとのスコアの計算
 3. スペアやストライクの場合は特殊な処理
 4. トータルのスコアを計算

とりあえずスコアが１フレームから試す
 - フレームクラスで十分その計算はできる
 - つまり、フレーム数が増えることが問題
 - 与えられた数字を２つづつに切り分ける作業のあたりが見えない

## 与えられた数字を２つづつに切り分ける作業のあたりが見えない

### 与えられた数字を受ける

### ２つづつに切り分ける,

```ruby
#引数が10個なのが気持ち悪い
	def initialize(first_frame, second_frame = nil, ... tenth_frame = nil)
		@first_frame = Frame.new(first_frame)
		@second_shot = Frame.new(second_frame)
    .
    .
    @tenth_frame = Frame.new(tenth_frame)
	end

game = Game.new(frames)
frames = 
[[1,3][2,4][3,2][2,1][5,2][4.2][2,3][1,9][2,3][1,2,4]]

def intitalize(frames)
  frames.each do |frame|
    Frame.new(frame)
  end
end

frames
=> [{first_frame: [1,2], second_frame: [4,1], ... tenth_frame: [4,3]}]

引数を受け取ります。
引数を配列に変えます。
xを１０に変換します。
１０に変換したフレームの相手は０にしたい
フレームごとに分割したい。

ゲームは一つしか作らないからゲームインスタンス自体にフレーム情報を持たせる必要はないかも？

クラス分けの際はそのクラスがどこまで見えているのかを考える！@frames = marks.map { |mark| Frame.new(mark)}
Frame.new([6,3])
Frame.newへの引数が一つ扱いになっている。

[1, 2, 3] => (1,2,3)

  # def score
  #   point = frames[0..7].each_with_index.sum do |frame, idx|
  #     if frame.strike? && frames[idx + 1].strike? 
  #       frame.score + frames[idx + 1].score + frames[idx + 2].first_shot.mark
  #     elsif frame.strike?
  #       frame.score + frames[idx + 1].score
  #     elsif frame.spare?
  #       frame.score +  frames[idx + 1].first_shot.mark
  #     else
  #       frame.score
  #     end
  #   end

  #   point += frames[8].strike? ? frames[8].score + frames[9].score : frames[8].score

  #   point + frames[9].final_score
  # end
