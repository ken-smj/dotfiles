require "rexml/document"
require "fileutils"
require "pathname"

orgfile = open(ARGV[0], "r") # 入力(orgファイル)オープン
outliner_dir = ARGV[1] # アウトプットディレクトリ設定

def get_title(node, level)
  strlen = node.chomp.split(//u).length
  node[level+1..strlen].chomp
end

def save_node(dir, doc)
  file_pass = dir + doc.elements['opml/head/title'].text + ".opml"
  open(file_pass, "w") { |f|
    # p doc.elements['opml/head/title'].text + ".opml"
    f.write doc           # ファイル出力
  }
  buffer = File.open(file_pass,"r").read()
  buffer.gsub!("&amp;#10;", "&#10;")    # 改行コードを元に戻す
  open(file_pass, "w") { |f|
    f.write buffer
  }  
end

def make_node(line, level, pnode)
  strlen = line.chomp.split(//u).length
  title = line[level+1..strlen].chomp

  if title[0..3] == "TODO"
    cnode = pnode.add_element("outline", {"text" => title[5..strlen]})
  elsif title[0..3] == "DONE"
    cnode = pnode.add_element("outline", {"text" => title[5..strlen]})
    cnode.add_attribute("_status", "checked")
  else
    cnode = pnode.add_element("outline", {"text" => title})
    cnode.add_attribute("_status", "")
  end
  cnode
end

# ファイルを逃がす
outliner_files = Dir.glob(outliner_dir + "*.opml")
if File.exist?(outliner_dir + 'backup') == false then
  Dir::mkdir(outliner_dir + 'backup')
end
FileUtils.mv(outliner_files, outliner_dir + 'backup')

open(ARGV[0], "r") {|f|
  old_level = 0
  doc = REXML::Document.new
  pnode = REXML::Document.new
  cnode = REXML::Document.new
  f.each {|line|
    if /^\* / =~ line then      # もし、先端ノードなら
      new_level = 1
      if new_level < old_level then # もし、昔のノードがあれば
        save_node(outliner_dir, doc) # docをファイル出力
      end
      # xmlドキュメント作成
      doc = REXML::Document.new
      opml = doc.add_element("opml", {"version" => "1.0"})
      head = opml.add_element("head")
      head.add_element("title").add_text get_title(line, new_level)
      cnode = opml.add_element("body") # 現在のノードを記録
      old_level = new_level
    elsif /^\*\*+ / =~ line then # 先端ノード以外
      new_level = line.index("* ") + 1
      if old_level == new_level then # 同一階層の場合
        cnode = make_node(line, new_level, pnode)
      elsif old_level < new_level then # 一つ深い階層の場合
        pnode = cnode           # 一つ前のノードを親にする
        cnode = make_node(line, new_level, pnode)        
        old_level = new_level
      elsif old_level > new_level then    # 階層が上がった場合
        for i in 1..(old_level-new_level) # 階層が上がった分だけ
          pnode = pnode.parent    # 親ノードのを一つ上の階層にずらす
        end
        cnode = make_node(line, new_level, pnode)
        old_level = new_level
      end
    else                        # ノードではないとき
      # ノートとして処理
      addednote = line.gsub("\n", "&#10;")
      note = cnode.attributes['_note']
      if note != nil then # ノートがすでに有れば
        cnode.add_attribute("_note", note + addednote) # 追加で書き込み
      else                      # ノートがなければ
        cnode.add_attribute("_note", addednote) # 属性を新規作成
      end
    end
  }
  save_node(outliner_dir, doc)  # 最後のノードを出力
}

# ファイルを閉じる
orgfile.close
