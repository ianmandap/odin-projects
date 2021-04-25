// window.onload = function() {
//     changeGrid(8);
// };

// DOM SELECTORS
const gridContainer = document.querySelector('#grid-container');
const grid = document.querySelector('#grid');
const sizeButton = document.querySelector('#size');
const sizeInput = document.querySelector('#size-input');

// Grid Size Button
sizeButton.addEventListener('click', () => {
    sizeInput.focus();
})

// Change Grid Size
sizeInput.addEventListener('keydown', function(e) {
    if (e.keyCode === 13) {
        if (this.value > 64) {
            e.preventDefault();
        } else changeGrid(this.value);
    }
});

function changeGrid(num) {
    grid.innerHTML = createDivs(num);
    grid.setAttribute("style", "grid-template-columns: repeat(" + num + ", 1fr);"); 

    // add onhover per item
    var gridNodeList = document.querySelectorAll('.grid-item');
    for (let i =0; i < gridNodeList.length; i++) {
        console.log(gridNodeList[i]);
    }
}

function createDivs(num) {
    var sq = num*num;
    var divHTML = "";
    for (let i = 0; i < sq; i++) {divHTML += `<div class="grid-item"></div>`}
    return divHTML;
};

// Grid Item Hover


function randNum() {
    // generate random number from 0 to 255
    return Math.floor((Math.random()*256));
}

function randomRGBColor() {
    var R = randNum();
    var G = randNum();
    var B = randNum();
    this.setAttribute("style", "background-color: rgb( " + R + ", " + G + ", " + B + ");");
}