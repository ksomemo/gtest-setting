gtest-setting
=============

gtestをダウンロードして、各プロジェクト用に設定するシェルです。

概要
=============
* プロジェクト直下にvendorディレクトリを作成します
* その中にgtestのソース及びコンパイル済みファイルが格納されます
* vendorディレクトリにgtestの実行をテストコードを指定するだけで実行できるようにするシェルを作成します
* インストール時に、コンパイラを選べます(gcc,clang)
* インストール時に、標準ライブラリとしてC++11を使えるか選べます

ただし、clang,C++11の組み合わせはgtestと相性が悪いためおすすめしません。パッチを当てると解消されるようですが、そのパッチは当てていません。


制約
=============
* version1.6固定
* プロダクトコードは、プロジェクト直下のsrcディレクトリに格納すること
* テストコードは、プロジェクト直下のtestディレクトリに格納すること

srcおよびtestディレクトリはインストール時に作成されます

使い方
=============
``` sh
# setting
cd path/to/projectRoot
curl -O https://raw.github.com/ksomemo/gtest-setting/master/setting.sh \
&& chmod +x setting.sh \
&& ./setting.sh \
&& rm setting.sh

# またはcloneして実行
# 直接実行できない理由は、getoptsを使用しているため

# create test codeand project code

# test code execution
cd path/to/projectRoot
sh vendor/gtest-exec.sh test/yourTestCode

# or
cd path/to/projectRoot/test
sh ../vendor/gtest-exec.sh yourTestCode
```

TODO
=============
* 
