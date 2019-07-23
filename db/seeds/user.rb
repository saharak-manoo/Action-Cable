photos = ['https://vignette.wikia.nocookie.net/green-productions-rise-of-sqeegee/images/5/54/Link.jpg/revision/latest/scale-to-width-down/480?cb=20141223230033',
          'https://scontent.fbkk10-1.fna.fbcdn.net/v/t1.0-9/47202192_513511669127104_679542613107277824_n.jpg?_nc_cat=107&_nc_eui2=AeEWbGLU6jHXsyi7sR_s0JWN1-9-275KEAr7C_ML-qtuEctnAUzE29hdZrcpF0qjaQhcd0BWM-rJNheSHKXkA2G_oDwWPrHujCVCymPUVCO4vA&_nc_ht=scontent.fbkk10-1.fna&oh=cb52cf6e854dd4e90a1e99b5be65b5f5&oe=5CEE1FEC',
          'https://scontent.fbkk10-1.fna.fbcdn.net/v/t1.0-9/16807275_1922978801259503_5735693159532495735_n.jpg?_nc_cat=105&_nc_eui2=AeFaqZHWDS2B8JR7TqnGcpJw_WQne79pzvaOLceds2kQn92AUAnPVrBd42fV7SAOsAjjQpP_5jSnrfvOAkSeiKzUaTraufZ9qtZE602NR3Gxwg&_nc_ht=scontent.fbkk10-1.fna&oh=1d4b7e99d605a3e6ac842a90d8c7ce7f&oe=5CF9E7B4',
          'https://scontent.fbkk10-1.fna.fbcdn.net/v/t1.0-9/44176786_2279472435459206_4450975553461157888_n.jpg?_nc_cat=109&_nc_eui2=AeGYEDH73xHKtWTO74ePBo0GQ1u6Odm2PX1TvIa7DweSVPbTx4b9Ej5aMQYEw6m-GvrtLbuU1IbQnhzta_u5a9fwQXZXfNqXyEmbJf8VXmotUw&_nc_ht=scontent.fbkk10-1.fna&oh=e90e5feaf53bb0ea4b803dc83e3d2550&oe=5CF6853D',
          'https://devilsworkshop.org/files/2013/01/enlarged-facebook-profile-picture.jpg',
          'https://www.freshmorningquotes.com/wp-content/uploads/2015/11/cute-and-beautifull-girls-profile-pictures.jpg',
          'https://2.bp.blogspot.com/-8ytYF7cfPkQ/WkPe1-rtrcI/AAAAAAAAGqU/FGfTDVgkcIwmOTtjLka51vineFBExJuSACLcBGAs/s320/31.jpg',
          'https://scontent.fbkk10-1.fna.fbcdn.net/v/t1.0-9/22814327_856803457816878_1210142063526678741_n.jpg?_nc_cat=107&_nc_eui2=AeFKqxuqW-KhHaRkR4DNmx_ECKTI0jlJ2ZYkSMjpCDTM-pNALp9qPKiONrzQchIUlNfNdhAG4FafGQlqqL0Q7UsEirFH9i5NJg50Cjk9V5RGYA&_nc_ht=scontent.fbkk10-1.fna&oh=a1e54980519c8ec5f44d3c8705d2260c&oe=5CF39055'
          ]
first_name = ['Catoon', 'Saharak', 'Tong', 'To', 'Pun', 'Pop', 'Lisa', 'Rose']
photos.each_with_index do |photo, index|
  ap "กำลังสร้าง ผู้ใช้ #{first_name[index]}"
  User.create!([{
      users: first_name[index],
      email: "#{first_name[index]}@mail.com",
      first_name: first_name[index],
      last_name: Faker::Name.last_name,
      password: "111111",
      password_confirmation: "111111",
      photo: photo
    }])
end
