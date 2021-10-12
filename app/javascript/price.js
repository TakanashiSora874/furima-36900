function price (){
  const articleText = document.getElementById("item-price");
  articleText.addEventListener("keyup", () => {
    const price = articleText.value;
    const taxPrice = document.getElementById("add-tax-price");
    const profit = document.getElementById("profit");
    taxPrice.innerHTML = Math.round(price / 10);
    profit.innerHTML = Math.round(price - (price / 10));
  });
};

window.addEventListener('load', price);