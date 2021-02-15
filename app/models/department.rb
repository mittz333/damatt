class Department < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 11, name: '大阪技術・管理' },
    { id: 12, name: '大阪営業' },
    { id: 13, name: '大阪工場' },
    { id: 14, name: '大阪設備' },
    { id: 15, name: '総務部' },
    { id: 16, name: '人材部' },
    { id: 17, name: '開発営業２B' },
    { id: 18, name: '開発営業２C' },
    { id: 21, name: '東京支社' },
    { id: 22, name: '東京営業' },
    { id: 31, name: '岡山工場' },
    { id: 32, name: '岡山営業' },
    { id: 41, name: '北海道工場' },
    { id: 42, name: '北海道営業' },
    { id: 51, name: '九州営業' },
    { id: 61, name: '名古屋営業' },
    { id: 81, name: '東北営業' },
    { id: 99, name: 'その他' }
  ]

    include ActiveHash::Associations
    has_many :users
    has_many :items

  end