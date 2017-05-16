import Seedex

if Rentapay.Repo.aggregate(Rentapay.Entity.User, :count, :id) == 0 do
  password = Comeonin.Pbkdf2.hashpwsalt("qwerty$4")
  seed Rentapay.Entity.User, [
    %{login: "host@gmail.com", first_name: "Алексей", last_name: "Страшный", secured_password: password},
    %{login: "host1@gmail.com", first_name: "Тамара", last_name: "Афанасьева", secured_password: password},
    %{login: "tenant@gmail.com", first_name: "Бахмур", last_name: "Ыжич Кабул Оглы", secured_password: password}
  ]

  host_id = Rentapay.Repo.get_by(Rentapay.Entity.User, login: "host@gmail.com").id
  host1_id = Rentapay.Repo.get_by(Rentapay.Entity.User, login: "host1@gmail.com").id

  seed Rentapay.Entity.Rent, [
    %{street: "Осенний бульвар", house: "21", foor: 4,  flat_numbler: 21, rooms: 1, price: 50_000, entrance: 1,
      minimal_rent_months: 4, credit_payment_enabled: true, suppossed_start_date: nil, owner_id: host1_id,
      description: "Квартира с чистой отделкой, косметический ремонт, мебель и бытовая техника установлены в 2010. Все в отличном состоянии"},

    %{street: "Первомайская", house: "52", floor: 2, flat_number: 65, rooms: 2, price: 45_000, entrance: 2,
      minimal_rent_months: nil, credit_payment_enabled: false, suppossed_start_date: "2017-09-01", owner_id: host_id,
      description: "Квартира абсолютно пустая. Без отделки, Ремонт будет компенсирован по чекам и квитанциям."},

    %{street: "2-я хуторская", house: "44 стр 4", floor: 1, flat_number: 4, rooms: 4, price: 55_000, entrance: 1,
      minimal_rent_months: nil, credit_payment_enabled: true, suppossed_start_date: "2017-06-14", owner_id: host_id,
      description: nil},

    %{street: "Сходненская", house: "14", floor: 14, flat_number: 476, rooms: 3, price: 67_000, entrance: 6,
      minimal_rent_months: 2, credit_payment_enabled: true, suppossed_start_date: nil, owner_id: host1_id,
      description: "Уютная трешка на сходне. Вид на чудесный парк. Рядом вся инфраструктура – детсад, школа, парковка супермаркеты и спорткомплекс с бассейном. Рассмотрим приличную семью из 3-4 человек. Славян"},

    %{street: "Ленинский проспект", house: "24", floor: 4, flat_number: 17, rooms: 1, price: 37_000, entrance: 1,
      minimal_rent_months: 2, credit_payment_enabled: true, suppossed_start_date: nil, owner_id: host_id,
      description: "Студия на ленинском в отличном состоянии. Евроремонт, на окнах стеклопакеты. Мебель, бытовая техника, ультрапроектор. Система \"Умный дом \" и сигнализация с кнопкой экстренного выхова"},

    %{street: "Кутузовский проспект", house: "21", floor: 34, flat_number: 176, rooms: 6, price: 267_000, entrance: 1, 
      minimal_rent_months: 8, credit_payment_enabled: false, suppossed_start_date: "2016-7-01", owner_id: host_id,
      description: "Уютный пентхаус со всеми удобствами и шикарным видом. Все документы строго в порядке. 
      Рассматриваем обеспесеных иностранцев (дальнее зарубежье), либо компанию (для сотрудников)"}
  ]
end

