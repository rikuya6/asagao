names = %w(Taro Jiro Hana John Mike Sophy Bill Alex Mary Tom)
fnames = ["佐藤", "鈴木", "高橋", "田中"]
gnames = ["太郎", "次郎", "花子"]
Member.create(
  number: 10,
  name: 'Rikuya',
  full_name: 'Rikuya Saito',
  email: 'rikuya@test.com',
  birthday: Date.current,
  gender: 0,
  administrator: true,
  password: 'password',
  password_confirmation: 'password'
)
1.upto(10) do |idx|
  Member.create(
    number: idx + 10,
    name: names[idx],
    full_name: "#{fnames[idx % 4]} #{gnames[idx % 3]}",
    email: "#{names[idx]}@example.com",
    birthday: "1981-12-01",
    gender: [0, 0, 1][idx % 3],
    administrator: (idx == 0),
    password: "password",
    password_confirmation: "password"
  )
end
