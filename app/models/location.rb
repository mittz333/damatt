class Location < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: '大阪' },
    { id: 2, name: '東京' },
    { id: 3, name: '岡山' },
    { id: 4, name: '北海道' },
    { id: 5, name: '九州' },
    { id: 6, name: '名古屋' },
    { id: 8, name: '東北' },
    { id: 10, name: 'その他' }
  ]

    include ActiveHash::Associations
    has_many :items

  end