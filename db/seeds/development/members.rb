names = %w(Taro Jiro Hana John Mike Sophy Bill Alex Mary Tom)
fnames = %w(佐藤 鈴木 高橋 田中)
gnames = %w(太郎 二郎 花子)
0.upto(9) do |idx|
  Member.create(
    number: idx + 10,
    name: names[idx],
    full_name: "#{fnames[idx % fnames.length]} #{gnames[idx % gnames.length]}",
    email: "#{names[idx]}@example.com",
    birthday: '1981-12-01',
    gender: [0, 0, 0][idx % 3],
    administrator: idx.zero?,
    password: 'password',
    password_confirmation: 'password'
  )
end
