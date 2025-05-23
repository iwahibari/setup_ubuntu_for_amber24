# setup_ubuntu_for_amber24

## 説明
Ubuntu24にAmber24をインストールするための初期セットアップ用スクリプトです。  
01から順番に実行してください（注意あり：実行方法の項で記載）。
本セットアップ完了後Amberをインストールします。

## 環境
- Amber24をGPU付きのUbuntu24で使う
- GPU:NVIDIA

## 実行方法
### 1. ubuntuにgitをインストール
   ```sh
   sudo apt install git
   ```
  
### 2. 本リポジトリをclone
   ```sh
   git clone https://github.com/iwahibari/setup_ubuntu_for_amber24.git
   ```
### 3. `setup_ubuntu_for_amber24`ディレクトリで`01_install_general.sh`を実行
   ```sh
   cd setup_ubuntu_for_amber24
   sudo bash ./01_install_general.sh
   ```
   > 実行できない場合は、`setup_ubuntu_for_amber24`があるディレクトリで`chmod -R 764　./setup_ubuntu_for_amber24`を実行
### 4. すべて[OK]の表示の場合、再起動`reboot`
### 5. `02_install_gpudriver_cuda.sh`の通りに実行  
   ```sh
   sudo sh ./NVIDIA-Linux-x86_64-570.144.run
   sudo sh ./cuda11.8.0_520.61.05_linux.run
   ```
### 6. pathを`~/.bashrc`に追加（現在テスト中）
    03_add_path_cuda.shのスクリプトだと現状正常に動作しません。
