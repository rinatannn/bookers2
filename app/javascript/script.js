import Raty from "raty-js"

document.addEventListener("turbo:load", () => {
  const inputRaty = document.querySelector("#post_raty")

  if (inputRaty && !inputRaty.dataset.ratyInitialized) {
    new Raty(inputRaty, {
      scoreName: "book[score]",
      starType: "i",
      starOff: "star-off",
      starOn: "star-on"
    }).init()

    inputRaty.dataset.ratyInitialized = "true"
  }

  document.querySelectorAll(".book-rating").forEach((elem) => {
    if (elem.dataset.ratyInitialized) return

    new Raty(elem, {
      score: Number(elem.dataset.score),
      readOnly: true,
      starType: "i",
      starOff: "star-off",
      starOn: "star-on"
    }).init()

    elem.dataset.ratyInitialized = "true"
  })
})