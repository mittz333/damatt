# Dir[File.join(Rails.root, "lib", "core_ext", "*.rb")].each {|l| require l }
# 結局、使用したいファイルの頭に「require 'core_exts/xxx」のような記述が必要みたい。。