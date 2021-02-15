class Category < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 11, name: 'ノートPC' },
    { id: 12, name: 'タブレット' },
    { id: 19, name: 'その他PC' },
    { id: 1, name: '--' },
    { id: 21, name: 'カメラ' },
    { id: 22, name: 'オーディオ機器' },
    { id: 29, name: 'その他電気製品' },
    { id: 2, name: '--' },
    { id: 31, name: '乗用車' },
    { id: 39, name: 'その他車' },
    { id: 3, name: '--' },
    { id: 99, name: 'その他' }
  ]

    include ActiveHash::Associations
    has_many :items

  end