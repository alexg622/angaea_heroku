// $(document).on('turbolinks:load', () => {
//   showRatings()
//   showActivities()
//   showCreateActivityForm()
//   showCreateRentalForm()
// })
//
// const showRatings = function() {
//   let ratings = document.querySelector(".users-ratings-container")
//   let activities = document.querySelector(".users-activities-container")
//   let form = document.querySelector(".display-it-none")
//   let rentalForm = document.querySelector(".display-it-none-rental")
//   document.querySelector(".right-toggle").addEventListener("click", (e) => {
//     console.log(ratings.style.display);
//     ratings.style.display = "flex"
//     activities.style.display = "none"
//     form.style.display = "none"
//     rentalForm.style.display = "none"
//   })
// }
//
// const showActivities = function() {
//   let ratings = document.querySelector(".users-ratings-container")
//   let activities = document.querySelector(".users-activities-container")
//   let form = document.querySelector(".display-it-none")
//   let rentalForm = document.querySelector(".display-it-none-rental")
//   document.querySelector(".left-toggle").addEventListener("click", (e) => {
//     activities.style.display = "flex"
//     form.style.display = "none"
//     ratings.style.display = "none"
//     rentalForm.style.display = "none"
//   })
// }
//
// const showCreateActivityForm = function() {
//   let ratings = document.querySelector(".users-ratings-container")
//   let activities = document.querySelector(".users-activities-container")
//   let form = document.querySelector(".display-it-none")
//   let rentalForm = document.querySelector(".display-it-none-rental")
//   let toggleCreate = document.querySelector(".create-activity-toggle")
//   let toggleRental = document.querySelector(".create-rental-toggle")
//   if(toggleCreate && toggleRental) {
//     toggleCreate.addEventListener("click", (e) => {
//       ratings.style.display = "none"
//       activities.style.display = "none"
//       form.style.display = "flex"
//       rentalForm.style.display = "none"
//     })
//   }
// }
//
// const showCreateRentalForm = function() {
//   let ratings = document.querySelector(".users-ratings-container")
//   let activities = document.querySelector(".users-activities-container")
//   let form = document.querySelector(".display-it-none")
//   let rentalForm = document.querySelector(".display-it-none-rental")
//   let toggleCreate = document.querySelector(".create-activity-toggle")
//   let toggleRental = document.querySelector(".create-rental-toggle")
//   if(toggleCreate && toggleRental) {
//     toggleRental.addEventListener("click", (e) => {
//       ratings.style.display = "none"
//       activities.style.display = "none"
//       console.log(rentalForm);
//       form.style.display = "none"
//       rentalForm.style.display = "flex"
//     })
//   }
// }

// $(document).on('turbolinks:load', () => {
//   let images = document.querySelectorAll("img")
//   let imageLinks = [
//     "https://images.unsplash.com/photo-1507608869274-d3177c8bb4c7?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8ccfcc13bfcdfca6f54a8e043ffbe075&auto=format&fit=crop&w=1050&q=80",
//     "https://images.unsplash.com/photo-1505842465776-3b4953ca4f44?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=9389a98991d821a1ad3fd297c2a8df36&auto=format&fit=crop&w=500&q=60",
//     "https://images.unsplash.com/photo-1470753937643-efeb931202a9?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=605dda29d7945345968d2dfb3eeb672e&auto=format&fit=crop&w=1050&q=80",
//     "https://images.unsplash.com/photo-1468234847176-28606331216a?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=c82acc6a6472b4bfb4e5e4aa021f595e&auto=format&fit=crop&w=1615&q=80",
//     "https://images.unsplash.com/photo-1518890569493-668df9a00266?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6fddf752918d86ad929b90102c2d1ff5&auto=format&fit=crop&w=967&q=80",
//     "https://images.unsplash.com/photo-1505714628981-7273be3e2bd7?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=28c38074b63bc912283b769ccdbc55f5&auto=format&fit=crop&w=1500&q=80",
//     "https://images.unsplash.com/photo-1526039003500-f2f1cd73570e?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=1b80dfb6bd81dd2952f11d1a51826ef7&auto=format&fit=crop&w=1029&q=80",
//     "https://images.unsplash.com/photo-1470229722913-7c0e2dbbafd3?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=fb2264421ec008a297430e9e25f94eb3&auto=format&fit=crop&w=1500&q=80",
//     "https://images.unsplash.com/photo-1464986411762-a4275fbaf3f0?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=891934d8ecd2f94fd6ca17a8292202d6&auto=format&fit=crop&w=1051&q=80",
//     "https://images.unsplash.com/photo-1508997449629-303059a039c0?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=af90f024facc8921c9bf854da77f222a&auto=format&fit=crop&w=1050&q=80",
//     "https://images.unsplash.com/photo-1504680177321-2e6a879aac86?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a8111c411923b7c9dbfc11d87f5d9c48&auto=format&fit=crop&w=1500&q=80",
//     "https://images.unsplash.com/photo-1472698938026-79bed881e5b7?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6d7b7592c1d975088a9e7708ab4fe4d7&auto=format&fit=crop&w=1050&q=80",
//     "https://images.unsplash.com/photo-1507286722556-2d4b0704eeb3?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=370e9f5deeab128d01264bf3c5a49f6c&auto=format&fit=crop&w=676&q=80",
//     "https://images.unsplash.com/photo-1466150036782-869a824aeb25?ixlib=rb-0.3.5&s=db9e7fec550a8453779cd9b8d93f6087&auto=format&fit=crop&w=1050&q=80",
//     "https://images.unsplash.com/photo-1484876065684-b683cf17d276?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=e2c94316574bfeebd2f521acf160a35f&auto=format&fit=crop&w=634&q=80",
//     "https://images.unsplash.com/photo-1470229722913-7c0e2dbbafd3?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=fb2264421ec008a297430e9e25f94eb3&auto=format&fit=crop&w=1500&q=80",
//     "https://images.unsplash.com/photo-1520121270103-9b3adf3066e9?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=16deb96f08565696cbf31204292d1082&auto=format&fit=crop&w=700&q=80",
//     "https://images.unsplash.com/photo-1505253468034-514d2507d914?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=140e2054487a8f6f092fd6cda183cfac&auto=format&fit=crop&w=634&q=80",
//     "https://images.unsplash.com/photo-1485889397316-8393dd065127?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=e5a21d4bcefdc4d6b83a9a13c9452328&auto=format&fit=crop&w=1190&q=80",
//     "https://images.unsplash.com/photo-1470338745628-171cf53de3a8?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=b021b2cbe86640f8b50c8b24bc03b576&auto=format&fit=crop&w=634&q=80",
//     "https://images.unsplash.com/photo-1510511450816-30c68106b199?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=95c56fcf47f4a9e8613adf8a0f080966&auto=format&fit=crop&w=1050&q=80"
//   ]
//   let counter = 0;
//   for(let i=0; i<images.length; i++) {
//     if(images[i].src !== "https://github.com/hennyhandles/angaea/blob/master/app/assets/images/star.png?raw=true" && !Array.from(images[i].classList).includes("gravatar") && images[i].src !== "https://media.tenor.com/images/67d055fe6c00269a3ba31e1a7fc97107/tenor.gif") {
//       images[i].src = imageLinks[counter]
//       counter ++
//       if (counter > imageLinks.length) counter = 0
//     }
//   }
// })
