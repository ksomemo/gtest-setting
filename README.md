gtest-setting
=============

gtestをダウンロードして、各プロジェクト用に設定するシェルです。

概要
=============
プロジェクト直下にvendorディレクトリを作成し、その中にgtestのソース及びコンパイル済みファイルが格納されます。

vendorディレクトリにgtestの実行をテストコードを指定するだけで実行できるようにするシェルを作成します。

制約
=============
* version1.6固定
* プロダクトコードは、プロジェクト直下のsrcディレクトリに格納すること
* テストコードは、プロジェクト直下のtestディレクトリに格納すること

使い方
=============
``` sh
# setting
cd path/to/projectRoot
clone this repository
sh repository/setting.sh
mkdir src test

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
