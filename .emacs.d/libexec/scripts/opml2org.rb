require "rexml/document"
require "pathname"

outliner_dir = Dir.glob(ARGV[0] + "*.opml")

# 再帰的に受け取った階層のノード以下をorgファイルに変換
def convirt_node(opmlelems, num, orgfile)
  if opmlelems != nil then # num階層目のノード一覧
    asterisks = "*" * num + " "
    opmlelems.elements.each("outline") do |node| #特定のノード
      status = "TODO "
      title = ""
      note = ""
      node.attributes.each do |key, value|
        if key == "text" then # ノードタイトル記録
          title = value + "\n"
        end
        if key == "_status" then # ステータス記録
          if value == "" then
            status = ""
          elsif value == "checked" then
            status = "DONE "
          end
        end
        if key == "_note" then # ノート記録
          note = value.chomp
          note = note + "\n"
        end
      end
      orgfile.write asterisks + status + title + note
      convirt_node(node, num+1, orgfile) # 再帰
    end
  end
end

# 保存ファイルオープン
orgfile = open(ARGV[1], "w")
orgfile.write "#+STARTUP: hidestars\n\n" 
outliner_dir.each do |opmlfile|
  opmldoc = nil
  # 読み込みファイルオープン
  # p File.basename(opmlfile)
  File.open(opmlfile) {|xmlfile|
    opmldoc = REXML::Document.new(xmlfile)
  }
  orgfile.write "* " + File.basename(opmlfile, ".opml") + "\n"
  opmlelems = opmldoc.elements['opml/body']
  # 関数呼び出し
  convirt_node(opmlelems,2,orgfile)
end
# ファイルを閉じる
orgfile.close
